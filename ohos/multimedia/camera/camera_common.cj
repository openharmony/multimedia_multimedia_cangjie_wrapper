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

package ohos.multimedia.camera

import ohos.ffi.*
import ohos.hilog.*
import ohos.business_exception.*
import ohos.callback_invoke.*
import std.collection.*
import std.sync.*
import std.deriving.Derive
import ohos.labels.*

const LOG_DOMAIN: UInt32 = 0xD002B00
let CAMERA_LOG = HilogChannel(0, LOG_DOMAIN, "CJ-Camera")

func paramError(needed: String, mustbe: String): String {
    return "Parameter error. The " + needed + " must be " + mustbe + "."
}

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (7400101, "Parameter missing or parameter type incorrect."),
        (7400102, "Operation not allowed."),
        (7400103, "Session not config."),
        (7400104, "Session not running."),
        (7400105, "Session config locked."),
        (7400106, "Device setting locked."),
        (7400107, "Can not use camera cause of conflict."),
        (7400108, "Camera disabled cause of security reason."),
        (7400109, "Can not use camera cause of preempted."),
        (7400110, "Unresolved conflicts with current configurations."),
        (7400201, "Camera service fatal error.")
    ]
)

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error. Error code is ${code}"
    }
}

func successOrThrow(errCode: Int32): Unit {
    if (errCode != SUCCESS_CODE) {
        throw BusinessException(errCode, getErrorMsg(errCode))
    }
}

func findCallbackObject(list: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject): Bool {
    for (item in list) {
        if (refEq(callback, item[0])) {
            return true
        }
    }
    return false
}

