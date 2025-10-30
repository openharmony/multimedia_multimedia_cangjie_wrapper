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

import ohos.graphics.color_space_manager.ColorSpaceManager
import ohos.labels.APILevel
import ohos.ffi.{RemoteDataLite, releaseFFIData}
import ohos.business_exception.BusinessException

const BASE_MEDIA_ERR: Int32 = 62980096
const ARG_SIZE_ONE: UIntNative = 1
const ARG_SIZE_TWO: UIntNative = 2

foreign {
    func FfiOHOSCreatePixelMap(colors: CPointer<UInt8>, colorLength: UInt32, opts: CInitializationOptions): Int64

    func FfiOHOSCreatePixelMapV2(colors: CPointer<UInt8>, colorLength: UInt32, opts: CInitializationOptionsV2): Int64

    func FfiImagePixelMapImplCreatePixelMap(opts: CInitializationOptionsV2): Int64

    func FfiImagePixelMapImplCreatePremultipliedPixelMap(srcId: Int64, dstId: Int64): UInt32

    func FfiImagePixelMapImplCreateUnpremultipliedPixelMap(srcId: Int64, dstId: Int64): UInt32

    func FfiOHOSReadPixelsToBuffer(id: Int64, bufferSize: UInt64, dst: CPointer<UInt8>): UInt32

    func FfiOHOSWriteBufferToPixels(id: Int64, source: CPointer<UInt8>, bufferSize: UInt64): UInt32

    func FfiOHOSGetDensity(id: Int64, errCode: CPointer<UInt32>): Int32

    func FfiOHOSOpacity(id: Int64, rate: Float32): UInt32

    func FfiOHOSCrop(id: Int64, region: CRegion): UInt32

    func FfiOHOSGetPixelBytesNumber(id: Int64, errCode: CPointer<UInt32>): UInt32

    func FfiOHOSGetBytesNumberPerRow(id: Int64, errCode: CPointer<UInt32>): UInt32

    func FfiOHOSGetImageInfo(id: Int64, errCode: CPointer<UInt32>): CImageInfo

    func FfiOHOSGetImageInfoV2(id: Int64, errCode: CPointer<UInt32>): CImageInfoV2

    func FfiOHOSScale(id: Int64, x: Float32, y: Float32): UInt32

    func FfiImagePixelMapImplScale(id: Int64, x: Float32, y: Float32, antiAliasing: Int32): UInt32

    func FfiOHOSFlip(id: Int64, horizontal: Bool, vertical: Bool): UInt32

    func FfiOHOSRotate(id: Int64, angle: Float32): UInt32

    func FfiOHOSTranslate(id: Int64, x: Float32, y: Float32): UInt32

    func FfiOHOSGetIsEditable(id: Int64, errCode: CPointer<UInt32>): Bool

    func FfiOHOSGetIsStrideAlignment(id: Int64, errCode: CPointer<UInt32>): Bool

    func FfiOHOSReadPixels(id: Int64, area: CPositionArea): UInt32

    func FfiOHOSWritePixels(id: Int64, area: CPositionArea): UInt32

    func FfiOHOSCreateAlphaPixelMap(id: Int64, errCode: CPointer<UInt32>): Int64

    func FfiOHOSPixelMapRelease(id: Int64): UInt32

    func FfiOHOSPixelMapSetColorSpace(id: Int64, colorSpaceId: Int64): UInt32

    func FfiOHOSPixelMapGetColorSpace(id: Int64, errCode: CPointer<UInt32>): Int64

    func FfiOHOSPixelMapApplyColorSpace(id: Int64, colorSpaceId: Int64): UInt32

    func FfiImagePixelMapImplToSdr(id: Int64): UInt32

    func FfiImagePixelMapImplMarshalling(id: Int64, rpcId: Int64): UInt32

    func FfiImagePixelMapImplUnmarshalling(id: Int64, rpcId: Int64, errCode: CPointer<UInt32>): Int64

    func FfiImagePixelMapImplConvertPixelMapFormat(id: Int64, targetFormat: Int32): UInt32

    func FfiImagePixelMapImplCreatePixelMapFromSurface(surfaceId: CString, rect: CRegion, argc: UIntNative,
        errCode: CPointer<UInt32>): Int64

    func FfiImagePixelMapImplCreatePixelMapFromParcel(rpcId: Int64, errCode: CPointer<UInt32>): Int64
}

