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
    /**
     * The scheme used for image compression.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Compression
    |
    /**
     * Pixel composition, such as RGB or YCbCr.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotometricInterpretation
    |
    /**
     * For each strip, the byte offset of that strip.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StripOffsets
    |
    /**
     * The number of components per pixel. As the standard applies to both RGB and YCbCr images, the tag value is set
     * to 3. For JPEG-compressed images, this tag is replaced by corresponding JPEG markers.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SamplesPerPixel
    |
    /**
     * The number of rows per strip of image data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RowsPerStrip
    |
    /**
     * The total number of bytes in each strip of image data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    StripByteCounts
    |
    /**
     * The image resolution in the width direction.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XResolution
    |
    /**
     * The image resolution in the height direction.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YResolution
    |
    /**
     * Indicates whether pixel components are recorded in a chunky or planar format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PlanarConfiguration
    |
    /**
     * The unit used to measure XResolution and YResolution.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ResolutionUnit
    |
    /**
     * The transfer function for the image, typically used for color correction.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    TransferFunction
    |
    /**
     * The name and version of the software used to generate the image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Software
    |
    /**
     * The name of the person who created the image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Artist
    |
    /**
     * The chromaticity of the white point of the image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WhitePoint
    |
    /**
     * The chromaticity of the primary colors of the image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PrimaryChromaticities
    |
    /**
     * The matrix coefficients for transformation from RGB to YCbCr image data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrCoefficients
    |
    /**
     * The sampling ratio of chrominance components to the luminance component.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrSubSampling
    |
    /**
     * The position of chrominance components in relation to the luminance component.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    YCbCrPositioning
    |
    /**
     * The reference black point value and reference white point value.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ReferenceBlackWhite
    |
    /**
     * Copyright information for the image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Copyright
    |
    /**
     * The offset to the start byte (SOI) of JPEG compressed thumbnail data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    JpegInterchangeFormat
    |
    /**
     * The number of bytes of JPEG compressed thumbnail data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    JpegInterchangeFormatLength
    |
    /**
     * The class of the program used by the camera to set exposure when the picture is taken.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureProgram
    |
    /**
     * Indicates the spectral sensitivity of each channel of the camera used.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SpectralSensitivity
    |
    /**
     * Indicates the Opto-Electric Conversion Function (OECF) specified in ISO 14524.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Oecf
    |
    /**
     * The version of the Exif standard supported.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExifVersion
    |
    /**
     * The date and time when the image was stored as digital data. If, for example, an image was captured by DSC and
     * at the same time the file was recorded, then the DateTimeOriginal and DateTimeDigitized will have the same
     * contents. The format is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DateTimeDigitized
    |
    /**
     * Information specific to compressed data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ComponentsConfiguration
    |
    /**
     * The shutter speed, expressed as an APEX (Additive System of Photographic Exposure) value.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ShutterSpeed
    |
    /**
     * The brightness value of the image, in APEX units.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BrightnessValue
    |
    /**
     * The smallest F number of lens.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MaxApertureValue
    |
    /**
     * The distance to the subject, measured in meters.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectDistance
    |
    /**
     * This tag indicate the location and area of the main subject in the overall scene.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectArea
    |
    /**
     * A tag for manufacturers of Exif/DCF writers to record any desired information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    MakerNote
    |
    /**
     * A tag for record fractions of seconds for the DateTime tag.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTime
    |
    /**
     * A tag used to record fractions of seconds for the DateTimeOriginal tag.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTimeOriginal
    |
    /**
     * A tag used to record fractions of seconds for the DateTimeDigitized tag.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubsecTimeDigitized
    |
    /**
     * This tag denotes the Flashpix format version supported by an FPXR file, enhancing device compatibility.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FlashpixVersion
    |
    /**
     * The color space information tag, often recorded as the color space specifier.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ColorSpace
    |
    /**
     * The name of an audio file related to the image data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    RelatedSoundFile
    |
    /**
     * Strobe energy at image capture, in BCPS.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FlashEnergy
    |
    /**
     * Camera or input device spatial frequency table.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SpatialFrequencyResponse
    |
    /**
     * Pixels per FocalPlaneResolutionUnit in the image width.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneXResolution
    |
    /**
     * Pixels per FocalPlaneResolutionUnit in the image height.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneYResolution
    |
    /**
     * Unit for measuring FocalPlaneXResolution and FocalPlaneYResolution.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FocalPlaneResolutionUnit
    |
    /**
     * Location of the main subject, relative to the left edge.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectLocation
    |
    /**
     * Selected exposure index at capture.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureIndex
    |
    /**
     * Image sensor type on the camera.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SensingMethod
    |
    /**
     * Indicates the image source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FileSource
    |
    /**
     * Color filter array (CFA) geometric pattern of the image sensor.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CfaPattern
    |
    /**
     * Indicates special processing on image data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CustomRendered
    |
    /**
     * Exposure mode set when the image was shot.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ExposureMode
    |
    /**
     * Digital zoom ratio at the time of capture.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DigitalZoomRatio
    |
    /**
     * Type of scene captured.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneCaptureType
    |
    /**
     * Degree of overall image gain adjustment.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GainControl
    |
    /**
     * Direction of contrast processing applied by the camera.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Contrast
    |
    /**
     * Direction of saturation processing applied by the camera.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Saturation
    |
    /**
     * The direction of sharpness processing applied by the camera.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Sharpness
    |
    /**
     * Information on picture-taking conditions for a specific camera model.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DeviceSettingDescription
    |
    /**
     * Indicates the distance range to the subject.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubjectDistanceRange
    |
    /**
     * An identifier uniquely assigned to each image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ImageUniqueId
    |
    /**
     * The version of the GPSInfoIFD.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsVersionId
    |
    /**
     * Reference altitude used for GPS altitude.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAltitudeRef
    |
    /**
     * The altitude based on the reference in GPSAltitudeRef.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAltitude
    |
    /**
     * The GPS satellites used for measurements.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSatellites
    |
    /**
     * The status of the GPS receiver when the image is recorded.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsStatus
    |
    /**
     * The GPS measurement mode.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsMeasureMode
    |
    /**
     * The GPS DOP (data degree of precision).
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDop
    |
    /**
     * The unit used to express the GPS receiver speed of movement.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSpeedRef
    |
    /**
     * The speed of GPS receiver movement.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsSpeed
    |
    /**
     * The reference for giving the direction of GPS receiver movement.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTrackRef
    |
    /**
     * The direction of GPS receiver movement.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsTrack
    |
    /**
     * The reference for the image's direction.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsImgDirectionRef
    |
    /**
     * The direction of the image when captured.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsImgDirection
    |
    /**
     * Geodetic survey data used by the GPS receiver.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsMapDatum
    |
    /**
     * Indicates the latitude reference of the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLatitudeRef
    |
    /**
     * The latitude of the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLatitude
    |
    /**
     * Indicates the longitude reference of the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLongitudeRef
    |
    /**
     * The longitude of the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestLongitude
    |
    /**
     * The reference for the bearing to the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestBearingRef
    |
    /**
     * The bearing to the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestBearing
    |
    /**
     * The measurement unit for the distance to the target point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestDistanceRef
    |
    /**
     * The distance to the destination point.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDestDistance
    |
    /**
     * A character string recording the name of the method used for location finding.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsProcessingMethod
    |
    /**
     * A character string recording the name of the GPS area.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsAreaInformation
    |
    /**
     * This field denotes if differential correction was applied to GPS data, crucial for precise location accuracy.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsDifferential
    |
    /**
     * The serial number of the camera body.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BodySerialNumber
    |
    /**
     * The name of the camera owner.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CameraOwnerName
    |
    /**
     * Indicates whether the image is a composite image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CompositeImage
    |
    /**
     * The compression mode used for a compressed image, in unit bits per pixel.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CompressedBitsPerPixel
    |
    /**
     * The DNGVersion tag encodes the four-tier version number for DNG specification compliance.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DngVersion
    |
    /**
     * DefaultCropSize specifies the final image size in raw coordinates, accounting for extra edge pixels.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    DefaultCropSize
    |
    /**
     * Indicates the value of coefficient gamma.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    Gamma
    |
    /**
     * The tag indicate the ISO speed latitude yyy value of the camera or input device that is defined in ISO 12232.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedLatitudeyyy
    |
    /**
     * The tag indicate the ISO speed latitude zzz value of the camera or input device that is defined in ISO 12232.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsoSpeedLatitudezzz
    |
    /**
     * The manufacturer of the lens.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensMake
    |
    /**
     * The model name of the lens.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensModel
    |
    /**
     * The serial number of the lens.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensSerialNumber
    |
    /**
     * Specifications of the lens used.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    LensSpecification
    |
    /**
     * This tag provides a broad description of the data type in this subfile.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    NewSubfileType
    |
    /**
     * This tag records the UTC offset for the DateTime tag, ensuring accurate timestamps regardless of location.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTime
    |
    /**
     * This tag records the UTC offset when the image was digitized, aiding in accurate timestamp adjustment.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTimeDigitized
    |
    /**
     * This tag records the UTC offset when the original image was created, crucial for time-sensitive applications.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    OffsetTimeOriginal
    |
    /**
     * Exposure times of source images for a composite image, such as 1/33 sec.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SourceExposureTimesOfCompositeImage
    |
    /**
     * The number of source images used for a composite image.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SourceImageNumberOfCompositeImage
    |
    /**
     * This deprecated tag indicates the data type in this subfile. Use NewSubfileType instead.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SubfileType
    |
    /**
     * This tag indicates horizontal positioning errors in meters.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    GpsHPositioningError
    |
    /**
     * This tag indicates the sensitivity of the camera or input device when the image was shot.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    PhotographicSensitivity
    |
    /**
     * Burst Number
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    BurstNumber
    |
    /**
     * Face Conf
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceConf
    |
    /**
     * Face Leye Center
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceLeyeCenter
    |
    /**
     * Face Mouth Center
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceMouthCenter
    |
    /**
     * Face Pointer
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FacePointer
    |
    /**
     * Face Rect
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceRect
    |
    /**
     * Face Reye Center
     */ 
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceReyeCenter
    |
    /**
     * Face Smile Score
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceSmileScore
    |
    /**
     * Face Version
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FaceVersion
    |
    /**
     * Front Camera
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    FrontCamera
    |
    /**
     * Scene Pointer
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    ScenePointer
    |
    /**
     * Scene Version
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    SceneVersion
    |
    /**
     * Is Xmage Supported
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    IsXmageSupported
    |
    /**
     * Xmage Mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageMode
    |
    /**
     * Xmage X1 Coordinate
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageLeft
    |
    /**
     * Xmage Y1 Coordinate
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageTop
    |
    /**
     * Xmage X2 Coordinate
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageRight
    |
    /**
     * Xmage Y2 Coordinate
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    XmageBottom
    |
    /**
     * Cloud Enhancement Mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    CloudEnhancementMode
    |
    /**
     * Wind Snapshot Mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Image.Core"
    ]
    WindSnapshotMode
    |
    /**
     * GIF LOOP COUNT
     */
    @!APILevel[
        since: "24",
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
