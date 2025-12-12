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
import ohos.labels.{APILevel, Hide}
import ohos.business_exception.BusinessException

/**
 * Enumerates pixel map formats.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PixelMapFormat {
    /**
     * Indicates an unknown format.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Unknown
    |
    @!Hide
    Argb8888
    |
    /**
     * Indicates that each pixel is stored on 16 bits. Only the R, G, and B components are encoded
     * from the higher-order to the lower-order bits: red is stored with 5 bits of precision,
     * green is stored with 6 bits of precision, and blue is stored with 5 bits of precision.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgb565
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：R(8bits), G(8bits), B(8bits), A(8bits)
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgba8888
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits), A(8bits)
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Bgra8888
    |
    /**
     * Indicates that each pixel is stored on 24 bits. Each pixel contains 3 components：R(8bits), G(8bits), B(8bits)
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgb888
    |
    /**
     * Indicates that each pixel is stored on 8 bits. Each pixel contains 1 component：ALPHA(8bits)
     * and is stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Alpha8
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits), A(8bits)
     * and are stored from the higher-order to the lower-order bits in F16.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RgbaF16
    |
    /**
     * Indicates that the storage order is to store Y first and then V U alternately each occupies 8 bits
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Nv21
    |
    /**
     * Indicates that the storage order is to store Y first and then U V alternately each occupies 8 bits
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Nv12
    |
    /**
     * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：
     * R(10bits), G(10bits), B(10bits), A(2bits) and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Rgba1010102
    |
    /**
     * Indicates that the storage order is to store Y first and then U V alternately each occupies 10 bits
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YcbcrP010
    |
    /**
     * Indicates that the storage order is to store Y first and then V U alternately each occupies 10 bits
     * and are stored from the higher-order to the lower-order bits.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YcrcbP010
    |
    @!Hide
    Astc4x4
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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum AlphaType {
    /**
     * Indicates an unknown alpha type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Unknown
    |
    /**
     * Indicates that the image has no alpha channel, or all pixels in the image are fully opaque.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Opaque
    |
    /**
     * Indicates that RGB components of each pixel in the image are premultiplied by alpha.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Premul
    |
    /**
     * Indicates that RGB components of each pixel in the image are independent of alpha and
     * are not premultiplied by alpha.
     */
    @!APILevel[
        since: "22",
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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum ScaleMode {
    /**
     * Indicates the effect that fits the image into the target size.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FitTargetSize
    |
    /**
     * Indicates the effect that scales an image to fill the target image area and
     * center-crops the part outside the area.
     */
    @!APILevel[
        since: "22",
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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum ImageFormat {
    /**
     * YCBCR422 semi-planar format.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Ycbcr422Sp
    |
    /**
     * JPEG encoding format.
     */
    @!APILevel[
        since: "22",
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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
]
public enum ComponentType {
    /**
     * Luma info.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvY
    |
    /**
     * Chrominance info.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvU
    |
    /**
     * Chroma info.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.ImageReceiver"
    ]
    YuvV
    |
    /**
     * Jpeg type.
     */
    @!APILevel[
        since: "22",
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
 * Enumerates exchangeable image file format (Exif) information types of an image. This enumeration follows the EXIF
 * standard. Please refer to the EXIF specification for more details.
 */
@Derive[Equatable, Hashable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PropertyKey <: ToString {
    /**
     * The number of bits per image component. In this standard each component of the image is 8 bits, so the value for 
     * this tag is 8. In JPEG compressed data a JPEG marker is used instead of this tag.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BitsPerSample
    |
    /**
     * Image orientation.
     * 1. "Top-left"       - The image is not rotated.
     * 2. "Top-right"      - The image is mirrored horizontally.
     * 3. "Bottom-right"   - The image is rotated 180 degrees.
     * 4. "Bottom-left"    - The image is mirrored vertically.
     * 5. "Left-top"       - The image is mirrored horizontally, then rotated 270 degrees clockwise.
     * 6. "Right-top"      - The image is rotated 90 degrees clockwise.
     * 7. "Right-bottom"   - The image is mirrored horizontally, then rotated 90 degrees clockwise.
     * 8. "Left-bottom"    - The image is rotated 270 degrees clockwise.
     * If an undefined value is read, the result will be "Unknown Value <number>".
     * When retrieving the Orientation property, the value is returned as a string.
     * When setting the Orientation property, both numeric values (1–8) and string labels are supported.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Orientation
    |
    /**
     * Image length.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageLength
    |
    /**
     * Image width.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageWidth
    |
    /**
     * GPS latitude. The latitude is expressed as three RATIONAL values giving the degrees, minutes, and
     * seconds, respectively. If latitude is expressed as degrees, minutes and seconds, a typical format 
     * would be dd/1,mm/1,ss/1. When degrees and minutes are used and, for example, fractions of minutes
     * are given up to two decimal places, the format would be dd/1,mmmm/100,0/1.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLatitude
    |
    /**
     * GPS longitude. The longitude is expressed as three RATIONAL values giving the degrees, minutes, and
     * seconds, respectively. If longitude is expressed as degrees, minutes and seconds, a typical format 
     * would be dd/1,mm/1,ss/1. When degrees and minutes are used and, for example, fractions of minutes
     * are given up to two decimal places, the format would be dd/1,mmmm/100,0/1.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLongitude
    |
    /**
     * GPS latitude reference. For example, N indicates north latitude and S indicates south latitude.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLatitudeRef
    |
    /**
     * GPS longitude reference. For example, E indicates east longitude and W indicates west longitude.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsLongitudeRef
    |
    /**
     * The date and time when the original image data was generated. For a DSC the date and time the picture was taken
     * are recorded. The format is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTimeOriginal
    |
    /**
     * Exposure time
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureTime
    |
    /**
     * Scene type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneType
    |
    /**
     * Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedRatings
    |
    /**
     * Aperture value, such as f/1.8.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FNumber
    |
    /**
     * The date and time of image creation. In this standard it is the date and time the file was changed. The format
     * is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTime
    |
    /**
     * GPS time stamp
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTimestamp
    |
    /**
     * GPS date stamp
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDateStamp
    |
    /**
     * Image description
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageDescription
    |
    /**
     * Make
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Make
    |
    /**
     * Model
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Model
    |
    /**
     * Photo mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotoMode
    |
    /**
     * Sensitivity type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SensitivityType
    |
    /**
     * Standard output sensitivity
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StandardOutputSensitivity
    |
    /**
     * Recommended exposure index
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RecommendedExposureIndex
    |
    /**
     * Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeed
    |
    /**
     * The lens aperture. The unit is the APEX(Additive System of Photographic Exposure) value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ApertureValue
    |
    /**
     * Exposure bias value
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureBiasValue
    |
    /**
     * Metering mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MeteringMode
    |
    /**
     * Light source
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LightSource
    |
    /**
     * Flash
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Flash
    |
    /**
     * Focal length
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalLength
    |
    /**
     * User comment
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    UserComment
    |
    /**
     * Pixel x dimension
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PixelXDimension
    |
    /**
     * Pixel y dimension
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PixelYDimension
    |
    /**
     * White balance
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WhiteBalance
    |
    /**
     * Focal length in 35mm film
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalLengthIn35mmFilm
    |
    /**
     * Capture mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CaptureMode
    |
    /**
     * Physical aperture
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhysicalAperture
    |
    /**
     * Roll Angle
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RollAngle
    |
    /**
     * Pitch Angle
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PitchAngle
    |
    /**
     * Capture Scene: Food
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneFoodConf
    |
    /**
     * Capture Scene: Stage
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneStageConf
    |
    /**
     * Capture Scene: Blue Sky
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneBlueSkyConf
    |
    /**
     * Capture Scene: Green Plant
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneGreenPlantConf
    |
    /**
     * Capture Scene: Beach
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneBeachConf
    |
    /**
     * Capture Scene: Snow
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneSnowConf
    |
    /**
     * Capture Scene: Sunset
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneSunsetConf
    |
    /**
     * Capture Scene: Flowers
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneFlowersConf
    |
    /**
     * Capture Scene: Night
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneNightConf
    |
    /**
     * Capture Scene: Text
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneTextConf
    |
    /**
     * Face Count
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceCount
    |
    /**
     * Focus Mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocusMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Compression
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotometricInterpretation
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StripOffsets
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SamplesPerPixel
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RowsPerStrip
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StripByteCounts
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XResolution
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YResolution
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PlanarConfiguration
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ResolutionUnit
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    TransferFunction
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Software
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Artist
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WhitePoint
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PrimaryChromaticities
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrCoefficients
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrSubSampling
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrPositioning
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ReferenceBlackWhite
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Copyright
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    JpegInterchangeFormat
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    JpegInterchangeFormatLength
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureProgram
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SpectralSensitivity
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Oecf
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExifVersion
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTimeDigitized
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ComponentsConfiguration
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ShutterSpeed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BrightnessValue
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MaxApertureValue
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectDistance
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectArea
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MakerNote
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTime
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTimeOriginal
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTimeDigitized
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FlashpixVersion
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ColorSpace
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RelatedSoundFile
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FlashEnergy
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SpatialFrequencyResponse
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneXResolution
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneYResolution
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneResolutionUnit
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectLocation
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureIndex
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SensingMethod
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FileSource
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CfaPattern
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CustomRendered
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DigitalZoomRatio
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneCaptureType
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GainControl
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Contrast
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Saturation
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Sharpness
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DeviceSettingDescription
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectDistanceRange
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageUniqueId
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsVersionId
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAltitudeRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAltitude
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSatellites
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsStatus
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsMeasureMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDop
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSpeedRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSpeed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTrackRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTrack
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsImgDirectionRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsImgDirection
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsMapDatum
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLatitudeRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLatitude
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLongitudeRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLongitude
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestBearingRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestBearing
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestDistanceRef
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestDistance
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsProcessingMethod
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAreaInformation
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDifferential
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BodySerialNumber
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CameraOwnerName
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CompositeImage
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CompressedBitsPerPixel
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DngVersion
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DefaultCropSize
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Gamma
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedLatitudeyyy
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedLatitudezzz
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensMake
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensModel
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensSerialNumber
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensSpecification
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    NewSubfileType
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTime
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTimeDigitized
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTimeOriginal
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SourceExposureTimesOfCompositeImage
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SourceImageNumberOfCompositeImage
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubfileType
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsHPositioningError
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotographicSensitivity
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BurstNumber
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceConf
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceLeyeCenter
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceMouthCenter
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FacePointer
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceRect
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceReyeCenter
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceSmileScore
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceVersion
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FrontCamera
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ScenePointer
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneVersion
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsXmageSupported
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageLeft
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageTop
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageRight
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageBottom
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CloudEnhancementMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WindSnapshotMode
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GifLoopCount
    | ...

    /**
     * Converts the PropertyKey to its string representation.
     * @returns A string representation of the PropertyKey.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    public func toString(): String {
        match (this) {
            case NewSubfileType => "NewSubfileType"
            case SubfileType => "SubfileType"
            case ImageWidth => "ImageWidth"
            case ImageLength => "ImageLength"
            case BitsPerSample => "BitsPerSample"
            case Compression => "Compression"
            case PhotometricInterpretation => "PhotometricInterpretation"
            case ImageDescription => "ImageDescription"
            case Make => "Make"
            case Model => "Model"
            case StripOffsets => "StripOffsets"
            case Orientation => "Orientation"
            case SamplesPerPixel => "SamplesPerPixel"
            case RowsPerStrip => "RowsPerStrip"
            case StripByteCounts => "StripByteCounts"
            case XResolution => "XResolution"
            case YResolution => "YResolution"
            case PlanarConfiguration => "PlanarConfiguration"
            case ResolutionUnit => "ResolutionUnit"
            case TransferFunction => "TransferFunction"
            case Software => "Software"
            case DateTime => "DateTime"
            case Artist => "Artist"
            case WhitePoint => "WhitePoint"
            case PrimaryChromaticities => "PrimaryChromaticities"
            case PhotoMode => "PhotoMode"
            case JpegInterchangeFormat => "JPEGInterchangeFormat"
            case JpegInterchangeFormatLength => "JPEGInterchangeFormatLength"
            case YCbCrCoefficients => "YCbCrCoefficients"
            case YCbCrSubSampling => "YCbCrSubSampling"
            case YCbCrPositioning => "YCbCrPositioning"
            case ReferenceBlackWhite => "ReferenceBlackWhite"
            case Copyright => "Copyright"
            case ExposureTime => "ExposureTime"
            case FNumber => "FNumber"
            case ExposureProgram => "ExposureProgram"
            case SpectralSensitivity => "SpectralSensitivity"
            case GpsVersionId => "GPSVersionID"
            case GpsLatitudeRef => "GPSLatitudeRef"
            case GpsLatitude => "GPSLatitude"
            case GpsLongitudeRef => "GPSLongitudeRef"
            case GpsLongitude => "GPSLongitude"
            case GpsAltitudeRef => "GPSAltitudeRef"
            case GpsAltitude => "GPSAltitude"
            case GpsTimestamp => "GPSTimeStamp"
            case GpsSatellites => "GPSSatellites"
            case GpsStatus => "GPSStatus"
            case GpsMeasureMode => "GPSMeasureMode"
            case GpsDop => "GPSDOP"
            case GpsSpeedRef => "GPSSpeedRef"
            case GpsSpeed => "GPSSpeed"
            case GpsTrackRef => "GPSTrackRef"
            case GpsTrack => "GPSTrack"
            case GpsImgDirectionRef => "GPSImgDirectionRef"
            case GpsImgDirection => "GPSImgDirection"
            case GpsMapDatum => "GPSMapDatum"
            case GpsDestLatitudeRef => "GPSDestLatitudeRef"
            case GpsDestLatitude => "GPSDestLatitude"
            case GpsDestLongitudeRef => "GPSDestLongitudeRef"
            case GpsDestLongitude => "GPSDestLongitude"
            case GpsDestBearingRef => "GPSDestBearingRef"
            case GpsDestBearing => "GPSDestBearing"
            case GpsDestDistanceRef => "GPSDestDistanceRef"
            case GpsDestDistance => "GPSDestDistance"
            case GpsProcessingMethod => "GPSProcessingMethod"
            case GpsAreaInformation => "GPSAreaInformation"
            case GpsDateStamp => "GPSDateStamp"
            case GpsDifferential => "GPSDifferential"
            case GpsHPositioningError => "GPSHPositioningError"
            case IsoSpeedRatings => "ISOSpeedRatings"
            case PhotographicSensitivity => "PhotographicSensitivity"
            case Oecf => "OECF"
            case SensitivityType => "SensitivityType"
            case StandardOutputSensitivity => "StandardOutputSensitivity"
            case RecommendedExposureIndex => "RecommendedExposureIndex"
            case IsoSpeed => "ISOSpeedRatings"
            case IsoSpeedLatitudeyyy => "ISOSpeedLatitudeyyy"
            case IsoSpeedLatitudezzz => "ISOSpeedLatitudezzz"
            case ExifVersion => "ExifVersion"
            case DateTimeOriginal => "DateTimeOriginal"
            case DateTimeDigitized => "DateTimeDigitized"
            case OffsetTime => "OffsetTime"
            case OffsetTimeOriginal => "OffsetTimeOriginal"
            case OffsetTimeDigitized => "OffsetTimeDigitized"
            case ComponentsConfiguration => "ComponentsConfiguration"
            case CompressedBitsPerPixel => "CompressedBitsPerPixel"
            case ShutterSpeed => "ShutterSpeedValue"
            case ApertureValue => "ApertureValue"
            case BrightnessValue => "BrightnessValue"
            case ExposureBiasValue => "ExposureBiasValue"
            case MaxApertureValue => "MaxApertureValue"
            case SubjectDistance => "SubjectDistance"
            case MeteringMode => "MeteringMode"
            case LightSource => "LightSource"
            case Flash => "Flash"
            case FocalLength => "FocalLength"
            case SubjectArea => "SubjectArea"
            case MakerNote => "MakerNote"
            case ScenePointer => "HwMnoteScenePointer"
            case SceneVersion => "HwMnoteSceneVersion"
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
            case FacePointer => "HwMnoteFacePointer"
            case FaceVersion => "HwMnoteFaceVersion"
            case FaceCount => "HwMnoteFaceCount"
            case FaceConf => "HwMnoteFaceConf"
            case FaceSmileScore => "HwMnoteFaceSmileScore"
            case FaceRect => "HwMnoteFaceRect"
            case FaceLeyeCenter => "HwMnoteFaceLeyeCenter"
            case FaceReyeCenter => "HwMnoteFaceReyeCenter"
            case FaceMouthCenter => "HwMnoteFaceMouthCenter"
            case CaptureMode => "HwMnoteCaptureMode"
            case BurstNumber => "HwMnoteBurstNumber"
            case FrontCamera => "HwMnoteFrontCamera"
            case RollAngle => "HwMnoteRollAngle"
            case PitchAngle => "HwMnotePitchAngle"
            case PhysicalAperture => "HwMnotePhysicalAperture"
            case FocusMode => "HwMnoteFocusMode"
            case UserComment => "UserComment"
            case SubsecTime => "SubsecTime"
            case SubsecTimeOriginal => "SubsecTimeOriginal"
            case SubsecTimeDigitized => "SubsecTimeDigitized"
            case FlashpixVersion => "FlashpixVersion"
            case ColorSpace => "ColorSpace"
            case PixelXDimension => "PixelXDimension"
            case PixelYDimension => "PixelYDimension"
            case RelatedSoundFile => "RelatedSoundFile"
            case FlashEnergy => "FlashEnergy"
            case SpatialFrequencyResponse => "SpatialFrequencyResponse"
            case FocalPlaneXResolution => "FocalPlaneXResolution"
            case FocalPlaneYResolution => "FocalPlaneYResolution"
            case FocalPlaneResolutionUnit => "FocalPlaneResolutionUnit"
            case SubjectLocation => "SubjectLocation"
            case ExposureIndex => "ExposureIndex"
            case SensingMethod => "SensingMethod"
            case FileSource => "FileSource"
            case SceneType => "SceneType"
            case CfaPattern => "CFAPattern"
            case CustomRendered => "CustomRendered"
            case ExposureMode => "ExposureMode"
            case WhiteBalance => "WhiteBalance"
            case DigitalZoomRatio => "DigitalZoomRatio"
            case FocalLengthIn35mmFilm => "FocalLengthIn35mmFilm"
            case SceneCaptureType => "SceneCaptureType"
            case GainControl => "GainControl"
            case Contrast => "Contrast"
            case Saturation => "Saturation"
            case Sharpness => "Sharpness"
            case DeviceSettingDescription => "DeviceSettingDescription"
            case SubjectDistanceRange => "SubjectDistanceRange"
            case ImageUniqueId => "ImageUniqueID"
            case CameraOwnerName => "CameraOwnerName"
            case BodySerialNumber => "BodySerialNumber"
            case LensSpecification => "LensSpecification"
            case LensMake => "LensMake"
            case LensModel => "LensModel"
            case LensSerialNumber => "LensSerialNumber"
            case CompositeImage => "CompositeImage"
            case SourceImageNumberOfCompositeImage => "SourceImageNumberOfCompositeImage"
            case SourceExposureTimesOfCompositeImage => "SourceExposureTimesOfCompositeImage"
            case Gamma => "Gamma"
            case DngVersion => "DNGVersion"
            case DefaultCropSize => "DefaultCropSize"
            case GifLoopCount => "GIFLoopCount"
            case IsXmageSupported => "HwMnoteIsXmageSupported"
            case XmageMode => "HwMnoteXmageMode"
            case XmageLeft => "HwMnoteXmageLeft"
            case XmageTop => "HwMnoteXmageTop"
            case XmageRight => "HwMnoteXmageRight"
            case XmageBottom => "HwMnoteXmageBottom"
            case CloudEnhancementMode => "HwMnoteCloudEnhancementMode"
            case WindSnapshotMode => "HwMnoteWindSnapshotMode"
            case _ => throw BusinessException(62980115, "Parameter error.")
        }
    }
}


/**
 * Enumerates decoding dynamic range.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum DecodingDynamicRange {
    /**
     * Decoding according to the content of the image. If the image is an HDR image, it will be decoded as HDR content;
     * otherwise, it will be decoded as SDR content.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Auto
    |
    /**
     * Decoding to standard dynamic range.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Sdr
    |
    /**
     * Decoding to high dynamic range.
     */
    @!APILevel[
        since: "22",
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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Image.Core"
]
public enum PackingDynamicRange {
    /**
     * Packing according to the content of the image. If the image is an HDR image, it will be encoded as HDR content;
     * otherwise, it will be encoded as SDR content.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Auto
    |
    /**
     * Packing to standard dynamic range.
     */
    @!APILevel[
        since: "22",
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
