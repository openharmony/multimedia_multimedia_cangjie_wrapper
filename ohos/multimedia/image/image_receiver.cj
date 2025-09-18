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

package ohos.multimedia.image

import ohos.labels.*
import ohos.ffi.*
import ohos.business_exception.*
import ohos.callback_invoke.*

foreign {
    func FfiOHOSReceiverGetSize(id: Int64, retVal: CPointer<CSize>): UInt32

    func FfiOHOSReceiverGetCapacity(id: Int64, retVal: CPointer<Int32>): UInt32

    func FfiOHOSReceiverGetFormat(id: Int64, retVal: CPointer<Int32>): UInt32

    func FfiOHOSCreateImageReceiver(width: Int32, height: Int32, format: Int32, capacity: Int32): Int64

    func FfiOHOSGetReceivingSurfaceId(id: Int64): CString

    func FfiOHOSReadNextImage(id: Int64): Int64

    func FfiOHOSReadLatestImage(id: Int64): Int64

    func FfiOHOSReceiverRelease(id: Int64): Unit

    func FfiImageReceiverImplOn(id: Int64, name: CString, callbackId: Int64): UInt32
}

/**
 * Creates an ImageReceiver instance.
 *
 * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
 * @throws { BusinessException } 62980115 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
 * @relation function createImageReceiver(size: Size, format: ImageFormat, capacity: int): ImageReceiver
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
]
public func createImageReceiver(size: Size, format: ImageFormat, capacity: Int32): ImageReceiver {
    if (format != ImageFormat.Jpeg) {
        throw BusinessException(ERR_PARAMETER_ERROR, "Parameter error.")
    }
    let id = unsafe { FfiOHOSCreateImageReceiver(size.width, size.height, format.value, capacity) }
    if (id < 0) {
        throw BusinessException(INIT_ABNORMAL_ERROR, "Image initialization abnormal.")
    }
    return ImageReceiver(id)
}

/**
 * Image receiver object.
 *
 * @relation interface ImageReceiver
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
]
public class ImageReceiver <: RemoteDataLite {
    /**
     * Image size.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation readonly size: Size
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public prop size: Size {
        get() {
            unsafe {
                var cSize = CSize(0, 0)
                let res = FfiOHOSReceiverGetSize(getID(), inout cSize)
                checkAndThrow(res)
                return Size(cSize)
            }
        }
    }

    /**
     * Image capacity.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation readonly capacity: int
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public prop capacity: Int32 {
        get() {
            unsafe {
                var ret: Int32 = 0
                let result = FfiOHOSReceiverGetCapacity(getID(), inout ret)
                checkAndThrow(result)
                return ret
            }
        }
    }

    /**
     * Image format.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation readonly format: ImageFormat
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public prop format: ImageFormat {
        get() {
            unsafe {
                var value: Int32 = 0
                let result = FfiOHOSReceiverGetFormat(getID(), inout value)
                checkAndThrow(result)
                return ImageFormat.parse(value)
            }
        }
    }

    init(id: Int64) {
        super(id)
        IMAGE_LOG.info("[ImageReceiver] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Get an id which indicates a surface and can be used to set to Camera or other component can receive a surface.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation getReceivingSurfaceId(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func getReceivingSurfaceId(): String {
        let retData = unsafe {
            FfiOHOSGetReceivingSurfaceId(getID())
        }
        if (retData.isNull()) {
            throw BusinessException(INIT_ABNORMAL_ERROR, "Image initialization abnormal.")
        }
        let ret = retData.toString()
        IMAGE_LOG.info("[getReceivingSurfaceId] id: " + ret)
        unsafe { LibC.free(retData) }
        return ret
    }

    /**
     * Get lasted image from receiver.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation readLatestImage(): Promise<Image>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func readLatestImage(): Image {
        let res = unsafe { FfiOHOSReadLatestImage(getID()) }
        if (res < 0) {
            throw BusinessException(INIT_ABNORMAL_ERROR, "Image initialization abnormal.")
        }
        return Image(res)
    }

    /**
     * Get next image from receiver.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @relation readNextImage(): Promise<Image>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func readNextImage(): Image {
        let res = unsafe { FfiOHOSReadNextImage(getID()) }
        if (res < 0) {
            throw BusinessException(INIT_ABNORMAL_ERROR, "Image initialization abnormal.")
        }
        return Image(res)
    }

    /**
     * Subscribe callback when receiving an image.
     *
     * @relation on(type: 'imageArrival', callback: AsyncCallback<void>): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func on(eventType: ReceiveType, callback: Callback0Argument): Unit {
        let wrapper = { => callback.invoke(None) }
        let lambda = Callback0Param(wrapper)
        try (ctype = unsafe { LibC.mallocCString(eventType.toString()).asResource() }) {
            unsafe { FfiImageReceiverImplOn(getID(), ctype.value, lambda.getID()) }
        }
    }

    /**
     * Remove callback subscriptions when releasing buffer.
     *
     * @relation off(type: 'imageArrival', callback?: AsyncCallback<void>): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func off(eventType: ReceiveType): Unit {}

    /**
     * Release image receiver instance.
     *
     * @relation release(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    public func release(): Unit {
        unsafe { FfiOHOSReceiverRelease(getID()) }
        releaseFFIData(getID())
    }
}

/**
 * Enum of callback.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
]
public enum ReceiveType {
    /**
     * imageArrival.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    ImageArrival
    | ...

    protected func toString(): String {
        match (this) {
            case ImageArrival => "imageArrival"
            case _ => throw IllegalArgumentException("The type is not supported yet.")
        }
    }
}
