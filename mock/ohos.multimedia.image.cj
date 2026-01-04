/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import ohos.callback_invoke.Callback0Argument
import ohos.graphics.color_space_manager.ColorSpaceManager
import ohos.labels.APILevel
import ohos.resource_manager.RawFileDescriptor
import ohos.ffi.*

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class ImageInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var size: Size

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var density: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var stride: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var pixelFormat: PixelMapFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var alphaType: AlphaType

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var mimeType: String

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var isHdr: Bool
    
    public init() {
        super()
        this.size = Size(
            0,
            0
        )
        this.density = 0
        this.stride = 0
        this.pixelFormat = PixelMapFormat.Unknown
        this.alphaType = AlphaType.Unknown
        this.mimeType = String()
        this.isHdr = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class SourceOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var sourceDensity: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var sourcePixelFormat: PixelMapFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var sourceSize: Size

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public init(sourceDensity: Int32, sourcePixelFormat!: PixelMapFormat = PixelMapFormat.Unknown,
        sourceSize!: Size = Size(0, 0)) {
        super()
        this.sourceDensity = 0
        this.sourcePixelFormat = PixelMapFormat.Unknown
        this.sourceSize = Size(
            0,
            0
        )
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class InitializationOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var alphaType: AlphaType

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var editable: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var srcPixelFormat: PixelMapFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var pixelFormat: PixelMapFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var scaleMode: ScaleMode

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var size: Size

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public init(size: Size, alphaType!: AlphaType = AlphaType.Premul, editable!: Bool = false,
        srcPixelFormat!: PixelMapFormat = PixelMapFormat.Bgra8888,
        pixelFormat!: PixelMapFormat = PixelMapFormat.Rgba8888, scaleMode!: ScaleMode = ScaleMode.FitTargetSize) {
        super()
        this.alphaType = AlphaType.Unknown
        this.editable = true
        this.srcPixelFormat = PixelMapFormat.Unknown
        this.pixelFormat = PixelMapFormat.Unknown
        this.scaleMode = ScaleMode.FitTargetSize
        this.size = Size(
            0,
            0
        )
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
public class DecodingOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var index: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var sampleSize: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var rotate: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var editable: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var desiredSize: Size

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var desiredRegion: Region

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var desiredPixelFormat: PixelMapFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var fitDensity: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var desiredColorSpace: ?ColorSpaceManager

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var desiredDynamicRange: DecodingDynamicRange

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public init(sampleSize!: UInt32 = 1, rotate!: UInt32 = 0, editable!: Bool = false, desiredSize!: Size = Size(0, 0),
        desiredRegion!: Region = Region(Size(0, 0), 0, 0), desiredPixelFormat!: PixelMapFormat = Unknown,
        index!: UInt32 = 0, fitDensity!: Int32 = 0, desiredColorSpace!: ?ColorSpaceManager = None,
        desiredDynamicRange!: DecodingDynamicRange = Sdr) {
        super()
        this.index = 0
        this.sampleSize = 0
        this.rotate = 0
        this.editable = true
        this.desiredSize = Size(
            0,
            0
        )
        this.desiredRegion = Region(
            Size(
                0,
                0
            ),
            0,
            0
        )
        this.desiredPixelFormat = PixelMapFormat.Unknown
        this.fitDensity = 0
        this.desiredColorSpace = None
        this.desiredDynamicRange = DecodingDynamicRange.Auto
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class PositionArea {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var pixels: Array<UInt8>

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var offset: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var stride: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var region: Region

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public init(pixels: Array<UInt8>, offset: UInt32, stride: UInt32, region: Region) {
        super()
        this.pixels = Array()
        this.offset = 0
        this.stride = 0
        this.region = Region(
            Size(
                0,
                0
            ),
            0,
            0
        )
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class Size {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var height: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var width: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public init(height: Int32, width: Int32) {
        super()
        this.height = 0
        this.width = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class Region {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var size: Size

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var x: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public var y: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public init(size: Size, x: Int32, y: Int32) {
        super()
        this.size = Size(
            0,
            0
        )
        this.x = 0
        this.y = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class Component {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public let componentType: ComponentType

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public let rowStride: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public let pixelStride: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public let byteBuffer: Array<UInt8>
    
    public init() {
        super()
        this.componentType = ComponentType.YuvY
        this.rowStride = 0
        this.pixelStride = 0
        this.byteBuffer = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
public class PackingOption {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public var format: String

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public var quality: UInt8

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public var bufferSize: UInt64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public var desiredDynamicRange: PackingDynamicRange

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public var needsPackProperties: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
    public init(format: String, quality: UInt8, bufferSize!: UInt64 = 0,
        desiredDynamicRange!: PackingDynamicRange = Sdr, needsPackProperties!: Bool = false) {
        super()
        this.format = String()
        this.quality = 0
        this.bufferSize = 0
        this.desiredDynamicRange = PackingDynamicRange.Auto
        this.needsPackProperties = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
public class ImagePropertyOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var index: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public var defaultValue: String

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
    public init(index!: UInt32 = 0, defaultValue!: String = "") {
        super()
        this.index = 0
        this.defaultValue = String()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum PixelMapFormat {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Unknown
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Rgb565
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Rgba8888
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Bgra8888
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Rgb888
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Alpha8
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    RgbaF16
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Nv21
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Nv12
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Rgba1010102
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    YcbcrP010
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    YcrcbP010
    | ...
}

extend PixelMapFormat <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend PixelMapFormat <: Equatable<PixelMapFormat> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: PixelMapFormat): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: PixelMapFormat): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum AlphaType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Unknown
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Opaque
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Premul
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    UnPremul
    | ...
}

extend AlphaType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend AlphaType <: Equatable<AlphaType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: AlphaType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: AlphaType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum ScaleMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FitTargetSize
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    CenterCrop
    | ...
}

extend ScaleMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend ScaleMode <: Equatable<ScaleMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: ScaleMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: ScaleMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum ImageFormat {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Ycbcr422Sp
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Jpeg
    | ...
}

extend ImageFormat <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend ImageFormat <: Equatable<ImageFormat> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: ImageFormat): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: ImageFormat): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
public enum ComponentType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    YuvY
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    YuvU
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    YuvV
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    Jpeg
    | ...
}

extend ComponentType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    public func toString(): String {
        return String()
    }
}

extend ComponentType <: Equatable<ComponentType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    public operator func ==(other: ComponentType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    public operator func !=(other: ComponentType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum PropertyKey <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    BitsPerSample
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Orientation
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ImageLength
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ImageWidth
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsLatitude
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsLongitude
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsLatitudeRef
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsLongitudeRef
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    DateTimeOriginal
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ExposureTime
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneType
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    IsoSpeedRatings
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FNumber
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    DateTime
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsTimestamp
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    GpsDateStamp
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ImageDescription
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Make
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Model
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    PhotoMode
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SensitivityType
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    StandardOutputSensitivity
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    RecommendedExposureIndex
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    IsoSpeed
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ApertureValue
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    ExposureBiasValue
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    MeteringMode
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    LightSource
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Flash
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FocalLength
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    UserComment
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    PixelXDimension
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    PixelYDimension
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    WhiteBalance
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FocalLengthIn35mmFilm
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    CaptureMode
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    PhysicalAperture
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    RollAngle
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    PitchAngle
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneFoodConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneStageConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneBlueSkyConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneGreenPlantConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneBeachConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneSnowConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneSunsetConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneFlowersConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneNightConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    SceneTextConf
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FaceCount
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    FocusMode
    | ...

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend PropertyKey <: Equatable<PropertyKey> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: PropertyKey): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: PropertyKey): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum DecodingDynamicRange {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Auto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Sdr
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Hdr
    | ...
}

extend DecodingDynamicRange <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend DecodingDynamicRange <: Equatable<DecodingDynamicRange> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: DecodingDynamicRange): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: DecodingDynamicRange): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public enum PackingDynamicRange {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Auto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    Sdr
    | ...
}

extend PackingDynamicRange <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public func toString(): String {
        return String()
    }
}

extend PackingDynamicRange <: Equatable<PackingDynamicRange> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func ==(other: PackingDynamicRange): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
    public operator func !=(other: PackingDynamicRange): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class Image {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public prop clipRect: Region {
        
        get() {
            return Region(
                Size(
                    0,
                    0
                ),
                0,
                0
            )
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public prop size: Size {
        
        get() {
            return Size(
                0,
                0
            )
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public prop format: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func getComponent(componentType: ComponentType): Component {
        return Component()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
public class ImagePacker {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", throwexception: true]
    public prop supportedFormats: Array<String> {
        
        get() {
            return Array()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", throwexception: true, workerthread: true]
    public func packToData(source: ImageSource, options: PackingOption): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", throwexception: true, workerthread: true]
    public func packToData(source: PixelMap, options: PackingOption): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", throwexception: true, workerthread: true]
    public func packToFile(source: ImageSource, fd: Int32, options: PackingOption): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", throwexception: true, workerthread: true]
    public func packToFile(source: PixelMap, fd: Int32, options: PackingOption): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker", workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImagePacker"]
public func createImagePacker(): ImagePacker {
    return ImagePacker()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true]
public func createImageReceiver(size: Size, format: ImageFormat, capacity: Int32): ImageReceiver {
    return ImageReceiver()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
public class ImageReceiver {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true]
    public prop size: Size {
        
        get() {
            return Size(
                0,
                0
            )
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true]
    public prop capacity: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true]
    public prop format: ImageFormat {
        
        get() {
            return ImageFormat.Ycbcr422Sp
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true, workerthread: true]
    public func getReceivingSurfaceId(): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true, workerthread: true]
    public func readLatestImage(): Image {
        return Image()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", throwexception: true, workerthread: true]
    public func readNextImage(): Image {
        return Image()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    public func on(eventType: ReceiveType, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", workerthread: true]
    public func off(eventType: ReceiveType): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver", workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
public enum ReceiveType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageReceiver"]
    ImageArrival | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(uri: String): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(uri: String, options: SourceOptions): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(fd: Int32): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(fd: Int32, options: SourceOptions): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(buf: Array<UInt8>): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(buf: Array<UInt8>, options: SourceOptions): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
public func createImageSource(rawfile: RawFileDescriptor, options!: SourceOptions = SourceOptions(0)): ImageSource {
    return ImageSource()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource"]
public class ImageSource {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
    public prop supportedFormats: Array<String> {
        
        get() {
            return Array()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func getImageInfo(index!: UInt32 = 0): ImageInfo {
        return ImageInfo()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true]
    public func createPixelMap(options!: DecodingOptions = DecodingOptions()): PixelMap {
        return PixelMap()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func createPixelMapList(options!: DecodingOptions = DecodingOptions()): Array<PixelMap> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func getDelayTimeList(): Array<Int32> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func getFrameCount(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func getImageProperty(key: PropertyKey, options!: ImagePropertyOptions = ImagePropertyOptions()): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func modifyImageProperty(key: PropertyKey, value: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func updateData(buf: Array<UInt8>, isFinished: Bool, offset: UInt32, length: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.ImageSource", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
public func createPixelMap(colors: Array<UInt8>, options: InitializationOptions): PixelMap {
    return PixelMap()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core"]
public class PixelMap <: RemoteDataLite {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public prop isEditable: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public prop isStrideAlignment: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func readPixelsToBuffer(dst: Array<UInt8>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func readPixels(area: PositionArea): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func writePixels(area: PositionArea): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func writeBufferToPixels(src: Array<UInt8>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func getImageInfo(): ImageInfo {
        return ImageInfo()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func getBytesNumberPerRow(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func getPixelBytesNumber(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func getDensity(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func opacity(rate: Float32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func createAlphaPixelMap(): PixelMap {
        return PixelMap()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func scale(x: Float32, y: Float32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func translate(x: Float32, y: Float32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func rotate(angle: Float32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func flip(horizontal: Bool, vertical: Bool): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func crop(region: Region): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func getColorSpace(): ColorSpaceManager {
        return ColorSpaceManager()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true]
    public func setColorSpace(colorSpace: ColorSpaceManager): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func applyColorSpace(targetColorSpace: ColorSpaceManager): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Image.Core", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init(id: Int64) {
    }

    public init() {
    }
}