/**
 * Rectangle definition.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class Rect {
    /**
     * X coordinator of top left point.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var topLeftX: Float64
    /**
     * Y coordinator of top left point.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var topLeftY: Float64
    /**
     * Width of this rectangle.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var width: Float64
    /**
     * Height of this rectangle.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var height: Float64

    init(topLeftX: Float64, topLeftY: Float64, width: Float64, height: Float64) {
        this.topLeftX = topLeftX
        this.topLeftY = topLeftY
        this.width = width
        this.height = height
    }
}

/**
 * Enum for torch mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum TorchMode {
    /**
     * The device torch is always off.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Off
    |
    /**
     * The device torch is always on.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    On
    |
    /**
     * The device continuously monitors light levels and uses the torch when necessary.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Auto
    | ...

    static func parse(val: Int32) {
        match (val) {
            case 0 => Off
            case 1 => On
            case 2 => Auto
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case Off => 0
            case On => 1
            case Auto => 2
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enumerates the image rotation angles.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum ImageRotation {
    /**
     * The capture image rotates 0 degrees.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Rotation0
    |
    /**
     * The capture image rotates 90 degrees.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Rotation90
    |
    /**
     * The capture image rotates 180 degrees.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Rotation180
    |
    /**
     * The capture image rotates 270 degrees.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Rotation270
    | ...

    func getValue(): Int32 {
        match (this) {
            case Rotation0 => 0
            case Rotation90 => 90
            case Rotation180 => 180
            case Rotation270 => 270
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 0 => Rotation0
            case 90 => Rotation90
            case 180 => Rotation180
            case 270 => Rotation270
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enum for camera status.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum CameraStatus {
    /**
     * Appear status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraStatusAppear
    |
    /**
     * Disappear status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraStatusDisappear
    |
    /**
     * Available status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraStatusAvailable
    |
    /**
     * Unavailable status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraStatusUnavailable
    | ...

    static func parse(val: Int32) {
        match (val) {
            case 0 => CameraStatusAppear
            case 1 => CameraStatusDisappear
            case 2 => CameraStatusAvailable
            case 3 => CameraStatusUnavailable
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Torch status info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class TorchStatusInfo {
    /**
     * is torch available
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let isTorchAvailable: Bool
    /**
     * is torch active
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let isTorchActive: Bool
    /**
     * the current torch brightness level.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let torchLevel: Float64

    init(isTorchAvailable: Bool, isTorchActive: Bool, torchLevel: Float64) {
        this.isTorchAvailable = isTorchAvailable
        this.isTorchActive = isTorchActive
        this.torchLevel = torchLevel
    }
}

/**
 * Frame rate range.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class FrameRateRange {
    /**
     * Min frame rate.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let min: Int32
    /**
     * Max frame rate.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let max: Int32

    init(min_frame: Int32, max_frame: Int32) {
        min = min_frame
        max = max_frame
    }
}

/**
 * Size parameter.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class Size {
    /**
     * Height.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var width: UInt32
    /**
     * Width.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var height: UInt32

    init(width: UInt32, height: UInt32) {
        this.width = width
        this.height = height
    }
}

class ProfileImpl {}

/**
 * Profile for camera streams.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public open class Profile {
    /**
     * Camera format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let format: CameraFormat
    /**
     * Picture size.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let size: Size

    let impl: ProfileImpl = ProfileImpl()

    init(cameraFormat: Int32, width: UInt32, height: UInt32) {
        format = CameraFormat.parse(cameraFormat)
        size = Size(width, height)
    }
}

/**
 * Video profile.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class VideoProfile <: Profile {
    /**
     * Frame rate in unit fps (frames per second).
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let frameRateRange: FrameRateRange

    init(cameraFormat: Int32, width: UInt32, height: UInt32, min_frame: Int32, max_frame: Int32) {
        super(cameraFormat, width, height)
        frameRateRange = FrameRateRange(min_frame, max_frame)
    }
}

/**
 * Metadata object type.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum MetadataObjectType {
    /**
     * Face detection type.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FaceDetection
    | ...

    func getValue(): Int32 {
        match (this) {
            case MetadataObjectType.FaceDetection => 0
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    static func parse(val: Int32): MetadataObjectType {
        match (val) {
            case 0 => MetadataObjectType.FaceDetection
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Camera output capability.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CameraOutputCapability {
    /**
     * Preview profiles.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let previewProfiles: Array<Profile>
    /**
     * Photo profiles.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let photoProfiles: Array<Profile>
    /**
     * Video profiles.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let videoProfiles: Array<VideoProfile>
    /**
     * All the supported metadata Object Types.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let supportedMetadataObjectTypes: Array<MetadataObjectType>

    init(previewProfiles: Array<Profile>, photoProfiles: Array<Profile>, videoProfiles: Array<VideoProfile>,
        supportedMetadataObjectTypes: Array<MetadataObjectType>) {
        this.previewProfiles = previewProfiles
        this.photoProfiles = photoProfiles
        this.videoProfiles = videoProfiles
        this.supportedMetadataObjectTypes = supportedMetadataObjectTypes
    }
}

/**
 * Enum for fold status.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum FoldStatus {
    /**
     * Non-foldable status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    NonFoldable
    |
    /**
     * Expanded status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Expanded
    |
    /**
     * Folded status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Folded
    | ...

    static func parse(val: Int32): FoldStatus {
        match (val) {
            case 0 => NonFoldable
            case 1 => Expanded
            case 2 => Folded
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Fold status info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class FoldStatusInfo {
    /**
     * Gets supported camera devices under the current fold status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let supportedCameras: Array<CameraDevice>
    /**
     * Current fold status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let foldStatus: FoldStatus

    /**
     * FoldStatusInfo constructor.
     */
    init(supportedCameras: Array<CameraDevice>, foldStatus: FoldStatus) {
        this.supportedCameras = supportedCameras
        this.foldStatus = foldStatus
    }
}

