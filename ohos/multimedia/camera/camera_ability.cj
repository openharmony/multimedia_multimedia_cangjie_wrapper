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

import ohos.graphics.color_space_manager.ColorSpace
import ohos.labels.*
import ohos.ffi.*
import ohos.business_exception.BusinessException

import std.deriving.Derive

foreign {
    func FfiCameraAutoExposureIsExposureModeSupported(id: Int64, aeMode: Int32, errCode: CPointer<Int32>): Bool

    func FfiCameraAutoExposureGetExposureBiasRange(id: Int64, errCode: CPointer<Int32>): CArrFloat32

    func FfiCameraAutoExposureGetExposureMode(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiCameraAutoExposureSetExposureMode(id: Int64, aeMode: Int32, errCode: CPointer<Int32>): Unit

    func FfiCameraAutoExposureGetMeteringPoint(id: Int64, errCode: CPointer<Int32>): CPoint

    func FfiCameraAutoExposureSetMeteringPoint(id: Int64, point: CPoint, errCode: CPointer<Int32>): Unit

    func FfiCameraAutoExposureSetExposureBias(id: Int64, exposureBias: Float32, errCode: CPointer<Int32>): Unit

    func FfiCameraAutoExposureGetExposureValue(id: Int64, errCode: CPointer<Int32>): Float32

    func FfiCameraColorManagementGetSupportedColorSpaces(id: Int64, errCode: CPointer<Int32>): CArrI32

    func FfiCameraColorManagementSetColorSpace(id: Int64, colorSpace: Int32, errCode: CPointer<Int32>): Unit

    func FfiCameraColorManagementGetActiveColorSpace(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiCameraFlashQueryFlashModeSupported(id: Int64, focusMode: Int32, errCode: CPointer<Int32>): Bool

    func FfiCameraFlashQueryHasFlash(id: Int64, errCode: CPointer<Int32>): Bool

    func FfiCameraFlashGetFlashMode(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiCameraFlashSetFlashMode(id: Int64, flashMode: Int32, errCode: CPointer<Int32>): Unit

    func FfiCameraFocusIsFocusModeSupported(id: Int64, afMode: Int32, errCode: CPointer<Int32>): Bool

    func FfiCameraFocusSetFocusMode(id: Int64, afMode: Int32, errCode: CPointer<Int32>): Unit

    func FfiCameraFocusGetFocusMode(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiCameraFocusSetFocusPoint(id: Int64, point: CPoint, errCode: CPointer<Int32>): Unit

    func FfiCameraFocusGetFocusPoint(id: Int64, errCode: CPointer<Int32>): CPoint

    func FfiCameraFocusGetFocalLength(id: Int64, errCode: CPointer<Int32>): Float32

    func FfiCameraStabilizationIsVideoStabilizationModeSupported(id: Int64, vsMode: Int32, errCode: CPointer<Int32>): Bool

    func FfiCameraStabilizationGetActiveVideoStabilizationMode(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiCameraStabilizationSetVideoStabilizationMode(id: Int64, vsMode: Int32, errCode: CPointer<Int32>): Unit

    func FfiCameraZoomGetZoomRatioRange(id: Int64, errCode: CPointer<Int32>): CArrFloat32

    func FfiCameraZoomSetZoomRatio(id: Int64, zoomRatio: Float32, errCode: CPointer<Int32>): Unit

    func FfiCameraZoomGetZoomRatio(id: Int64, errCode: CPointer<Int32>): Float32

    func FfiCameraZoomSetSmoothZoom(id: Int64, targetRatio: Float32, mode: Int32, errCode: CPointer<Int32>): Unit
}

@C
struct CPoint {
    CPoint(var x: Float32, var y: Float32) {}
}

/**
 * Point coordinates are used for focus and exposure configuration.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class Point {
    /**
     * x co-ordinate
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var x: Float64

    /**
     * y co-ordinate
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var y: Float64

    /**
     * Point constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public init(x: Float64, y: Float64) {
        this.x = x
        this.y = y
    }

    init(cPoint: CPoint) {
        this.x = Float64(cPoint.x)
        this.y = Float64(cPoint.y)
    }

    func asCPoint(): CPoint {
        return CPoint(Float32(this.x), Float32(this.y))
    }
}

/**
 * Enum for exposure mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum ExposureMode {
    /**
     * Lock exposure mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    ExposureModeLocked
    |
    /**
     * Auto exposure mode. Exposure area center point can be set by AutoExposure.setMeteringPoint interface.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    ExposureModeAuto
    |
    /**
     * Continuous automatic exposure.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    ExposureModeContinuousAuto
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case ExposureModeLocked => 0
                case ExposureModeAuto => 1
                case ExposureModeContinuousAuto => 2
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): ExposureMode {
        return match (value) {
            case 0 => ExposureModeLocked
            case 1 => ExposureModeAuto
            case 2 => ExposureModeContinuousAuto
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * AutoExposureQuery object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface AutoExposureQuery {
    /**
     * Checks whether a specified exposure mode is supported.
     *
     * @param { ExposureMode } aeMode - Exposure mode
     * @returns { Bool } Is the exposure mode supported.
     * @throws { BusinessException } 7400103 - Session not config, only throw in session usage.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func isExposureModeSupported(aeMode: ExposureMode): Bool {
        var errCode: Int32 = 0
        let ret: Bool = unsafe {
            FfiCameraAutoExposureIsExposureModeSupported((this as RemoteDataLite).getOrThrow().getID(), aeMode.value,
                inout errCode)
        }
        successOrThrow(errCode)

        return ret
    }

    /**
     * Query the exposure compensation range.
     *
     * @returns { Array<Float64> } The array of compensation range.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getExposureBiasRange(): Array<Float64> {
        var errCode: Int32 = 0
        let cArray: CArrFloat32 = unsafe {
            FfiCameraAutoExposureGetExposureBiasRange((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        let res = cArray.toArrayF64()
        cArray.free()
        successOrThrow(errCode)
        return res
    }
}

/**
 * AutoExposure object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface AutoExposure <: AutoExposureQuery {
    /**
     * Gets current exposure mode.
     *
     * @returns { ExposureMode } The current exposure mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getExposureMode(): ExposureMode {
        var errCode: Int32 = 0
        let ret: Int32 = unsafe {
            FfiCameraAutoExposureGetExposureMode((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        successOrThrow(errCode)
        return ExposureMode.parse(ret)
    }

    /**
     * Sets Exposure mode.
     *
     * @param { ExposureMode } aeMode - Exposure mode
     * @throws { BusinessException } 7400102 - Operation not allowed.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setExposureMode(aeMode: ExposureMode): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraAutoExposureSetExposureMode((this as RemoteDataLite).getOrThrow().getID(), aeMode.value,
                inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Gets current metering point.
     *
     * @returns { Point } The current metering point.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getMeteringPoint(): Point {
        var errCode: Int32 = 0
        let cPoint: CPoint = unsafe {
            FfiCameraAutoExposureGetMeteringPoint((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        successOrThrow(errCode)
        return Point(cPoint)
    }

    /**
     * Set the center point of the metering area.
     *
     * @param { Point } point - metering point
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setMeteringPoint(point: Point): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraAutoExposureSetMeteringPoint((this as RemoteDataLite).getOrThrow().getID(), point.asCPoint(),
                inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Set exposure compensation.
     *
     * @param { Float64 } exposureBias - Exposure compensation
     * @throws { BusinessException } 7400102 - Operation not allowed.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setExposureBias(exposureBias: Float64): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraAutoExposureSetExposureBias((this as RemoteDataLite).getOrThrow().getID(), Float32(exposureBias),
                inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Query the exposure value.
     *
     * @returns { Float64 } The exposure value.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getExposureValue(): Float64 {
        var errCode: Int32 = 0
        let ret: Float64 = unsafe {
            Float64(FfiCameraAutoExposureGetExposureValue((this as RemoteDataLite).getOrThrow().getID(), inout errCode))
        }
        successOrThrow(errCode)
        return ret
    }
}

/**
 * Color Management Query object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface ColorManagementQuery {
    /**
     * Gets the supported color space types.
     *
     * @returns { Array<colorSpaceManager.ColorSpace> } The array of the supported color space for the session.
     * @throws { BusinessException } 7400103 - Session not config, only throw in session usage.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getSupportedColorSpaces(): Array<ColorSpace> {
        var errCode: Int32 = 0
        let colorSpaces: CArrI32 = unsafe {
            FfiCameraColorManagementGetSupportedColorSpaces(
                (this as RemoteDataLite).getOrThrow().getID(),
                inout errCode
            )
        }
        try {
            return unsafe {
                successOrThrow(errCode)
                cArr2cjArr<Int32, ColorSpace>(colorSpaces.size, colorSpaces.head) {
                    it => ColorSpace.parse(UInt32(it))
                }
            }
        } finally {
            unsafe { LibC.free(colorSpaces.head) }
        }
    }
}

/**
 * Color Management object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface ColorManagement <: ColorManagementQuery {
    /**
     * Sets a color space for the session.
     *
     * @param { colorSpaceManager.ColorSpace } colorSpace - The type of color space.
     * @throws { BusinessException } 7400101 - Parameter missing or parameter type incorrect.
     * @throws { BusinessException } 7400102 - The colorSpace does not match the format.
     * @throws { BusinessException } 7400103 - Session not config.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setColorSpace(colorSpace: ColorSpace): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraColorManagementSetColorSpace((this as RemoteDataLite).getOrThrow().getID(),
                Int32(colorSpace.getValue()), inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Gets the specific color space type.
     *
     * @returns { colorSpaceManager.ColorSpace } Current color space.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getActiveColorSpace(): ColorSpace {
        var errCode: Int32 = 0
        let ret: Int32 = unsafe {
            FfiCameraColorManagementGetActiveColorSpace((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        successOrThrow(errCode)

        return ColorSpace.parse(UInt32(ret))
    }
}

/**
 * Enum for flash mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum FlashMode {
    /**
     * Close mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FlashModeClose
    |
    /**
     * Open mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FlashModeOpen
    |
    /**
     * Auto mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FlashModeAuto
    |
    /**
     * Always open mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FlashModeAlwaysOpen
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case FlashModeClose => 0
                case FlashModeOpen => 1
                case FlashModeAuto => 2
                case FlashModeAlwaysOpen => 3
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): FlashMode {
        return match (value) {
            case 0 => FlashModeClose
            case 1 => FlashModeOpen
            case 2 => FlashModeAuto
            case 3 => FlashModeAlwaysOpen
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    } 
}

/**
 * Flash Query object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface FlashQuery {
    /**
     * Check if device has flash light.
     *
     * @returns { Bool } The flash light support status.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func hasFlash(): Bool {
        var errCode: Int32 = 0
        let ret: Bool = unsafe {
            FfiCameraFlashQueryHasFlash((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }

        successOrThrow(errCode)
        return ret
    }

    /**
     * Checks whether a specified flash mode is supported.
     *
     * @param { FlashMode } flashMode - Flash mode
     * @returns { Bool } Is the flash mode supported.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func isFlashModeSupported(flashMode: FlashMode): Bool {
        var errCode: Int32 = 0
        let ret: Bool = unsafe {
            FfiCameraFlashQueryFlashModeSupported((this as RemoteDataLite).getOrThrow().getID(), flashMode.value,
                inout errCode)
        }

        successOrThrow(errCode)
        return ret
    }
}

/**
 * Flash object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface Flash <: FlashQuery {
    /**
     * Sets flash mode.
     *
     * @param { FlashMode } flashMode - Target flash mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setFlashMode(flashMode: FlashMode): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraFlashSetFlashMode((this as RemoteDataLite).getOrThrow().getID(), flashMode.value, inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Gets current flash mode.
     *
     * @returns { FlashMode } The current flash mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getFlashMode(): FlashMode {
        var errCode: Int32 = 0
        let flashMode: Int32 = unsafe {
            FfiCameraFlashGetFlashMode((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }

        successOrThrow(errCode)
        return FlashMode.parse(flashMode)
    }
}

/**
 * Enum for focus state.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum FocusState {
    /**
     * Scan state.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusStateScan
    |
    /**
     * Focused state.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusStateFocused
    |
    /**
     * Unfocused state.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusStateUnfocused
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case FocusStateScan => 0
                case FocusStateFocused => 1
                case FocusStateUnfocused => 2
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): FocusState {
        return match (value) {
            case 0 => FocusStateScan
            case 1 => FocusStateFocused
            case 2 => FocusStateUnfocused
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Enum for focus mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum FocusMode {
    /**
     * Manual mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusModeManual
    |
    /**
     * Continuous auto mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusModeContinuousAuto
    |
    /**
     * Auto mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusModeAuto
    |
    /**
     * Locked mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    FocusModeLocked
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case FocusModeManual => 0
                case FocusModeContinuousAuto => 1
                case FocusModeAuto => 2
                case FocusModeLocked => 3
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): FocusMode {
        return match (value) {
            case 0 => FocusModeManual
            case 1 => FocusModeContinuousAuto
            case 2 => FocusModeAuto
            case 3 => FocusModeLocked
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Focus Query object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface FocusQuery {
    /**
     * Checks whether a specified focus mode is supported.
     *
     * @param { FocusMode } afMode - Focus mode.
     * @returns { Bool } Is the focus mode supported.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func isFocusModeSupported(afMode: FocusMode): Bool {
        var errCode: Int32 = 0
        let ret: Bool = unsafe {
            FfiCameraFocusIsFocusModeSupported((this as RemoteDataLite).getOrThrow().getID(), afMode.value,
                inout errCode)
        }
        successOrThrow(errCode)
        return ret
    }
}

/**
 * Focus object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface Focus <: FocusQuery {
    /**
     * Sets focus mode.
     *
     * @param { FocusMode } afMode - Target focus mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setFocusMode(afMode: FocusMode): Unit {
        var errCode: Int32 = 0
        unsafe { FfiCameraFocusSetFocusMode((this as RemoteDataLite).getOrThrow().getID(), afMode.value, inout errCode) }
        successOrThrow(errCode)
    }

    /**
     * Gets current focus mode.
     *
     * @returns { FocusMode } The current focus mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getFocusMode(): FocusMode {
        var errCode: Int32 = 0
        let ret: Int32 = unsafe {
            FfiCameraFocusGetFocusMode((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        successOrThrow(errCode)
        return FocusMode.parse(ret)
    }

    /**
     * Sets focus point.
     *
     * @param { Point } point - Target focus point.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setFocusPoint(point: Point): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraFocusSetFocusPoint((this as RemoteDataLite).getOrThrow().getID(), point.asCPoint(), inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Gets current focus point.
     *
     * @returns { Point } Used to get the current focus. Failure of the interface call will return the
     * corresponding error code, which is of type CameraErrorCode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getFocusPoint(): Point {
        var errCode: Int32 = 0
        let cPoint: CPoint = unsafe {
            FfiCameraFocusGetFocusPoint((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        successOrThrow(errCode)
        return Point(cPoint)
    }

    /**
     * Gets current focal length.
     *
     * @returns { Float64 } The current focal point.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getFocalLength(): Float64 {
        var errCode: Int32 = 0
        let ret: Float64 = unsafe {
            Float64(FfiCameraFocusGetFocalLength((this as RemoteDataLite).getOrThrow().getID(), inout errCode))
        }
        successOrThrow(errCode)
        return ret
    }
}

/**
 * Enum for video stabilization mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum VideoStabilizationMode {
    /**
     * Turn off video stablization.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Off
    |
    /**
     * LOW mode provides basic stabilization effect.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Low
    |
    /**
     * MIDDLE mode means algorithms can achieve better effects than LOW mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Middle
    |
    /**
     * HIGH mode means algorithms can achieve better effects than MIDDLE mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    High
    |
    /**
     * The stabilization algorithm is selected automatically. Selection of the stabilization algorithm is performed
     * automatically.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Auto
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Off => 0
                case Low => 1
                case Middle => 2
                case High => 3
                case Auto => 4
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): VideoStabilizationMode {
        return match (value) {
            case 0 => Off
            case 1 => Low
            case 2 => Middle
            case 3 => High
            case 4 => Auto
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Stabilization Query object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface StabilizationQuery {
    /**
     * Check whether the specified video stabilization mode is supported.
     *
     * @param { VideoStabilizationMode } vsMode - Video Stabilization mode.
     * @returns { Bool } Is video stabilization mode supported.
     * @throws { BusinessException } 7400103 - Session not config, only throw in session usage.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func isVideoStabilizationModeSupported(vsMode: VideoStabilizationMode): Bool {
        var errCode: Int32 = 0
        let ret: Bool = unsafe {
            FfiCameraStabilizationIsVideoStabilizationModeSupported((this as RemoteDataLite).getOrThrow().getID(),
                vsMode.value, inout errCode)
        }

        successOrThrow(errCode)
        return ret
    }
}

/**
 * Stabilization object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface Stabilization <: StabilizationQuery {
    /**
     * Query the video stabilization mode currently in use.
     *
     * @returns { VideoStabilizationMode } The current video stabilization mode.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getActiveVideoStabilizationMode(): VideoStabilizationMode {
        var errCode: Int32 = 0
        let ret: Int32 = unsafe {
            FfiCameraStabilizationGetActiveVideoStabilizationMode((this as RemoteDataLite).getOrThrow().getID(),
                inout errCode)
        }
        successOrThrow(errCode)

        return VideoStabilizationMode.parse(ret)
    }

    /**
     * Set video stabilization mode.
     *
     * @param { VideoStabilizationMode } mode - video stabilization mode to set.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setVideoStabilizationMode(mode: VideoStabilizationMode): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraStabilizationSetVideoStabilizationMode((this as RemoteDataLite).getOrThrow().getID(), mode.value,
                inout errCode)
        }
        successOrThrow(errCode)
    }
}

/**
 * SmoothZoomInfo object
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class SmoothZoomInfo {
    /**
     * The duration of smooth zoom.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public var duration: Int32

    /**
     * SmoothZoomInfo constructor.
     *
     */
    init(duration: Int32) {
        this.duration = duration
    }
}

/**
 * Enum for smooth zoom mode.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum SmoothZoomMode {
    /**
     * Normal zoom mode.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Normal
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Normal => 0
                case _ => throw BusinessException(7400101, "Parameter error.")
            }
        }
    }

    static func parse(value: Int32): SmoothZoomMode {
        return match (value) {
            case 0 => Normal
            case _ => throw BusinessException(7400101, "Parameter error.")
        }
    }
}

/**
 * Zoom query object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface ZoomQuery {
    /**
     * Gets all supported zoom ratio range.
     *
     * @returns { Array<Float64> } The zoom ratio range.
     * @throws { BusinessException } 7400103 - Session not config, only throw in session usage.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getZoomRatioRange(): Array<Float64> {
        var errCode: Int32 = 0
        let zoomRange: CArrFloat32 = unsafe {
            FfiCameraZoomGetZoomRatioRange((this as RemoteDataLite).getOrThrow().getID(), inout errCode)
        }
        let res = zoomRange.toArrayF64()
        zoomRange.free()
        successOrThrow(errCode)
        return res
    }
}

/**
 * Zoom object.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public interface Zoom <: ZoomQuery {
    /**
     * Sets zoom ratio.
     *
     * @param { Float64 } zoomRatio - Zoom ratio.
     * @throws { BusinessException } 7400103 - Session not config.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setZoomRatio(zoomRatio: Float64): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraZoomSetZoomRatio((this as RemoteDataLite).getOrThrow().getID(), Float32(zoomRatio), inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Gets zoom ratio.
     *
     * @returns { Float64 } The zoom ratio value.
     * @throws { BusinessException } 7400103 - Session not config.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func getZoomRatio(): Float64 {
        var errCode: Int32 = 0
        let ret: Float64 = unsafe {
            Float64(FfiCameraZoomGetZoomRatio((this as RemoteDataLite).getOrThrow().getID(), inout errCode))
        }
        successOrThrow(errCode)
        return ret
    }

    /**
     * Sets target zoom ratio by smooth method.
     *
     * @param { Float64 } targetRatio - Target zoom ratio.
     * @param { SmoothZoomMode } mode - Smooth zoom mode.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setSmoothZoom(targetRatio: Float64, mode: SmoothZoomMode): Unit {
        var errCode: Int32 = 0
        unsafe {
            FfiCameraZoomSetSmoothZoom((this as RemoteDataLite).getOrThrow().getID(), Float32(targetRatio), mode.value,
                inout errCode)
        }
        successOrThrow(errCode)
    }

    /**
     * Sets target zoom ratio by smooth method.
     *
     * @param { Float64 } targetRatio - Target zoom ratio.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    func setSmoothZoom(targetRatio: Float64): Unit {
        setSmoothZoom(targetRatio, SmoothZoomMode.Normal)
    }
}
