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

package ohos_app_cangjie_entry

import kit.ImageKit.Component as ImageComponent
import kit.ImageKit.Image as ImageImage
import kit.ImageKit.*
import std.convert.*
import std.io.*
import kit.CoreFileKit.*
import kit.ArkGraphics2D.*
import std.process.*
import std.math.*
import std.unittest.testmacro.*
import ohos.base.*
import std.runtime.*
import std.sync.*
import std.time.*
internal import ohos.resource_manager.RawFileDescriptor
internal import ohos.resource_manager.ResourceManager
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.business_exception.*
import kit.CoreFileKit.*
import kit.PerformanceAnalysisKit.Hilog
import ohos.callback_invoke.*

let colors: Array<UInt8> = Array<UInt8>(96, repeat: 0)
let pixelMap = createPixelMap(colors,
    InitializationOptions(Size(4, 6), editable: true, pixelFormat: Rgba8888))
let imageSource = createImageSource(hw)
let sourceOption = SourceOptions(0, sourcePixelFormat: Bgra8888)

@Test
class Test_image {
    override func afterAll(): Unit {
        gc()
        sleep(Duration.second)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Packer_01(): Unit {
        let imagePacker = createImagePacker()
        let supportedFormats = imagePacker.supportedFormats
        @Expect(supportedFormats.toString(), "[image/gif, image/heic, image/jpeg, image/png, image/webp]")
        unsafe {
            let format = "image/jpeg"
            let packingOption = PackingOption(format, 98)
            let packFormat = packingOption.format
            @Expect(packFormat.toString(), "image/jpeg")
            let packRes = imagePacker.packToData(pixelMap, packingOption)
            @Expect(packRes.size, 759)
            let filePath = "data/storage/el1/base/temp.txt"
            let file = FileIo.open(
                filePath,
                mode: (OpenMode.CREATE | OpenMode.READ_WRITE)
            )
            imagePacker.packToFile(pixelMap, file.fd, packingOption)
            FileIo.close(file)
            imagePacker.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Packer_02(): Unit {
        let imagePacker = createImagePacker()
        unsafe {
            let format = "image/jpeg"
            let packingOption = PackingOption(format, 50)
            let packRes = imagePacker.packToData(imageSource, packingOption)
            @Expect(packRes.size, 4199)
            let filePath = "data/storage/el1/base/temp.txt"
            let file = FileIo.open(
                filePath,
                mode: (OpenMode.CREATE | OpenMode.READ_WRITE)
            )
            imagePacker.packToFile(imageSource, file.fd, packingOption)
            FileIo.close(file)
            imagePacker.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageReceive(): Unit {
        var imageReceiver = createImageReceiver(Size(8, 8192), ImageFormat.Jpeg, 8)
        @Expect(imageReceiver.size.width, 8192)
        @Expect(imageReceiver.size.height, 8)
        @Expect(imageReceiver.format, ImageFormat.Jpeg)
        @Expect(imageReceiver.capacity, 8)
        let id = imageReceiver.getReceivingSurfaceId()
        @Expect(Int64.tryParse(id).isSome(), true)
        imageReceiver.release()

        try {
            imageReceiver = createImageReceiver(Size(8, 8192), ImageFormat.Ycbcr422Sp, 8)
            @Expect(imageReceiver.format, ImageFormat.Ycbcr422Sp)
            imageReceiver.release()
        } catch (e: Exception) {
            @Expect(e.message, "Parameter error.")
            //logger.info("createImageReceiver ImageFormat.Ycbcr422Sp: ${e}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageReceive_exception(): Unit {
        try {
            let imageReceiver = createImageReceiver(Size(8, 8192), ImageFormat.Jpeg, 8)
            try {
                let img1 = imageReceiver.readLatestImage()
                let cmp = img1.getComponent(ComponentType.Jpeg)
                let ret1 = img1.clipRect
                let ret2 = img1.size
                let ret3 = img1.format
            } catch (e: Exception) {
                Hilog.info(0, "CangjieTest", "readLatestImage error ${e}")
            }

            try {
                let img2 = imageReceiver.readNextImage()
            } catch (e: Exception) {
                Hilog.info(0, "CangjieTest", "readNextImage error ${e}")
            }
            imageReceiver.release()
        } catch (e: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageReceive_OnOff(): Unit {
        try {
            let imageReceiver = createImageReceiver(Size(8, 8192), ImageFormat.Jpeg, 8)
            imageReceiver.on(ReceiveType.ImageArrival, ImageReceiverCallback())
            sleepFor(Duration.second)
            imageReceiver.off(ReceiveType.ImageArrival)
            imageReceiver.release()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageReceive_readImage(): Unit {
        try {
            let imageReceiver = createImageReceiver(Size(-1, -1), ImageFormat.Jpeg, 8)
        } catch (e: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_PixelMap_01(): Unit {
        @Expect(pixelMap.isEditable, true)
        @Expect(pixelMap.isStrideAlignment, false)
        let imageInfo = pixelMap.getImageInfo()
        @Expect(imageInfo.size.width, 6)
        @Expect(imageInfo.size.height, 4)
        //        @Expect(imageInfo.density, 0)
        @Expect(pixelMap.getDensity(), 0)
        @Expect(pixelMap.getBytesNumberPerRow(),24)
        @Expect(pixelMap.getPixelBytesNumber(),96)
        var buffer = Array<UInt8>(96, repeat: 0)
        pixelMap.readPixelsToBuffer(buffer)
        @Expect(buffer, colors)

        //from artks
        let buf1 = Array<UInt8>(8, {i => UInt8(i + 1)})
        var area = PositionArea(buf1, 0, 8, Region(Size(1, 2), 0, 0))
        pixelMap.writePixels(area)
        let expect: Array<UInt8> = [0, 0, 0, 4, 0, 0, 0, 8]
        let buf2 = Array<UInt8>(8, repeat: 0)
        area = PositionArea(buf2, 0, 8, Region(Size(1, 2), 0, 0))
        pixelMap.readPixels(area)
        @Expect(expect, buf2)

        buffer = Array<UInt8>(96, {i => UInt8(i)})
        pixelMap.writeBufferToPixels(buffer)
        pixelMap.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageSource_01(): Unit {
        @Expect(imageSource.getFrameCount(), 1)
        let imageInfo = imageSource.getImageInfo()
        @Expect(imageInfo.size.width, 200)
        @Expect(imageInfo.size.height, 200)
        let formats = imageSource.supportedFormats
        @Expect(formats.size >= 0)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageSource_02(): Unit {
        try {
            let buf: Array<UInt8> = [1, 2, 3]
            imageSource.updateData(buf, false, 0, 1)
        } catch (e: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_PixelMap_02(): Unit {
        let pMap = imageSource.createPixelMap()
        let imageInfo = pMap.getImageInfo()
        //logger.error("ohos density is ${imageInfo.density}")
        @Expect(imageInfo.size.width, 200)
        @Expect(imageInfo.size.height, 200)
        //        @Expect(imageInfo.density, 0)

        pMap.opacity(0.5f32)
        pMap.scale(2.0f32, 1.0f32)
        pMap.translate(50.0f32, 10.0f32)
        pMap.rotate(90.0f32)
        pMap.flip(true, false)
        let region = Region(Size(100, 100), 0, 0)
        pMap.crop(region)
        let alphaPixelMap = pMap.createAlphaPixelmap()
        var colorSpaceManager = create(AdobeRgb1998)
        alphaPixelMap.setColorSpace(colorSpaceManager)
        let colorSpace1 = alphaPixelMap.getColorSpace()
        @Expect(colorSpace1.getColorSpaceName().toString(), "ColorSpace.AdobeRgb1998")
        colorSpaceManager = create(Srgb)
        alphaPixelMap.applyColorSpace(colorSpaceManager)
        let colorSpace2 = alphaPixelMap.getColorSpace()
        @Expect(colorSpace2.getColorSpaceName().toString(), "ColorSpace.Srgb")
        alphaPixelMap.release()
        pMap.release()
        imageSource.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageSource_03(): Unit {
        let bufSource = createImageSource(hw, sourceOption)
        let maps = bufSource.createPixelMapList()
        @Expect(maps.size, 1)
        try {
            bufSource.getImageProperty(ImageLength, options: ImagePropertyOptions())
        } catch (e: BusinessException) {
            @Expect(e.message, "Image decoding exif support.")
        }
        try {
            bufSource.modifyImageProperty(ImageLength, "200")
        } catch (e: BusinessException) {
            @Expect(e.message, "The EXIF data failed to be written to the file.")
        }
        try {
            bufSource.getDelayTimeList()
        } catch (e: BusinessException) {
            @Expect(e.code,62980149)
            @Expect(e.message, "Invalid MIME type for the image source.")
        }
        bufSource.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageSource_04(): Unit {
        try {
            let imgSource = createImageSource("data/storage/el1/base/EXIF.jpg", sourceOption)
        } catch (e: BusinessException) {
            //logger.info("${e}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_01(): Unit {
        try {
            createImageSource("")
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_02(): Unit {
        try {
            createImageSource("", sourceOption)
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_03(): Unit {
        try {
            createImageSource([])
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_04(): Unit {
        try {
            createImageSource([], sourceOption)
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_05(): Unit {
        try {
            createImageSource(0)
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Exception_06(): Unit {
        try {
            createImageSource(0, sourceOption)
        } catch (e: BusinessException) {
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_PropertyKey(): Unit {
        @Expect(ImageWidth.toString(), "ImageWidth")
        @Expect(ImageLength.toString(), "ImageLength")
        @Expect(BitsPerSample.toString(), "BitsPerSample")
        @Expect(ImageDescription.toString(), "ImageDescription")
        @Expect(Make.toString(), "Make")
        @Expect(Model.toString(), "Model")
        @Expect(Orientation.toString(), "Orientation")
        @Expect(PropertyKey.DateTime.toString(), "DateTime")
        @Expect(PhotoMode.toString(), "PhotoMode")
        @Expect(ExposureTime.toString(), "ExposureTime")
        @Expect(FNumber.toString(), "FNumber")
        @Expect(GpsLatitudeRef.toString(), "GPSLatitudeRef")
        @Expect(GpsLatitude.toString(), "GPSLatitude")
        @Expect(GpsLongitudeRef.toString(), "GPSLongitudeRef")
        @Expect(GpsLongitude.toString(), "GPSLongitude")
        @Expect(GpsTimeStamp.toString(), "GPSTimeStamp")
        @Expect(GpsDateStamp.toString(), "GPSDateStamp")
        @Expect(IsoSpeedRatings.toString(), "ISOSpeedRatings")
        @Expect(SensitivityType.toString(), "SensitivityType")
        @Expect(StandardOutputSensitivity.toString(), "StandardOutputSensitivity")
        @Expect(RecommendedExposureIndex.toString(), "RecommendedExposureIndex")
        @Expect(IsoSpeed.toString(), "ISOSpeedRatings")
        @Expect(DateTimeOriginal.toString(), "DateTimeOriginal")
        @Expect(ApertureValue.toString(), "ApertureValue")
        @Expect(ExposureBiasValue.toString(), "ExposureBiasValue")
        @Expect(MeteringMode.toString(), "MeteringMode")
        @Expect(LightSource.toString(), "LightSource")
        @Expect(Flash.toString(), "Flash")
        @Expect(FocalLength.toString(), "FocalLength")
        @Expect(SceneFoodConf.toString(), "HwMnoteSceneFoodConf")
        @Expect(SceneStageConf.toString(), "HwMnoteSceneStageConf")
        @Expect(SceneBlueSkyConf.toString(), "HwMnoteSceneBlueSkyConf")
        @Expect(SceneGreenPlantConf.toString(), "HwMnoteSceneGreenPlantConf")
        @Expect(SceneBeachConf.toString(), "HwMnoteSceneBeachConf")
        @Expect(SceneSnowConf.toString(), "HwMnoteSceneSnowConf")
        @Expect(SceneSunsetConf.toString(), "HwMnoteSceneSunsetConf")
        @Expect(SceneFlowersConf.toString(), "HwMnoteSceneFlowersConf")
        @Expect(SceneNightConf.toString(), "HwMnoteSceneNightConf")
        @Expect(SceneTextConf.toString(), "HwMnoteSceneTextConf")
        @Expect(FaceCount.toString(), "HwMnoteFaceCount")
        @Expect(CaptureMode.toString(), "HwMnoteCaptureMode")
        @Expect(RollAngle.toString(), "HwMnoteRollAngle")
        @Expect(PitchAngle.toString(), "HwMnotePitchAngle")
        @Expect(PhysicalAperture.toString(), "HwMnotePhysicalAperture")
        @Expect(FocusMode.toString(), "HwMnoteFocusMode")
        @Expect(UserComment.toString(), "UserComment")
        @Expect(PixelXDimension.toString(), "PixelXDimension")
        @Expect(PixelYDimension.toString(), "PixelYDimension")
        @Expect(SceneType.toString(), "SceneType")
        @Expect(WhiteBalance.toString(), "WhiteBalance")
        @Expect(FocalLengthIn35mmFilm.toString(), "FocalLengthIn35mmFilm")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Enum_03(): Unit {
        @Expect(PixelMapFormat.Unknown, PixelMapFormat.Unknown)
        @Expect(Rgb565, Rgb565)
        @Expect(Rgba8888, Rgba8888)
        @Expect(Bgra8888, Bgra8888)
        @Expect(Rgb888, Rgb888)
        @Expect(Alpha8, Alpha8)
        @Expect(RgbaF16, RgbaF16)
        @Expect(Nv21, Nv21)
        @Expect(Nv12, Nv12)
        @Expect(AlphaType.Unknown, AlphaType.Unknown)
        @Expect(Opaque, Opaque)
        @Expect(Premul, Premul)
        @Expect(UnPremul, UnPremul)
        @Expect(FitTargetSize, FitTargetSize)
        @Expect(CenterCrop, CenterCrop)
        @Expect(Ycbcr422Sp, Ycbcr422Sp)
        @Expect(ImageFormat.Jpeg, ImageFormat.Jpeg)
        @Expect(YuvY, YuvY)
        @Expect(YuvU, YuvU)
        @Expect(YuvV, YuvV)
        @Expect(ComponentType.Jpeg, ComponentType.Jpeg)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_PackingDynamicRange(): Unit {
        @Expect(PackingDynamicRange.Auto, PackingDynamicRange.Auto)
        @Expect(PackingDynamicRange.Sdr, PackingDynamicRange.Sdr)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_createPremultipliedPixelMap_error(): Unit {
        let color = Array<UInt8>(0, repeat: 0)
        let opts = InitializationOptions(Size(2, 2), editable: true, pixelFormat: Rgba8888,
            alphaType: UnPremul)
        try {
            let srcPixelmap = createPixelMap(color, opts)
        } catch (e: BusinessException) {
            //logger.info("test_createPremultipliedPixelMap_error is ${e}")
            @Expect(e.message, "Invalid image parameter.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DecodingDynamicRange(): Unit {
        var opt = DecodingOptions(desiredDynamicRange: DecodingDynamicRange.Auto)
        opt = DecodingOptions(desiredDynamicRange: DecodingDynamicRange.Sdr)
        opt = DecodingOptions(desiredDynamicRange: DecodingDynamicRange.Hdr)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_createImageSource_rawfd(): Unit {
        try {
            let resMgr = getAbilityContext().resourceManager
            let jpg = resMgr.getRawFd("test.jpg")
            let imageSource = createImageSource(jpg)
            resMgr.closeRawFd("test.jpg")
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ComponentType() {
        let enumArray: Array<ComponentType> = [YuvY, YuvU, YuvV, Jpeg]
        let enumArray2: Array<ComponentType> = [YuvY, YuvU, YuvV, Jpeg]
        let strArray: Array<String> = [
            "ComponentType.YuvY",
            "ComponentType.YuvU",
            "ComponentType.YuvV",
            "ComponentType.Jpeg"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_EnumPropertyKey() {
        let enumArray: Array<PropertyKey> = [
            ImageWidth,
            ImageLength,
            BitsPerSample,
            ImageDescription,
            Make,
            Model,
            Orientation,
            PropertyKey.DateTime,
            PhotoMode,
            ExposureTime,
            FNumber,
            GpsLatitudeRef,
            GpsLatitude,
            GpsLongitudeRef,
            GpsLongitude,
            GpsTimeStamp,
            GpsDateStamp,
            IsoSpeedRatings,
            SensitivityType,
            StandardOutputSensitivity,
            RecommendedExposureIndex,
            IsoSpeed,
            DateTimeOriginal,
            ApertureValue,
            ExposureBiasValue,
            MeteringMode,
            LightSource,
            Flash,
            FocalLength,
            SceneFoodConf,
            SceneStageConf,
            SceneBlueSkyConf,
            SceneGreenPlantConf,
            SceneBeachConf,
            SceneSnowConf,
            SceneSunsetConf,
            SceneFlowersConf,
            SceneNightConf,
            SceneTextConf,
            FaceCount,
            CaptureMode,
            RollAngle,
            PitchAngle,
            PhysicalAperture,
            FocusMode,
            UserComment,
            PixelXDimension,
            PixelYDimension,
            SceneType,
            WhiteBalance,
            FocalLengthIn35mmFilm
        ]
        let strArray: Array<String> = [
            "ImageWidth",
            "ImageLength",
            "BitsPerSample",
            "ImageDescription",
            "Make",
            "Model",
            "Orientation",
            "DateTime",
            "PhotoMode",
            "ExposureTime",
            "FNumber",
            "GPSLatitudeRef",
            "GPSLatitude",
            "GPSLongitudeRef",
            "GPSLongitude",
            "GPSTimeStamp",
            "GPSDateStamp",
            "ISOSpeedRatings",
            "SensitivityType",
            "StandardOutputSensitivity",
            "RecommendedExposureIndex",
            "ISOSpeedRatings",
            "DateTimeOriginal",
            "ApertureValue",
            "ExposureBiasValue",
            "MeteringMode",
            "LightSource",
            "Flash",
            "FocalLength",
            "HwMnoteSceneFoodConf",
            "HwMnoteSceneStageConf",
            "HwMnoteSceneBlueSkyConf",
            "HwMnoteSceneGreenPlantConf",
            "HwMnoteSceneBeachConf",
            "HwMnoteSceneSnowConf",
            "HwMnoteSceneSunsetConf",
            "HwMnoteSceneFlowersConf",
            "HwMnoteSceneNightConf",
            "HwMnoteSceneTextConf",
            "HwMnoteFaceCount",
            "HwMnoteCaptureMode",
            "HwMnoteRollAngle",
            "HwMnotePitchAngle",
            "HwMnotePhysicalAperture",
            "HwMnoteFocusMode",
            "UserComment",
            "PixelXDimension",
            "PixelYDimension",
            "SceneType",
            "WhiteBalance",
            "FocalLengthIn35mmFilm"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_PixelMapFormat() {
        let enumArray: Array<PixelMapFormat> = [
            Unknown,
            Rgb565,
            Rgba8888,
            Bgra8888,
            Rgb888,
            Alpha8,
            RgbaF16,
            Nv21,
            Nv12,
            Rgba1010102,
            YcbcrP010,
            YcrcbP010
        ]
        let enumArray2: Array<PixelMapFormat> = [
            Unknown,
            Rgb565,
            Rgba8888,
            Bgra8888,
            Rgb888,
            Alpha8,
            RgbaF16,
            Nv21,
            Nv12,
            Rgba1010102,
            YcbcrP010,
            YcrcbP010
        ]
        let strArray: Array<String> = [
            "PixelMapFormat.Unknown",
            "PixelMapFormat.Rgb565",
            "PixelMapFormat.Rgba8888",
            "PixelMapFormat.Bgra8888",
            "PixelMapFormat.Rgb888",
            "PixelMapFormat.Alpha8",
            "PixelMapFormat.RgbaF16",
            "PixelMapFormat.Nv21",
            "PixelMapFormat.Nv12",
            "PixelMapFormat.Rgba1010102",
            "PixelMapFormat.YcbcrP010",
            "PixelMapFormat.YcrcbP010"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_AlphaType() {
        let enumArray: Array<AlphaType> = [Unknown, Opaque, Premul, UnPremul]
        let enumArray2: Array<AlphaType> = [Unknown, Opaque, Premul, UnPremul]
        let strArray: Array<String> = [
            "AlphaType.Unknown",
            "AlphaType.Opaque",
            "AlphaType.Premul",
            "AlphaType.UnPremul"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ScaleMode() {
        let enumArray: Array<ScaleMode> = [FitTargetSize, CenterCrop]
        let enumArray2: Array<ScaleMode> = [FitTargetSize, CenterCrop]
        let strArray: Array<String> = [
            "ScaleMode.FitTargetSize",
            "ScaleMode.CenterCrop"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_ImageFormat() {
        let enumArray: Array<ImageFormat> = [Ycbcr422Sp, Jpeg]
        let enumArray2: Array<ImageFormat> = [Ycbcr422Sp, Jpeg]
        let strArray: Array<String> = [
            "ImageFormat.Ycbcr422Sp",
            "ImageFormat.Jpeg"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_EnumDecodingDynamicRange() {
        let enumArray: Array<DecodingDynamicRange> = [DecodingDynamicRange.Auto, DecodingDynamicRange.Sdr, DecodingDynamicRange.Hdr]
        let enumArray2: Array<DecodingDynamicRange> = [DecodingDynamicRange.Auto, DecodingDynamicRange.Sdr, DecodingDynamicRange.Hdr]
        let strArray: Array<String> = [
            "DecodingDynamicRange.Auto",
            "DecodingDynamicRange.Sdr",
            "DecodingDynamicRange.Hdr"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_EnumPackingDynamicRange() {
        let enumArray: Array<PackingDynamicRange> = [PackingDynamicRange.Auto, PackingDynamicRange.Sdr]
        let enumArray2: Array<PackingDynamicRange> = [PackingDynamicRange.Auto, PackingDynamicRange.Sdr]
        let strArray: Array<String> = [
            "PackingDynamicRange.Auto",
            "PackingDynamicRange.Sdr"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray2[(i + 1) % enumArray2.size])
        }
    }
}

class ImageReceiverCallback <: Callback0Argument {
    public open func invoke(err: ?BusinessException): Unit {}
}