/**
 * Enum for camera connection type.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum ConnectionType {
    /**
     * Built-in camera.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraConnectionBuiltIn
    |
    /**
     * Camera connected using USB
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraConnectionUsbPlugin
    |
    /**
     * Remote camera
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraConnectionRemote
    | ...

    static func parse(val: Int32): ConnectionType {
        match (val) {
            case 0 => CameraConnectionBuiltIn
            case 1 => CameraConnectionUsbPlugin
            case 2 => CameraConnectionRemote
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case CameraConnectionBuiltIn => 0
            case CameraConnectionUsbPlugin => 1
            case CameraConnectionRemote => 2
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enum for camera format type.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum CameraFormat {
    /**
     * YCBCR P010 Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatYcbcrP010
    |
    /**
     * YCRCB P010 Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatYcrcbP010
    |
    /**
     * HEIC Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatHeic
    |
    /**
     * JPEG Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatJpeg
    |
    /**
     * YUV 420 Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatYuv420Sp
    |
    /**
     * RGBA 8888 Format.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraFormatRgba8888
    | ...

    func getValue(): Int32 {
        match (this) {
            case CameraFormatYcrcbP010 => 2002
            case CameraFormatYcbcrP010 => 2001
            case CameraFormatHeic => 2003
            case CameraFormatJpeg => 2000
            case CameraFormatYuv420Sp => 1003
            case CameraFormatRgba8888 => 3
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    static func parse(val: Int32): CameraFormat {
        match (val) {
            case 2002 => CameraFormatYcrcbP010
            case 2001 => CameraFormatYcbcrP010
            case 2003 => CameraFormatHeic
            case 2000 => CameraFormatJpeg
            case 1003 => CameraFormatYuv420Sp
            case 3 => CameraFormatRgba8888
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Camera device object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CameraDevice {
    /**
     * Camera ID attribute.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let cameraId: String
    /**
     * Camera position attribute.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let cameraPosition: CameraPosition
    /**
     * Camera type attribute.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let cameraType: CameraType
    /**
     * Camera connection type attribute.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let connectionType: ConnectionType
    /**
     * Camera sensor orientation attribute.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public let cameraOrientation: UInt32

    init(cameraId: String, cameraPosition: CameraPosition, cameraType: CameraType, connectionType: ConnectionType,
        cameraOrientation: UInt32) {
        this.cameraId = cameraId
        this.cameraPosition = cameraPosition
        this.cameraType = cameraType
        this.connectionType = connectionType
        this.cameraOrientation = cameraOrientation
    }
}

/**
 * Camera status info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CameraStatusInfo {
    /**
     * Camera instance.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var camera: CameraDevice
    /**
     * Current camera status.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var status: CameraStatus

    /**
     * CameraStatusInfo constructor.
     */
    init(camera: CameraDevice, status: CameraStatus) {
        this.camera = camera
        this.status = status
    }
}

