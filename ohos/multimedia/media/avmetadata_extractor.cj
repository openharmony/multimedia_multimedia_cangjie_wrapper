/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.multimedia.media

import ohos.ffi.*
import ohos.labels.*
import ohos.business_exception.*
import ohos.multimedia.image.PixelMap

foreign {
    func FfiCreateAVMetadataExtractor(): Int64

    // func FfiFetchMetadataV2(id: Int64, data: CPointer<CMetaAVMetadataV2>): Int32

    // func FfiFetchAlbumCoverV2(id: Int64): RetDataI64

    // func FfiAVMetadataExtractorGetFdSrcV2(id: Int64, fd: CPointer<CAVFileDescriptor>): Int32

    func FfiAVMetadataExtractorSetFdSrc(id: Int64, fd: CAVFileDescriptor): Int32

    // func FfiAVMetadataExtractorGetDataSrcV2(id: Int64, data: CPointer<CAVDataSrcDescriptor>): Int32

    func FfiAVMetadataExtractorSetDataSrc(id: Int64, data: CAVDataSrcDescriptor): Int32

    // func FfiAVMetadataExtractorReleaseV2(id: Int64): Int32
}

/**
 * Creates an AVMetadataExtractor instance.
 *
 * @returns { AVMetadataExtractor } Returns the AVMetadataExtractor instance.
 * @throws { BusinessException } 5400101 - No memory.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public func createAVMetadataExtractor(): AVMetadataExtractor {
    let id = unsafe {
        FfiCreateAVMetadataExtractor()
    }
    if (id == 0) {
        throw BusinessException(MEDIA_MEMORY_ERROR, "Create AVMetadataExtractor failed.")
    }
    return AVMetadataExtractor(id)
}

/**
 * Fetch media meta data or audio art picture from source. Before calling an AVMetadataExtractor method,
 * you must use createAVMetadataExtractor() to create an AVMetadataExtractor instance.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadataExtractor <: RemoteDataLite {
    protected var callback: (Array<UInt8>, UInt32, ?Int64) -> Int32

    init(id: Int64) {
        super(id)
        callback = {_, _, _ => Int32(0)}
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Media file descriptor, which specifies the data source. Before obtaining metadata,
     * you must set the data source through either **fdSrc** or **dataSrc**.
     *
     * @throws { BusinessException } 5400101 - No memory.
     * @throws { BusinessException } 5400102 - Operation not allowed.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public mut prop fdSrc: ?AVFileDescriptor {
        get() {
            unsafe {
                var fdSrc_ = CAVFileDescriptor(0, 0, 0)
                // let errCode = FfiAVMetadataExtractorGetFdSrcV2(getID(), inout fdSrc_)
                let errCode: Int32 = 0
                if (errCode == -1) {
                    return None<AVFileDescriptor>
                }
                throwIfNotSuccess(errCode, "AVMetadataExtractor", "get fdSrc")
                let result = fdSrc_.toCJObject()
                return result
            }
        }
        set(value) {
            if (let Some(v) <- value) {
                unsafe {
                    let fdSrc_ = CAVFileDescriptor(v)
                    let errCode = FfiAVMetadataExtractorSetFdSrc(getID(), fdSrc_)
                    throwIfNotSuccess(errCode, "AVMetadataExtractor", "set fdSrc")
                }
            }
        }
    }

    /**
     * Streaming media resource descriptor, which specifies the data source. Before obtaining metadata,
     * you must set the data source through either **fdSrc** or **dataSrc**.
     *
     * @throws { BusinessException } 5400101 - No memory.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public mut prop dataSrc: ?AVDataSrcDescriptor {
        get() {
            unsafe {
                var dataSrc_ = CAVDataSrcDescriptor(0, 0)
                // let errCode = FfiAVMetadataExtractorGetDataSrcV2(getID(), inout dataSrc_)
                let errCode: Int32 = 0
                if (errCode == -1) {
                    return None<AVDataSrcDescriptor>
                }
                throwIfNotSuccess(errCode, "AVMetadataExtractor", "get dataSrc")
                AVDataSrcDescriptor(dataSrc_.fileSize, this.callback)
            }
        }
        set(value) {
            if (let Some(v) <- value) {
                unsafe {
                    let wrapper: (CPointer<UInt8>, UInt32, Int64) -> Int32 = {
                        buffer: CPointer<UInt8>, length: UInt32, pos: Int64 =>
                        let pos_ = if (pos == -1) {
                            None<Int64>
                        } else {
                            pos
                        }
                        let arr = Array<UInt8>(Int64(length), repeat: 0)
                        let ret = v.callback(arr, length, pos_)
                        for (i in 0..Int64(length)) {
                            buffer.write(i, arr[i])
                        }
                        ret
                    }
                    let lambda = Callback3Param<CPointer<UInt8>, UInt32, Int64, Int32>(wrapper)
                    let val = CAVDataSrcDescriptor(v.fileSize, lambda.getID())
                    let errCode = FfiAVMetadataExtractorSetDataSrc(getID(), val)
                    throwIfNotSuccess(errCode, "AVMetadataExtractor", "set dataSrc")
                    this.callback = v.callback
                }
            }
        }
    }

    /**
     * Obtains media metadata.
     *
     * @returns { AVMetadata } Returns the AVMetadata instance.
     * @throws { BusinessException } 5400101 - No memory.
     * @throws { BusinessException } 5400102 - Operation not allowed.
     * @throws { BusinessException } 5400106 - Unsupported format.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public func fetchMetadata(): AVMetadata {
        var data = CMetaAVMetadataV2()
        unsafe {
            // let errCode = FfiFetchMetadataV2(getID(), inout data)
            let errCode = MEDIA_MEMORY_ERROR
            throwIfNotSuccess(errCode, "AVMetadataExtractor", "fetch metadata")
            let result = data.toCJObject()
            data.free()
            result
        }
    }

    /**
     * Obtains the cover of the audio album.
     *
     * @returns { PixelMap } Returns the PixelMap instance.
     * @throws { BusinessException } 5400101 - No memory.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public func fetchAlbumCover(): PixelMap {
        // let ret = unsafe { FfiFetchAlbumCoverV2(getID()) }
        let ret = RetDataI64(MEDIA_MEMORY_ERROR, 0)
        throwIfNotSuccess(ret.code, "AVMetadataExtractor", "fetch album cover")
        return PixelMap(ret.data)
    }

    /**
     * It will decode the given video resource. Then fetch a picture
     * at @timeUs according the given @options and @param .
     *
     * @param { Int64 } timeUs - The time expected to fetch picture from the video resource.
     * The unit is microsecond(us).
     * @param { AVImageQueryOptions } options - The time options about the relationship
     * between the given timeUs and a key frame, see @AVImageQueryOptions .
     * @param { PixelMapParams } param - The output pixel map format params, see @PixelMapParams .
     * @returns { PixelMap } Returns the PixelMap instance.
     * @throws { BusinessException } 5400101 - No memory.
     * @throws { BusinessException } 5400102 - Operation not allowed.
     * @throws { BusinessException } 5400106 - Unsupported format.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public func fetchFrameByTime(timeUs: Int64, options: AVImageQueryOptions, param: PixelMapParams): PixelMap {
        var cParam = CPixelMapParams(param)
        // let ret = FfiAVMetadataExtractorFetchFrameByTime(getID(), timeUs, options.getValue(), inout cParam)
        let ret = RetDataI64(MEDIA_MEMORY_ERROR, timeUs + Int64(options.getValue() + cParam.width_))
        throwIfNotSuccess(ret.code, "AVMetadataExtractor", "fetchFrameByTime")
        return PixelMap(ret.data)
    }

    /**
     * Release resources used for AVMetadataExtractor.
     * 
     * @throws { BusinessException } 5400101 - No memory.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public func release(): Unit {
        // let errCode = unsafe { FfiAVMetadataExtractorReleaseV2(getID()) }
        let errCode = MEDIA_MEMORY_ERROR
        throwIfNotSuccess(errCode, "AVMetadataExtractor", "release")
    }
}
