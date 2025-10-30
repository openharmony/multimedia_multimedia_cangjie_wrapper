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

package ohos.multimedia.image

import ohos.labels.APILevel
import ohos.ffi.{RemoteDataLite, releaseFFIData, safeMalloc}
import ohos.business_exception.BusinessException

foreign {
    func FfiOHOSImageGetClipRect(id: Int64, retVal: CPointer<CRegion>): UInt32

    func FfiOHOSImageGetSize(id: Int64, retVal: CPointer<CSize>): UInt32

    func FfiOHOSImageGetFormat(id: Int64, retVal: CPointer<Int32>): UInt32

    func FfiOHOSGetComponent(id: Int64, componentType: Int32, ptr: CPointer<CRetComponent>): UInt32

    func FfiOHOSImageRelease(id: Int64): Unit

    func FfiImageImageImplGetTimestamp(id: Int64): Int64
}

/**
 * Provides basic image operations, including obtaining image information, and reading and writing image data.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public class Image <: RemoteDataLite {
    /**
     * Gets the image area to crop, default is size.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public prop clipRect: Region {
        get() {
            unsafe {
                var cRegion = CRegion(CSize(0, 0), 0, 0)
                let result = FfiOHOSImageGetClipRect(getID(), inout cRegion)
                checkAndThrow(result)
                return Region(cRegion)
            }
        }
    }

    /**
     * Image size.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public prop size: Size {
        get() {
            unsafe {
                var cSize = CSize(0, 0)
                let result = FfiOHOSImageGetSize(getID(), inout cSize)
                checkAndThrow(result)
                return Size(cSize)
            }
        }
    }

    /**
     * Image format.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public prop format: Int32 {
        get() {
            unsafe {
                var ret: Int32 = 0
                let result = FfiOHOSImageGetFormat(getID(), inout ret)
                checkAndThrow(result)
                return ret
            }
        }
    }

    init(id: Int64) {
        super(id)
        IMAGE_LOG.info("[Image] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Get component buffer from image.
     *
     * @param { ComponentType } componentType - The component type of image.
     * @returns { Component } Return the component buffer.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getComponent(componentType: ComponentType): Component {
        unsafe {
            try (retPtr = safeMalloc<CRetComponent>().asResource()) {
                let errCode = FfiOHOSGetComponent(getID(), componentType.getValue(), retPtr.value)
                checkAndThrow(errCode)
                let cComponent = retPtr.value.read()
                try {
                    return Component(cComponent)
                } finally {
                    cComponent.free()
                }
            }
        }
        throw BusinessException(16000050, "Internal error.")
    }

    /**
     * Release current image to receive another.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func release(): Unit {
        unsafe { FfiOHOSImageRelease(getID()) }
        releaseFFIData(getID())
    }
}