/**
 * camera event type.
 */
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum CameraEvents {
    /**
     * camera error event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraError
    |
    /**
     * camera status event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraStatus
    |
    /**
     * fold status change event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FoldStatusChange
    |
    /**
     * torch status change event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    TorchStatusChange
    |
    /**
     * frame start event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FrameStart
    |
    /**
     * frame end event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FrameEnd
    |
    /**
     * capture start withInfo event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CaptureStartWithInfo
    |
    /**
     * frame shutter event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FrameShutter
    |
    /**
     * capture end event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CaptureEnd
    |
    /**
     * frame shutter end event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FrameShutterEnd
    |
    /**
     * capture ready event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CaptureReady
    |
    /**
     * estimated capture duration event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    EstimatedCaptureDuration
    |
    /**
     * metadata objects available event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    MetadataObjectsAvailable
    |
    /**
     * focus state change event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusStateChange
    |
    /**
     * smooth zoom info available event.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    SmoothZoomInfoAvailable
    | ...

    /**
     * Obtaining the string value of CameraEvents.
     *
     * @throws IllegalArgumentException - The type is not supported.
     */
    func toString(): String {
        return match (this) {
            case CameraError => "error"
            case CameraStatus => "cameraStatus"
            case FoldStatusChange => "foldStatusChange"
            case TorchStatusChange => "torchStatusChange"
            case FrameStart => "frameStart"
            case FrameEnd => "frameEnd"
            case CaptureStartWithInfo => "captureStartWithInfo"
            case FrameShutter => "frameShutter"
            case CaptureEnd => "captureEnd"
            case FrameShutterEnd => "frameShutterEnd"
            case CaptureReady => "captureReady"
            case EstimatedCaptureDuration => "estimatedCaptureDuration"
            case MetadataObjectsAvailable => "metadataObjectsAvailable"
            case FocusStateChange => "focusStateChange"
            case SmoothZoomInfoAvailable => "smoothZoomInfoAvailable"
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enum for camera position.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum CameraPosition {
    /**
     * Unspecified position.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraPositionUnspecified
    |
    /**
     * Back position.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraPositionBack
    |
    /**
     * Front position.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraPositionFront
    | ...

    static func parse(code: Int32): CameraPosition {
        match (code) {
            case 0 => CameraPositionUnspecified
            case 1 => CameraPositionBack
            case 2 => CameraPositionFront
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case CameraPositionUnspecified => 0
            case CameraPositionBack => 1
            case CameraPositionFront => 2
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enum for camera type.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum CameraType {
    /**
     * Default camera type
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraTypeDefault
    |
    /**
     * Wide camera
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraTypeWideAngle
    |
    /**
     * Ultra wide camera
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraTypeUltraWide
    |
    /**
     * Telephoto camera
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraTypeTelephoto
    |
    /**
     * True depth camera
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    CameraTypeTrueDepth
    | ...

    static func parse(code: Int32): CameraType {
        match (code) {
            case 0 => CameraTypeDefault
            case 1 => CameraTypeWideAngle
            case 2 => CameraTypeUltraWide
            case 3 => CameraTypeTelephoto
            case 4 => CameraTypeTrueDepth
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case CameraTypeDefault => 0
            case CameraTypeWideAngle => 1
            case CameraTypeUltraWide => 2
            case CameraTypeTelephoto => 3
            case CameraTypeTrueDepth => 4
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enumerates the camera scene modes.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum SceneMode {
    /**
     * Normal photo mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    NormalPhoto
    |
    /**
     * Normal video mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    NormalVideo
    |
    /**
     * Secure camera mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    SecurePhoto
    | ...

    static func parse(code: Int32): SceneMode {
        match (code) {
            case 1 => NormalPhoto
            case 2 => NormalVideo
            case 12 => SecurePhoto
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case NormalPhoto => 1
            case NormalVideo => 2
            case SecurePhoto => 12
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enumerates the image quality levels.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum QualityLevel {
    /**
     * High image quality.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    QualityLevelHigh
    |
    /**
     * Medium image quality.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    QualityLevelMedium
    |
    /**
     * Low image quality.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    QualityLevelLow
    | ...

    func getValue(): Int32 {
        match (this) {
            case QualityLevelHigh => 0
            case QualityLevelMedium => 1
            case QualityLevelLow => 2
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Photo capture location
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class Location {
    /**
     * Latitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var latitude: Float64
    /**
     * Longitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var longitude: Float64
    /**
     * Altitude.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var altitude: Float64

    /**
     * Location constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public init(latitude: Float64, longitude: Float64, altitude: Float64) {
        this.latitude = latitude
        this.longitude = longitude
        this.altitude = altitude
    }

    func toExternal(): CLocation {
        return CLocation(latitude, longitude, altitude)
    }
}

/**
 * Photo capture options to set.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class PhotoCaptureSetting {
    /**
     * Photo image quality.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var quality: QualityLevel
    /**
     * Photo rotation.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var rotation: ImageRotation
    /**
     * Photo location.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var location: ?Location
    /**
     * Mirror enable switch (default off).
     * It is necessary to utilize the function isMirrorSupported to ascertain whether it is supported
     * prior to its implementation.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var mirror: Bool

    /**
     * PhotoCaptureSetting constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public init(
        quality!: QualityLevel = QualityLevel.QualityLevelLow,
        rotation!: ImageRotation = ImageRotation.Rotation0,
        location!: ?Location = None,
        mirror!: Bool = false
    ) {
        this.quality = quality
        this.rotation = rotation
        this.location = location
        this.mirror = mirror
    }
}

/**
 * Enumerates the camera video codec type.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum VideoCodecType {
    /**
     * Video encoding type AVC.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Avc
    |
    /**
     * Video encoding type HEVC.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Hevc
    | ...

    func getValue(): Int32 {
        match (this) {
            case Avc => 0
            case Hevc => 1
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Capture start info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CaptureStartInfo {
    /**
     * Capture id.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var captureId: Int32
    /**
     * Time(in milliseconds) is the shutter time for the photo.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var time: Int64

    init(captureId: Int32, time: Int64) {
        this.captureId = captureId
        this.time = time
    }
}

/**
 * Frame shutter callback info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class FrameShutterInfo {
    /**
     * Capture id.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var captureId: Int32
    /**
     * Timestamp for frame.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var timestamp: Int64

    init(captureId: Int32, timestamp: Int64) {
        this.captureId = captureId
        this.timestamp = timestamp
    }
}

/**
 * Capture end info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CaptureEndInfo {
    /**
     * Capture id.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var captureId: Int32
    /**
     * Frame count.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var frameCount: Int32

    init(captureId: Int32, frameCount: Int32) {
        this.captureId = captureId
        this.frameCount = frameCount
    }
}

/**
 * Frame shutter end callback info.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class FrameShutterEndInfo {
    /**
     * Capture id.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var captureId: Int32

    init(captureId: Int32) {
        this.captureId = captureId
    }
}

/**
 * Types of preconfig, which used to configure session conveniently.
 * Preconfig type contains common use cases of camera output.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum PreconfigType {
    /**
     * 720P output for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Preconfig720p
    |
    /**
     * 1080P output for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Preconfig1080p
    |
    /**
     * 4K output for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Preconfig4k
    |
    /**
     * high quality output for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    PreconfigHighQuality
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Preconfig720p => 0
                case Preconfig1080p => 1
                case Preconfig4k => 2
                case PreconfigHighQuality => 3
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): PreconfigType {
        return match (value) {
            case 0 => Preconfig720p
            case 1 => Preconfig1080p
            case 2 => Preconfig4k
            case 3 => PreconfigHighQuality
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * The aspect ratios of preconfig, which used to configure session conveniently.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum PreconfigRatio {
    /**
     * Aspect ratio 1:1 for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    PreconfigRatio_1_1
    |
    /**
     * Aspect ratio 4:3 for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    PreconfigRatio_4_3
    |
    /**
     * Aspect ratio 16:9 for preconfig.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    PreconfigRatio_16_9
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case PreconfigRatio_1_1 => 0
                case PreconfigRatio_4_3 => 1
                case PreconfigRatio_16_9 => 2
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): PreconfigRatio {
        return match (value) {
            case 0 => PreconfigRatio_1_1
            case 1 => PreconfigRatio_4_3
            case 2 => PreconfigRatio_16_9
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

func offAll(idClassInfo: IdClassInfo, callbackList: ArrayList<(CallbackObject, Int64)>, onOffMutex: Mutex,
    offAllFunc: CFunc<(Int64) -> Int32>): Unit {
    synchronized(onOffMutex) {
        if (callbackList.size == 0) {
            CAMERA_LOG.error("${idClassInfo.className} off failed: The event is not registered")
            return
        }
        unsafe {
            let errCode = offAllFunc(idClassInfo.id)
            if (errCode != SUCCESS_CODE) {
                throw BusinessException(errCode, getErrorMsg(errCode))
            } else {
                callbackList.clear()
            }
        }
    }
}

func off(idClassInfo: IdClassInfo, callbackList: ArrayList<(CallbackObject, Int64)>, onOffMutex: Mutex,
    callback: CallbackObject, offFunc: CFunc<(Int64, Int64) -> Int32>): Unit {
    synchronized(onOffMutex) {
        if (callbackList.size == 0) {
            CAMERA_LOG.error("${idClassInfo.className} Off failed: The event is not registered")
            return
        }
        unsafe {
            callbackList.removeIf(
                {
                    item => if (refEq(item[0], callback)) {
                        let errCode = offFunc(idClassInfo.id, item[1])
                        successOrThrow(errCode)
                        true
                    } else {
                        CAMERA_LOG.error("${idClassInfo.className} Off failed: The callback is not registered")
                        false
                    }
                })
        }
    }
}

struct IdClassInfo {
    let id: Int64
    let className: String

    init(id: Int64, className: String) {
        this.id = id
        this.className = className
    }
}
