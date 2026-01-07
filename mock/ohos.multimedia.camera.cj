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

package ohos.multimedia.camera

import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.business_exception.*
import ohos.callback_invoke.*
import ohos.graphics.color_space_manager.ColorSpace
import ohos.labels.*
import ohos.labels.APILevel
import ohos.ffi.*

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
public func getCameraManager(context: UIAbilityContext): CameraManager {
    return CameraManager()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class Point {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var x: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var y: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public init(x: Float64, y: Float64) {
        super()
        this.x = 0.0
        this.y = 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum ExposureMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    ExposureModeLocked
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    ExposureModeAuto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    ExposureModeContinuousAuto
    | ...
}

extend ExposureMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend ExposureMode <: Equatable<ExposureMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: ExposureMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: ExposureMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface AutoExposureQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func isExposureModeSupported(aeMode: ExposureMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getExposureBiasRange(): Array<Float64> {
        return Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface AutoExposure <: AutoExposureQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getExposureMode(): ExposureMode {
        return ExposureMode.ExposureModeLocked
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setExposureMode(aeMode: ExposureMode): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getMeteringPoint(): Point {
        return Point(
            0.0,
            0.0
        )
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setMeteringPoint(point: Point): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setExposureBias(exposureBias: Float64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getExposureValue(): Float64 {
        return 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface ColorManagementQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getSupportedColorSpaces(): Array<ColorSpace> {
        return Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface ColorManagement <: ColorManagementQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setColorSpace(colorSpace: ColorSpace): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getActiveColorSpace(): ColorSpace {
        return ColorSpace.Unknown
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum FlashMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FlashModeClose
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FlashModeOpen
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FlashModeAuto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FlashModeAlwaysOpen
    | ...
}

extend FlashMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend FlashMode <: Equatable<FlashMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: FlashMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: FlashMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface FlashQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func hasFlash(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func isFlashModeSupported(flashMode: FlashMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface Flash <: FlashQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setFlashMode(flashMode: FlashMode): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getFlashMode(): FlashMode {
        return FlashMode.FlashModeClose
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum FocusState {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusStateScan
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusStateFocused
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusStateUnfocused
    | ...
}

extend FocusState <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend FocusState <: Equatable<FocusState> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: FocusState): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: FocusState): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum FocusMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusModeManual
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusModeContinuousAuto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusModeAuto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusModeLocked
    | ...
}

extend FocusMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend FocusMode <: Equatable<FocusMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: FocusMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: FocusMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface FocusQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func isFocusModeSupported(afMode: FocusMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface Focus <: FocusQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setFocusMode(afMode: FocusMode): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getFocusMode(): FocusMode {
        return FocusMode.FocusModeManual
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setFocusPoint(point: Point): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getFocusPoint(): Point {
        return Point(
            0.0,
            0.0
        )
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getFocalLength(): Float64 {
        return 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum VideoStabilizationMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Off
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Low
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Middle
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    High
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Auto
    | ...
}

extend VideoStabilizationMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend VideoStabilizationMode <: Equatable<VideoStabilizationMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: VideoStabilizationMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: VideoStabilizationMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface StabilizationQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func isVideoStabilizationModeSupported(vsMode: VideoStabilizationMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface Stabilization <: StabilizationQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getActiveVideoStabilizationMode(): VideoStabilizationMode {
        return VideoStabilizationMode.Off
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setVideoStabilizationMode(mode: VideoStabilizationMode): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class SmoothZoomInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var duration: Int32
    
    public init() {
        super()
        this.duration = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum SmoothZoomMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Normal | ...
}

extend SmoothZoomMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend SmoothZoomMode <: Equatable<SmoothZoomMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: SmoothZoomMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: SmoothZoomMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface ZoomQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getZoomRatioRange(): Array<Float64> {
        return Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface Zoom <: ZoomQuery {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func setZoomRatio(zoomRatio: Float64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func getZoomRatio(): Float64 {
        return 0.0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    func setSmoothZoom(targetRatio: Float64, mode: SmoothZoomMode): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    func setSmoothZoom(targetRatio: Float64): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class Rect {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var topLeftX: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var topLeftY: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var width: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var height: Float64
    
    public init() {
        super()
        this.topLeftX = 0.0
        this.topLeftY = 0.0
        this.width = 0.0
        this.height = 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum TorchMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Off
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    On
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Auto
    | ...
}

extend TorchMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend TorchMode <: Equatable<TorchMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: TorchMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: TorchMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum ImageRotation {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Rotation0
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Rotation90
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Rotation180
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Rotation270
    | ...
}

extend ImageRotation <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend ImageRotation <: Equatable<ImageRotation> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: ImageRotation): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: ImageRotation): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum CameraStatus {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraStatusAppear
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraStatusDisappear
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraStatusAvailable
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraStatusUnavailable
    | ...
}

extend CameraStatus <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend CameraStatus <: Equatable<CameraStatus> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: CameraStatus): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: CameraStatus): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class TorchStatusInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let isTorchAvailable: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let isTorchActive: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let torchLevel: Float64
    
    public init() {
        super()
        this.isTorchAvailable = true
        this.isTorchActive = true
        this.torchLevel = 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class FrameRateRange {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let min: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let max: Int32
    
    public init() {
        super()
        this.min = 0
        this.max = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class Size {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var width: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var height: UInt32
    
    public init() {
        super()
        this.width = 0
        this.height = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public open class Profile {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let format: CameraFormat

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let size: Size
    
    public init() {
        super()
        this.format = CameraFormat.CameraFormatRgba8888
        this.size = Size()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class VideoProfile <: Profile {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let frameRateRange: FrameRateRange
    
    public init() {
        super()
        this.frameRateRange = FrameRateRange()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum MetadataObjectType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FaceDetection | ...
}

extend MetadataObjectType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend MetadataObjectType <: Equatable<MetadataObjectType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: MetadataObjectType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: MetadataObjectType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CameraOutputCapability {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let previewProfiles: Array<Profile>

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let photoProfiles: Array<Profile>

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let videoProfiles: Array<VideoProfile>

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let supportedMetadataObjectTypes: Array<MetadataObjectType>
    
    public init() {
        super()
        this.previewProfiles = Array()
        this.photoProfiles = Array()
        this.videoProfiles = Array()
        this.supportedMetadataObjectTypes = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum FoldStatus {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    NonFoldable
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Expanded
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Folded
    | ...
}

extend FoldStatus <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend FoldStatus <: Equatable<FoldStatus> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: FoldStatus): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: FoldStatus): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class FoldStatusInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let supportedCameras: Array<CameraDevice>

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let foldStatus: FoldStatus
    
    public init() {
        super()
        this.supportedCameras = Array()
        this.foldStatus = FoldStatus.NonFoldable
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum ConnectionType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraConnectionBuiltIn
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraConnectionUsbPlugin
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraConnectionRemote
    | ...
}

extend ConnectionType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend ConnectionType <: Equatable<ConnectionType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: ConnectionType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: ConnectionType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum CameraFormat {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatRgba8888
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatYuv420Sp
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatJpeg
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatYcbcrP010
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatYcrcbP010
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraFormatHeic
    | ...
}

extend CameraFormat <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend CameraFormat <: Equatable<CameraFormat> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: CameraFormat): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: CameraFormat): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CameraDevice {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let cameraId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let cameraPosition: CameraPosition

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let cameraType: CameraType

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let connectionType: ConnectionType

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public let cameraOrientation: UInt32
    
    public init() {
        super()
        this.cameraId = String()
        this.cameraPosition = CameraPosition.CameraPositionUnspecified
        this.cameraType = CameraType.CameraTypeDefault
        this.connectionType = ConnectionType.CameraConnectionBuiltIn
        this.cameraOrientation = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CameraStatusInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var camera: CameraDevice

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var status: CameraStatus
    
    public init() {
        super()
        this.camera = CameraDevice()
        this.status = CameraStatus.CameraStatusAppear
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum CameraEvents {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraError
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraStatus
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FoldStatusChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    TorchStatusChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FrameStart
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FrameEnd
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CaptureStartWithInfo
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FrameShutter
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CaptureEnd
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FrameShutterEnd
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CaptureReady
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    EstimatedCaptureDuration
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    MetadataObjectsAvailable
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    FocusStateChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    SmoothZoomInfoAvailable
    | ...
}

extend CameraEvents <: Equatable<CameraEvents> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: CameraEvents): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: CameraEvents): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum CameraPosition {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraPositionUnspecified
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraPositionBack
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraPositionFront
    | ...
}

extend CameraPosition <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend CameraPosition <: Equatable<CameraPosition> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: CameraPosition): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: CameraPosition): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum CameraType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraTypeDefault
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraTypeWideAngle
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraTypeUltraWide
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraTypeTelephoto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    CameraTypeTrueDepth
    | ...
}

extend CameraType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend CameraType <: Equatable<CameraType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: CameraType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: CameraType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum SceneMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    NormalPhoto
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    NormalVideo
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    SecurePhoto
    | ...
}

extend SceneMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend SceneMode <: Equatable<SceneMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: SceneMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: SceneMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum QualityLevel {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    QualityLevelHigh
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    QualityLevelMedium
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    QualityLevelLow
    | ...
}

extend QualityLevel <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend QualityLevel <: Equatable<QualityLevel> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: QualityLevel): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: QualityLevel): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class Location {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var latitude: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var longitude: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var altitude: Float64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public init(latitude: Float64, longitude: Float64, altitude: Float64) {
        super()
        this.latitude = 0.0
        this.longitude = 0.0
        this.altitude = 0.0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class PhotoCaptureSetting {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var quality: QualityLevel

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var rotation: ImageRotation

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var location: ?Location

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var mirror: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public init(
        quality!: QualityLevel = QualityLevel.QualityLevelLow,
        rotation!: ImageRotation = ImageRotation.Rotation0,
        location!: ?Location = None,
        mirror!: Bool = false
    ) {
        super()
        this.quality = QualityLevel.QualityLevelHigh
        this.rotation = ImageRotation.Rotation0
        this.location = None
        this.mirror = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum VideoCodecType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Avc
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Hevc
    | ...
}

extend VideoCodecType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend VideoCodecType <: Equatable<VideoCodecType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: VideoCodecType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: VideoCodecType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CaptureStartInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var captureId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var time: Int64
    
    public init() {
        super()
        this.captureId = 0
        this.time = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class FrameShutterInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var captureId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var timestamp: Int64
    
    public init() {
        super()
        this.captureId = 0
        this.timestamp = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CaptureEndInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var captureId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var frameCount: Int32
    
    public init() {
        super()
        this.captureId = 0
        this.frameCount = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class FrameShutterEndInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public var captureId: Int32
    
    public init() {
        super()
        this.captureId = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum PreconfigType {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Preconfig720p
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Preconfig1080p
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    Preconfig4k
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    PreconfigHighQuality
    | ...
}

extend PreconfigType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend PreconfigType <: Equatable<PreconfigType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: PreconfigType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: PreconfigType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public enum PreconfigRatio {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    PreconfigRatio_1_1
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    PreconfigRatio_4_3
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    PreconfigRatio_16_9
    | ...
}

extend PreconfigRatio <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func toString(): String {
        return String()
    }
}

extend PreconfigRatio <: Equatable<PreconfigRatio> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func ==(other: PreconfigRatio): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public operator func !=(other: PreconfigRatio): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CameraInput {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func open(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func open(isSecureEnabled: Bool): UInt64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func close(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, camera: CameraDevice, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, camera: CameraDevice, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, camera: CameraDevice): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class CameraManager {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func getSupportedCameras(): Array<CameraDevice> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func getSupportedOutputCapability(camera: CameraDevice, mode: SceneMode): CameraOutputCapability {
        return CameraOutputCapability()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func getSupportedSceneModes(camera: CameraDevice): Array<SceneMode> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func isCameraMuted(): Bool {
        return true
    }

    @!APILevel[since: "22", permission: "ohos.permission.CAMERA", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createCameraInput(camera: CameraDevice): CameraInput {
        return CameraInput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createPreviewOutput(profile: Profile, surfaceId: String): PreviewOutput {
        return PreviewOutput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createPreviewOutput(surfaceId: String): PreviewOutput {
        return PreviewOutput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createPhotoOutput(profile!: ?Profile = None): PhotoOutput {
        return PhotoOutput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createVideoOutput(profile: VideoProfile, surfaceId: String): VideoOutput {
        return VideoOutput()
    }

    @!APILevel[since: "22", permission: "ohos.permission.CAMERA", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createCameraInput(position: CameraPosition, cameraType: CameraType): CameraInput {
        return CameraInput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createVideoOutput(surfaceId: String): VideoOutput {
        return VideoOutput()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func createSession(mode: SceneMode): Session {
        return VideoSession()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<CameraStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<FoldStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<TorchStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<CameraStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<FoldStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<TorchStatusInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func isTorchSupported(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func isTorchModeSupported(mode: TorchMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func getTorchMode(): TorchMode {
        return TorchMode.Off
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func setTorchMode(mode: TorchMode): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface CameraOutput {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    func release(): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public interface Session {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func beginConfig(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    func commitConfig(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    func canAddInput(cameraInput: CameraInput): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func addInput(cameraInput: CameraInput): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func removeInput(cameraInput: CameraInput): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    func canAddOutput(cameraOutput: CameraOutput): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func addOutput(cameraOutput: CameraOutput): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    func removeOutput(cameraOutput: CameraOutput): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    func start(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    func stop(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    func release(): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class PhotoSession <: Session & Flash & AutoExposure & Focus & Zoom & ColorManagement {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func canPreconfig(preconfigType: PreconfigType, preconfigRatio!: PreconfigRatio = PreconfigRatio_4_3): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func preconfig(
        preconfigType: PreconfigType,
        preconfigRatio!: PreconfigRatio = PreconfigRatio.PreconfigRatio_4_3
    ): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func on(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func off(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func on(eventType: CameraEvents, callback: Callback1Argument<FocusState>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func off(eventType: CameraEvents, callback: Callback1Argument<FocusState>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func on(eventType: CameraEvents, callback: Callback1Argument<SmoothZoomInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func off(eventType: CameraEvents, callback: Callback1Argument<SmoothZoomInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class VideoSession <: Session & Flash & AutoExposure & Focus & Zoom & Stabilization & ColorManagement {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func canPreconfig(preconfigType: PreconfigType, preconfigRatio!: PreconfigRatio = PreconfigRatio_16_9): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func preconfig(
        preconfigType: PreconfigType,
        preconfigRatio!: PreconfigRatio = PreconfigRatio.PreconfigRatio_16_9
    ): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<FocusState>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<FocusState>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<SmoothZoomInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<SmoothZoomInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class PhotoOutput <: CameraOutput {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func capture(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func capture(setting: PhotoCaptureSetting): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
    public func getSupportedMovingPhotoVideoCodecTypes(): Array<VideoCodecType> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func setMovingPhotoVideoCodecType(codecType: VideoCodecType): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<CaptureStartInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<FrameShutterInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<CaptureEndInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<FrameShutterEndInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback1Argument<Float64>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<CaptureStartInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<FrameShutterInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<CaptureEndInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<FrameShutterEndInfo>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback1Argument<Float64>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func isMirrorSupported(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func enableMirror(enabled: Bool): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getActiveProfile(): Profile {
        return Profile()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func isMovingPhotoSupported(): Bool {
        return true
    }

    @!APILevel[since: "22", permission: "ohos.permission.MICROPHONE", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func enableMovingPhoto(enabled: Bool): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getPhotoRotation(deviceDegree: Int32): ImageRotation {
        return ImageRotation.Rotation0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class PreviewOutput <: CameraOutput {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getSupportedFrameRates(): Array<FrameRateRange> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func setFrameRate(minFps: Int32, maxFps: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getActiveFrameRate(): FrameRateRange {
        return FrameRateRange()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getActiveProfile(): Profile {
        return Profile()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getPreviewRotation(displayRotation: Int32): ImageRotation {
        return ImageRotation.Rotation0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func setPreviewRotation(previewRotation: ImageRotation, isDisplayLocked!: Bool = false): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core"]
public class VideoOutput <: CameraOutput {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func start(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func stop(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getSupportedFrameRates(): Array<FrameRateRange> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func setFrameRate(minFps: Int32, maxFps: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getActiveFrameRate(): FrameRateRange {
        return FrameRateRange()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getVideoRotation(deviceDegree: Int32): ImageRotation {
        return ImageRotation.Rotation0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func on(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func off(eventType: CameraEvents, callback: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func off(eventType: CameraEvents): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true]
    public func getActiveProfile(): VideoProfile {
        return VideoProfile()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Camera.Core", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}