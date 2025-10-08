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
import ohos.business_exception.*
import ohos.multimedia.image.PixelMap
import ohos.labels.*

foreign {
    func FfiCreateAVImageGenerator(): Int64

    func FfiAVImageGeneratorGetFdSrc(id: Int64, fd: CPointer<CAVFileDescriptor>): Int32

    func FfiAVImageGeneratorSetFdSrc(id: Int64, fd: CAVFileDescriptor): Int32

    func FfiFetchFrameByTime(id: Int64, timeUs: Int64, option: Int32, param: CPixelMapParams): Int64

    func FfiAVImageGeneratorRelease(id: Int64): Int32
}

/**
* Creates an AVImageGenerator instance. The API can be used to obtain a video thumbnail.
*
* @throws { BusinessException } 5400101 - No memory.
*/
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public func createAVImageGenerator(): AVImageGenerator {
    let id = unsafe {
        FfiCreateAVImageGenerator()
    }
    if (id == 0) {
        throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
    }
    return AVImageGenerator(id)
}

/**
* Provides APIs to obtain a thumbnail from a video. Before calling any API of AVImageGenerator,
* you must use createAVImageGenerator to create an AVImageGenerator instance.
*/
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class AVImageGenerator <: RemoteDataLite {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Media file descriptor, which specifies the data source.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public mut prop fdSrc: AVFileDescriptor {
        get() {
            unsafe {
                var fdSrc_ = CAVFileDescriptor(0, 0, -1)
                let errCode = FfiAVImageGeneratorGetFdSrc(getID(), inout fdSrc_)
                throwIfNotSuccess(errCode, "AVImageGenerator", "get fdSrc")
                let result = fdSrc_.toCJObject()
                return result
            }
        }
        set(value) {
            unsafe {
                let fdSrc_ = CAVFileDescriptor(value)
                let errCode = FfiAVImageGeneratorSetFdSrc(getID(), fdSrc_)
                throwIfNotSuccess(errCode, "AVImageGenerator", "set fdSrc")
            }
        }
    }

    /**
     * Obtains a video thumbnail. This API uses a promise to return the result.
     *
     * @param { Int64 } timeUs - Time of the video for which a thumbnail is to be obtained, in μs.
     * @param { AVImageQueryOptions } options - Relationship between the time passed in and the video frame.
     * @param { PixelMapParams } param - Format parameters of the thumbnail to be obtained.
     * @returns { PixelMap } Promise used to return the video thumbnail.
     * @throws { BusinessException } 5400101 - No memory.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public func fetchFrameByTime(timeUs: Int64, options: AVImageQueryOptions, param: PixelMapParams): PixelMap {
        let cParam = CPixelMapParams(param)
        let ret = unsafe { FfiFetchFrameByTime(getID(), timeUs, options.getValue(), cParam) }
        if (ret <= 0) {
            throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
        }
        return PixelMap(ret)
    }

    /**
     * Releases this AVImageGenerator instance. 
     * 
     * @throws { BusinessException } 5400102 - Operation not allowed.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public func release(): Unit {
        let errCode = unsafe { FfiAVImageGeneratorRelease(getID()) }
        throwIfNotSuccess(errCode, "AVImageGenerator", "release")
    }
}
