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

import std.deriving.Derive
import ohos.labels.*
import ohos.business_exception.BusinessException

/**
 * Enumerates pixel map formats.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PixelMapFormat {
    /**
     * Indicates an unknown format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Unknown
    |
    /**
     * Indicates that each pixel is stored on 16 bits. Only the R, G, and B components are encoded
     * from the higher-order to the lower-order bits: red is stored with 5 bits of precision,
     * green is stored with 6 bits of precision, and blue is stored with 5 bits of precision.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgb565
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits),
     * A(8bits)
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgba8888
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits),
     * A(8bits)
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Bgra8888
    |
    /**
     * Indicates that each pixel is stored on 24 bits. Each pixel contains 3 components：R(8bits), G(8bits), B(8bits)
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgb888
    |
    /**
     * Indicates that each pixel is stored on 8 bits. Each pixel contains 1 component：ALPHA(8bits)
     * and is stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Alpha8
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits),
     * A(8bits)
     * and are stored from the higher-order to the lower-order bits in F16.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RgbaF16
    |
    /**
     * Indicates that the storage order is to store Y first and then V U alternately each occupies 8 bits
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Nv21
    |
    /**
     * Indicates that the storage order is to store Y first and then U V alternately each occupies 8 bits
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Nv12
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：
     * R(10bits), G(10bits), B(10bits), A(2bits) and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgba1010102
    |
    /**
     * Indicates that the storage order is to store Y first and then U V alternately each occupies 10 bits
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YcbcrP010
    |
    /**
     * Indicates that the storage order is to store Y first and then V U alternately each occupies 10 bits
     * and are stored from the higher-order to the lower-order bits.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YcrcbP010
    | ...

    func getValue(): Int32 {
        match (this) {
            case Unknown => 0
            case Rgb565 => 2
            case Rgba8888 => 3
            case Bgra8888 => 4
            case Rgb888 => 5
            case Alpha8 => 6
            case RgbaF16 => 7
            case Nv21 => 8
            case Nv12 => 9
            case Rgba1010102 => 10
            case YcbcrP010 => 11
            case YcrcbP010 => 12
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 0 => Unknown
            case 2 => Rgb565
            case 3 => Rgba8888
            case 4 => Bgra8888
            case 5 => Rgb888
            case 6 => Alpha8
            case 7 => RgbaF16
            case 8 => Nv21
            case 9 => Nv12
            case 10 => Rgba1010102
            case 11 => YcbcrP010
            case 12 => YcrcbP010
            case _ => throw BusinessException(62980113, "Parameter error.")
        }
    }
}

/**
 * Enumerates alpha types.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum AlphaType {
    /**
     * Indicates an unknown alpha type.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Unknown
    |
    /**
     * Indicates that the image has no alpha channel, or all pixels in the image are fully opaque.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Opaque
    |
    /**
     * Indicates that RGB components of each pixel in the image are premultiplied by alpha.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Premul
    |
    /**
     * Indicates that RGB components of each pixel in the image are independent of alpha and are not premultiplied by
     * alpha.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    UnPremul
    | ...

    func getValue(): Int32 {
        match (this) {
            case Unknown => 0
            case Opaque => 1
            case Premul => 2
            case UnPremul => 3
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 0 => Unknown
            case 1 => Opaque
            case 2 => Premul
            case 3 => UnPremul
            case _ => throw BusinessException(62980113, "Parameter error.")
        }
    }
}

/**
 * Enum for image scale mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum ScaleMode {
    /**
     * Indicates the effect that fits the image into the target size.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FitTargetSize
    |
    /**
     * Indicates the effect that scales an image to fill the target image area and center-crops the part outside the
     * area.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CenterCrop
    | ...

    func getValue(): Int32 {
        match (this) {
            case FitTargetSize => 0
            case CenterCrop => 1
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }
}

/**
 * Enum for image formats.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum ImageFormat {
    /**
     * YCBCR422 semi-planar format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Ycbcr422Sp
    |
    /**
     * JPEG encoding format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Jpeg
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Ycbcr422Sp => 1000
                case Jpeg => 2000
                case _ => throw BusinessException(62980115, "Parameter error.")
            }
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 1000 => Ycbcr422Sp
            case 2000 => Jpeg
            case _ => throw BusinessException(62980113, "Parameter error.")
        }
    }
}

/**
 * The component type of image.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
]
public enum ComponentType {
    /**
     * Luma info.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvY
    |
    /**
     * Chrominance info.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvU
    |
    /**
     * Chroma info.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvV
    |
    /**
     * Jpeg type.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    Jpeg
    | ...

    func getValue(): Int32 {
        match (this) {
            case YuvY => 1
            case YuvU => 2
            case YuvV => 3
            case Jpeg => 4
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 1 => YuvY
            case 2 => YuvU
            case 3 => YuvV
            case 4 => Jpeg
            case _ => throw BusinessException(62980113, "Parameter error.")
        }
    }
}

/**
 * Enumerates exchangeable image file format (Exif) information types of an image.
 *
 */
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PropertyKey <: ToString {
    /**
     * Image width.
     *
     */
    | @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageWidth
    |
    /**
     * Image length.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageLength
    |
    /**
     * Number of bits in each pixel of an image.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BitsPerSample
    |
    /**
     * Image description.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageDescription
    |
    /**
     * Make.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Make
    |
    /**
     * Model.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Model
    |
    /**
     * Image rotation mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Orientation
    |
    /**
     * Date time.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTime
    |
    /**
     * Photo mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotoMode
    |
    /**
     * Exposure time.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureTime
    |
    /**
     * Aperture value.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FNumber
    |
    /**
     * GPS latitude reference. For example, N indicates north latitude and S indicates south latitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLatitudeRef
    |
    /**
     * GPS latitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLatitude
    |
    /**
     * GPS longitude reference. For example, E indicates east longitude and W indicates west longitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLongitudeRef
    |
    /**
     * GPS longitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLongitude
    |
    /**
     * GPS time stamp.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTimeStamp
    |
    /**
     * GPS date stamp.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDateStamp
    |
    /**
     * ISO speedratings.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedRatings
    |
    /**
     * Sensitivity type.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SensitivityType
    |
    /**
     * Standard output sensitivity.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StandardOutputSensitivity
    |
    /**
     * Recommended exposure index.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RecommendedExposureIndex
    |
    /**
     * ISO speed.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeed
    |
    /**
     * Shooting time.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTimeOriginal
    |
    /**
     * Aperture value.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ApertureValue
    |
    /**
     * Exposure bias value.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureBiasValue
    |
    /**
     * Metering mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MeteringMode
    |
    /**
     * Light source.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LightSource
    |
    /**
     * Flash.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Flash
    |
    /**
     * Focal length.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalLength
    |
    /**
     * Capture Scene: Food.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneFoodConf
    |
    /**
     * Capture Scene: Stage.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneStageConf
    |
    /**
     * Capture Scene: Blue Sky.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneBlueSkyConf
    |
    /**
     * Capture Scene: Green Plant.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneGreenPlantConf
    |
    /**
     * Capture Scene: Beach.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneBeachConf
    |
    /**
     * Capture Scene: Snow.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneSnowConf
    |
    /**
     * Capture Scene: Sunset.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneSunsetConf
    |
    /**
     * Capture Scene: Flowers.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneFlowersConf
    |
    /**
     * Capture Scene: Night.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneNightConf
    |
    /**
     * Capture Scene: Text.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneTextConf
    |
    /**
     * Face Count.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceCount
    |
    /**
     * Capture mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CaptureMode
    |
    /**
     * Roll Angle.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RollAngle
    |
    /**
     * Pitch Angle.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PitchAngle
    |
    /**
     * Physical aperture.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhysicalAperture
    |
    /**
     * Focus Mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocusMode
    |
    /**
     * User comment.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    UserComment
    |
    /**
     * Pixel x dimension.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PixelXDimension
    |
    /**
     * Pixel y dimension.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PixelYDimension
    |
    /**
     * Scene type.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneType
    |
    /**
     * White balance.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WhiteBalance
    |
    /**
     * Focal length in 35mm film.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalLengthIn35mmFilm
    | ...

    /**
     * Return the string of the enumeration value.
     *
     * @throws IllegalArgumentException - The type is not supported yet.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func toString(): String {
        match (this) {
            case ImageWidth => "ImageWidth"
            case ImageLength => "ImageLength"
            case BitsPerSample => "BitsPerSample"
            case ImageDescription => "ImageDescription"
            case Make => "Make"
            case Model => "Model"
            case Orientation => "Orientation"
            case DateTime => "DateTime"
            case PhotoMode => "PhotoMode"
            case ExposureTime => "ExposureTime"
            case FNumber => "FNumber"
            case GpsLatitudeRef => "GPSLatitudeRef"
            case GpsLatitude => "GPSLatitude"
            case GpsLongitudeRef => "GPSLongitudeRef"
            case GpsLongitude => "GPSLongitude"
            case GpsTimeStamp => "GPSTimeStamp"
            case GpsDateStamp => "GPSDateStamp"
            case IsoSpeedRatings => "ISOSpeedRatings"
            case SensitivityType => "SensitivityType"
            case StandardOutputSensitivity => "StandardOutputSensitivity"
            case RecommendedExposureIndex => "RecommendedExposureIndex"
            case IsoSpeed => "ISOSpeedRatings"
            case DateTimeOriginal => "DateTimeOriginal"
            case ApertureValue => "ApertureValue"
            case ExposureBiasValue => "ExposureBiasValue"
            case MeteringMode => "MeteringMode"
            case LightSource => "LightSource"
            case Flash => "Flash"
            case FocalLength => "FocalLength"
            case SceneFoodConf => "HwMnoteSceneFoodConf"
            case SceneStageConf => "HwMnoteSceneStageConf"
            case SceneBlueSkyConf => "HwMnoteSceneBlueSkyConf"
            case SceneGreenPlantConf => "HwMnoteSceneGreenPlantConf"
            case SceneBeachConf => "HwMnoteSceneBeachConf"
            case SceneSnowConf => "HwMnoteSceneSnowConf"
            case SceneSunsetConf => "HwMnoteSceneSunsetConf"
            case SceneFlowersConf => "HwMnoteSceneFlowersConf"
            case SceneNightConf => "HwMnoteSceneNightConf"
            case SceneTextConf => "HwMnoteSceneTextConf"
            case FaceCount => "HwMnoteFaceCount"
            case CaptureMode => "HwMnoteCaptureMode"
            case RollAngle => "HwMnoteRollAngle"
            case PitchAngle => "HwMnotePitchAngle"
            case PhysicalAperture => "HwMnotePhysicalAperture"
            case FocusMode => "HwMnoteFocusMode"
            case UserComment => "UserComment"
            case PixelXDimension => "PixelXDimension"
            case PixelYDimension => "PixelYDimension"
            case SceneType => "SceneType"
            case WhiteBalance => "WhiteBalance"
            case FocalLengthIn35mmFilm => "FocalLengthIn35mmFilm"
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }
}


/**
 * Enumerates decoding dynamic range.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum DecodingDynamicRange {
    /**
     * Decoding according to the content of the image.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Auto
    |
    /**
     * Decoding to standard dynamic range.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Sdr
    |
    /**
     * Decoding to high dynamic range.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Hdr
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Auto => return 0
                case Sdr => return 1
                case Hdr => return 2
                case _ => throw BusinessException(62980115, "Parameter error.")
            }
        }
    }
}


/**
 * Enumerates packing dynamic range.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PackingDynamicRange {
    /**
     * Packing according to the content of the image.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Auto
    |
    /**
     * Packing to standard dynamic range.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Sdr
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Auto => return 0
                case Sdr => return 1
                case _ => throw BusinessException(62980115, "Parameter error.")
            }
        }
    }
}
