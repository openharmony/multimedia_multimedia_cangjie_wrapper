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

package ohos.multimedia.media

import ohos.labels.APILevel
import ohos.ffi.{SUCCESS_CODE, RemoteDataLite, releaseFFIData}
import ohos.business_exception.{BusinessException, getUniversalErrorMsg}
import ohos.callback_invoke.Callback3ArgumentWithReturn

foreign {
    func FfiCreateAVMetadataExtractor(): Int64

    func FfiFetchMetadata(id: Int64, data: CPointer<CMetaAVMetadata>): Int32

    func FfiAVMetadataExtractorGetFdSrc(id: Int64, fd: CPointer<CAVFileDescriptor>): Int32

    func FfiAVMetadataExtractorSetFdSrc(id: Int64, fd: CAVFileDescriptor): Int32

    func FfiAVMetadataExtractorRelease(id: Int64): Int32
}

/**
 * Creates an AVMetadataExtractor instance. 
 *
 * @returns { AVMetadataExtractor } An instance used to return AVMetadataExtractor instance
 * @throws { BusinessException } 5400101 - No memory.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
    throwexception: true,
    workerthread: true
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
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadataExtractor <: RemoteDataLite {
    init(id: Int64) {
        super(id)
        fdSrc = AVFileDescriptor(0)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Media file descriptor, which specifies the data source. Before obtaining metadata,
     * you must set the data source through either fdSrc or dataSrc.
     *
     * Example:
     *
     * There is a media file that stores continuous assets, the address offset is 0, and the byte length is 100.
     * Its file descriptor is AVFileDescriptor { fd = resourceHandle; offset = 0; length = 100; }.
     *
     * NOTE
     * After the resource handle (FD) is transferred to an AVMetadataExtractor instance,
     * do not use the resource handle to perform other read and write operations, including but not limited to
     * transferring this handle to other AVPlayer, AVMetadataExtractor, AVImageGenerator,
     * or AVTranscoder instance. Competition occurs when multiple AVMetadataExtractor use the same resource
     * handle to read and write files at the same time, resulting in errors in obtaining data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var fdSrc: AVFileDescriptor

    /**
     * It will extract the resource to fetch media meta data info.
     *
     * @returns { AVMetadata } A instance used to return when fetchMetadata completed.
     * @throws { BusinessException } 5400102 - Operation not allowed.
     * @throws { BusinessException } 5400106 - Unsupported format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
        throwexception: true,
        workerthread: true
    ]
    public func fetchMetadata(): AVMetadata {
        var data = CMetaAVMetadata()
        unsafe {
            let errCode = FfiFetchMetadata(getID(), inout data)
            throwIfNotSuccess(errCode, "AVMetadataExtractor", "fetch metadata")
            let result = data.toCJObject()
            data.free()
            result
        }
    }

    /**
     * Release resources used for AVMetadataExtractor.
     *
     * @throws { BusinessException } 5400102 - Operation not allowed.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
        throwexception: true,
        workerthread: true
    ]
    public func release(): Unit {
        let errCode = unsafe { FfiAVMetadataExtractorRelease(getID()) }
        throwIfNotSuccess(errCode, "AVMetadataExtractor", "release")
    }
}