/**
 * Create pixelmap by data buffer.
 *
 * @param { Array<UInt8> } colors - The image color buffer.
 * @param { InitializationOptions } options - Initialization options for pixelmap.
 * @returns { PixelMap } Return the PixelMap object.
 * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
 * @throws { BusinessException } 62980115 - Parameter error. Possible causes: 1.Mandatory parameters are left
 * unspecified.
 * 2.Incorrect parameter types. 3.Parameter verification failed.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public func createPixelMap(colors: Array<UInt8>, options: InitializationOptions): PixelMap {
    if (colors.size == 0) {
        throw BusinessException(ERR_PARAMETER_ERROR, "Invalid image parameter.")
    }
    unsafe {
        let arrPtr = acquireArrayRawData(colors)
        let id = FfiOHOSCreatePixelMapV2(arrPtr.pointer, UInt32(colors.size), options.toExternal())
        releaseArrayRawData(arrPtr)
        if (id <= 0) {
            throw BusinessException(INIT_ABNORMAL_ERROR, "Image initialization abnormal.")
        }
        return PixelMap(id)
    }
}

/**
 * PixelMap instance.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public class PixelMap <: RemoteDataLite {
    protected init(id: Int64) {
        super(id)
        IMAGE_LOG.info("[PixelMap] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Whether the image pixel map can be edited.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public prop isEditable: Bool {
        get() {
            unsafe {
                var errCode: UInt32 = 0
                let res = FfiOHOSGetIsEditable(getID(), inout errCode)
                checkAndThrow(errCode)
                return res
            }
        }
    }

    /**
     * Is it stride Alignment.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public prop isStrideAlignment: Bool {
        get() {
            unsafe {
                var errCode: UInt32 = 0
                let res = FfiOHOSGetIsStrideAlignment(getID(), inout errCode)
                checkAndThrow(errCode)
                return res
            }
        }
    }

    /**
     * Releases this PixelMap object.
     *
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func release(): Unit {
        unsafe {
            let ret = FfiOHOSPixelMapRelease(getID())
            checkAndThrow(ret)
            releaseFFIData(getID())
        }
        IMAGE_LOG.info("[PixelMap] ffi release success")
    }

    /**
     * Reads image pixel map data and writes the data to an ArrayBuffer.
     *
     * @param { Array<UInt8> } dst A buffer to which the image pixel map data will be written.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func readPixelsToBuffer(dst: Array<UInt8>): Unit {
        unsafe {
            var arrPtr = acquireArrayRawData(dst)
            let ret = FfiOHOSReadPixelsToBuffer(getID(), UInt64(dst.size), arrPtr.pointer)
            releaseArrayRawData(arrPtr)
            checkAndThrow(ret)
        }
    }

    /**
     * Reads image data in an ArrayBuffer and writes the data to a PixelMap object. 
     *
     * @param { Array<UInt8> } src A buffer from which the image data will be read.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func writeBufferToPixels(src: Array<UInt8>): Unit {
        unsafe {
            let arrPtr = acquireArrayRawData(src)
            let ret = FfiOHOSWriteBufferToPixels(getID(), arrPtr.pointer, UInt64(src.size))
            releaseArrayRawData(arrPtr)
            checkAndThrow(ret)
        }
    }

    /**
     * Obtains pixel map information about this image. 
     *
     * @returns { ImageInfo } An instance used to return the image pixel map information.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getImageInfo(): ImageInfo {
        unsafe {
            var errCode: UInt32 = 0
            let cimage = FfiOHOSGetImageInfoV2(getID(), inout errCode)
            checkAndThrow(errCode)
            try {
                return cimage.toImageInfo()
            } finally {
                cimage.free()
            }
        }
    }

    /**
     * Obtains the number of bytes in each line of the image pixel map.
     *
     * @returns { UInt32 } Number of bytes in each line.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getBytesNumberPerRow(): UInt32 {
        unsafe {
            var errCode: UInt32 = 0
            let res = FfiOHOSGetBytesNumberPerRow(getID(), inout errCode)
            checkAndThrow(errCode)
            return res
        }
    }

    /**
     * Obtains the total number of bytes of the image pixel map.
     *
     * @returns { UInt32 } Total number of bytes.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getPixelBytesNumber(): UInt32 {
        unsafe {
            var errCode: UInt32 = 0
            let res = FfiOHOSGetPixelBytesNumber(getID(), inout errCode)
            checkAndThrow(errCode)
            return res
        }
    }

    /**
     * Obtains the density of the image pixel map.
     *
     * @returns { Int32 } The number of density.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getDensity(): Int32 {
        unsafe {
            var errCode: UInt32 = 0
            let res = FfiOHOSGetDensity(getID(), inout errCode)
            checkAndThrow(errCode)
            return res
        }
    }

    /**
     * Set the transparent rate of pixel map.
     *
     * @param { Float32 } rate The value of transparent rate.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func opacity(rate: Float32): Unit {
        unsafe {
            let ret = FfiOHOSOpacity(getID(), rate)
            checkAndThrow(ret)
        }
    }

    /**
     * Image zoom in width and height.
     *
     * @param { Float32 } x The zoom value of width.
     * @param { Float32 } y The zoom value of height.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func scale(x: Float32, y: Float32): Unit {
        unsafe {
            let ret = FfiOHOSScale(getID(), x, y)
            checkAndThrow(ret)
        }
    }

    /**
     * Image position transformation.
     *
     * @param { Float32 } x The position value of width.
     * @param { Float32 } y The position value of height.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func translate(x: Float32, y: Float32): Unit {
        unsafe {
            let ret = FfiOHOSTranslate(getID(), x, y)
            checkAndThrow(ret)
        }
    }

    /**
     * Image rotation.
     *
     * @param { Float32 } angle The rotation angle.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func rotate(angle: Float32): Unit {
        unsafe {
            let ret = FfiOHOSRotate(getID(), angle)
            checkAndThrow(ret)
        }
    }

    /**
     * Image flipping. 
     *
     * @param { Bool } horizontal Is flip in horizontal.
     * @param { Bool } vertical Is flip in vertical.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func flip(horizontal: Bool, vertical: Bool): Unit {
        unsafe {
            let ret = FfiOHOSFlip(getID(), horizontal, vertical)
            checkAndThrow(ret)
        }
    }

    /**
     * Crop the image.
     *
     * @param { Region } region The region to crop.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func crop(region: Region): Unit {
        unsafe {
            let ret = FfiOHOSCrop(getID(), region.toExternal())
            checkAndThrow(ret)
        }
    }

    /**
     * Writes image pixel map data to the specified area. 
     *
     * @param { PositionArea } area Area to which the image pixel map data will be written.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func writePixels(area: PositionArea): Unit {
        unsafe {
            let arrPtr = acquireArrayRawData(area.pixels)
            let ret = FfiOHOSWritePixels(
                getID(),
                CPositionArea(UInt64(area.pixels.size), area.offset, area.stride, area.region.toExternal(),
                    arrPtr.pointer)
            )
            releaseArrayRawData(arrPtr)
            checkAndThrow(ret)
        }
    }

    /**
     * Reads image pixel map data in an area. This method return the data read.
     *
     * @param { PositionArea } area Area from which the image pixel map data will be read.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func readPixels(area: PositionArea): Unit {
        unsafe {
            let arrPtr = acquireArrayRawData(area.pixels)
            let ret = FfiOHOSReadPixels(
                getID(),
                CPositionArea(UInt64(area.pixels.size), area.offset, area.stride, area.region.toExternal(),
                    arrPtr.pointer)
            )
            releaseArrayRawData(arrPtr)
            checkAndThrow(ret)
        }
    }

    /**
     * Obtains new pixel map with alpha information. 
     *
     * @returns { PixelMap } An instance used to return the new image pixel map.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func createAlphaPixelmap(): PixelMap {
        unsafe {
            var errCode: UInt32 = 0
            let id = FfiOHOSCreateAlphaPixelMap(getID(), inout errCode)
            checkAndThrow(errCode)
            return PixelMap(id)
        }
    }

    /**
     * Set color space of pixel map.
     *
     * @param { ColorSpaceManager } colorSpace The color space for pixel map.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @throws { BusinessException } 62980111 - The image source data is incomplete.
     * @throws { BusinessException } 62980115 - If the image parameter invalid.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func setColorSpace(colorSpace: ColorSpaceManager): Unit {
        unsafe {
            let ret = FfiOHOSPixelMapSetColorSpace(getID(), colorSpace.getID())
            checkAndThrow(ret)
        }
    }

    /**
     * Get color space of pixel map.
     *
     * @throws { BusinessException } 62980101 - If the image data abnormal.
     * @throws { BusinessException } 62980103 - If the image data unsupport.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @throws { BusinessException } 62980115 - If the image parameter invalid.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func getColorSpace(): ColorSpaceManager {
        unsafe {
            var errCode: UInt32 = 0
            let colorSpaceId = FfiOHOSPixelMapGetColorSpace(getID(), inout errCode)
            checkAndThrow(errCode)
            return ColorSpaceManager(colorSpaceId)
        }
    }

    /**
     * Apply color space of pixel map, the pixels will be changed by input color space.
     *
     * @param { ColorSpaceManager } targetColorSpace - The color space for pixel map.
     * @throws { BusinessException } 62980104 - Failed to initialize the internal object.
     * @throws { BusinessException } 62980108 - Failed to convert the color space.
     * @throws { BusinessException } 62980115 - Invalid image parameter.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func applyColorSpace(targetColorSpace: ColorSpaceManager): Unit {
        unsafe {
            let ret = FfiOHOSPixelMapApplyColorSpace(getID(), targetColorSpace.getID())
            checkAndThrow(ret)
        }
    }
}
