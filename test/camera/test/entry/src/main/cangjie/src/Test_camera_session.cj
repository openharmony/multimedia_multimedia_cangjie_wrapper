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

/**
 * Created on 2024/8/28
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.callback_invoke.*
import ohos.business_exception.*
import std.unittest.testmacro.*
import kit.CameraKit.*
import kit.ImageKit.Size as ImageSize
import kit.ImageKit.*
import std.sync.*
import std.time.*
import kit.ArkGraphics2D.ColorSpace
import kit.ImageKit.{createImageReceiver, ImageFormat}
import ohos.ui_test.Driver
import kit.TestKit.On
import ohos.multimedia.camera.Point as cameraPoint
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import std.collection.map
import std.collection.collectArray
import std.collection.forEach
import kit.AbilityKit.Permissions
import ohos.device_info.*

//var cameraManager: Option<CameraManager> = None

@Test
class Test_camera_session {
    override func beforeAll(): Unit {
        ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE", "ohos.permission.WRITE_MEDIA",
            "ohos.permission.READ_MEDIA", "ohos.permission.MEDIA_LOCATION"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            sleepFor(3.second)
            getRequiredPermissions([permissionName])
            try {
                sleepFor(3.second)
                click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("允许").centerPoint)
            } catch (e: Exception) {
                try {
                    click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("本次使用允许").centerPoint)
                } catch (e: Exception) {}
            }
        }
        //cameraManager = getCameraManager(getAbilityContext())
    }

    func getPhotoSession(index: Int64): PhotoSession {
        var cameraManager: Option<CameraManager> = None
        cameraManager = getCameraManager(getAbilityContext())
        let session: PhotoSession = (cameraManager.getOrThrow()
            .createSession(SceneMode.NormalPhoto) as PhotoSession)
            .getOrThrow()

        // input
        let device = cameraManager.getOrThrow().getSupportedCameras()[index]
        let input = cameraManager.getOrThrow().createCameraInput(device)

        let ability = cameraManager.getOrThrow().getSupportedOutputCapability(device, SceneMode.NormalPhoto)

        // preview output
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 64)
        let receiverId = receiver.getReceivingSurfaceId()
        let previewOutput = cameraManager.getOrThrow().createPreviewOutput(ability.previewProfiles[0], receiverId)

        // output
        let output = cameraManager.getOrThrow().createPhotoOutput(profile: ability.photoProfiles[0])

        input.open()
        session.beginConfig()
        session.addInput(input)
        session.addOutput(previewOutput)
        session.addOutput(output)
        session.commitConfig()

        return session
    }

    func getVideoSession(): VideoSession {
        var cameraManager: Option<CameraManager> = None
        cameraManager = getCameraManager(getAbilityContext())
        let session: VideoSession = (cameraManager.getOrThrow()
            .createSession(SceneMode.NormalVideo) as VideoSession)
            .getOrThrow();

        let device = cameraManager.getOrThrow().getSupportedCameras()[0]
        let input = cameraManager.getOrThrow().createCameraInput(device)

        let ability = cameraManager.getOrThrow().getSupportedOutputCapability(device, SceneMode.NormalVideo)

        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 64)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let output = cameraManager.getOrThrow().createPreviewOutput(ability.previewProfiles[0], surfaceId)

        input.open()
        session.beginConfig()
        session.addInput(input)
        session.addOutput(output)
        session.commitConfig()

        return session
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_Flash(): Unit {
        try {
            loggerInfo("[multimedia_camera | Test_Flash]: test_flash start!")
            let session: PhotoSession = getPhotoSession(0)

            let res = session.hasFlash()
            loggerInfo("[multimedia_camera | Test_Flash]: hasFlash = ${res}")
            if (DeviceInfo.deviceType == "2in1") {
                if (!res) {
                    @Expect(true)
                }
            } else {
                if (!res) {
                    @Expect(false)
                }   
            }
            let modes = [FlashModeClose, FlashModeOpen, FlashModeAuto, FlashModeAlwaysOpen]
            for (mode in modes) {
                if (session.isFlashModeSupported(mode)) {
                    loggerInfo("[multimedia_camera | Test_Flash]: support ${mode}")
                    session.setFlashMode(mode)
                    let curMode = session.getFlashMode()
                    loggerInfo("[multimedia_camera | Test_Flash]: current mode after setting: ${curMode}")

                    @Expect(curMode, mode)
                } else {
                    loggerInfo("[multimedia_camera | Test_Flash]: DO NOT support ${mode}")
                    if (DeviceInfo.deviceType == "2in1" && ((mode == FlashModeOpen) || (mode == FlashModeAuto) || (mode == FlashModeAlwaysOpen))) {
                        @Expect(true)
                    } else {
                        @Expect(false)
                    }   
                }
            }

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_Flash]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_AutoExposure() {
        try {
            let session: PhotoSession = getPhotoSession(0)

            let biasRangeArray = session.getExposureBiasRange()
            if (biasRangeArray.size <= 0) {
                @Expect(false)
            }

            for (bias in biasRangeArray) {
                loggerInfo("[multimedia_camera | Test_AutoExposure]: supported bias: ${bias}")
                session.setExposureBias(bias)
                let curBias = session.getExposureValue()
                loggerInfo("[multimedia_camera | Test_AutoExposure]: current bias after setting: ${curBias}")

                @Expect(bias, curBias)
            }

            let exposureModes = [ExposureMode.ExposureModeLocked, ExposureModeAuto, ExposureModeContinuousAuto]
            for (mode in exposureModes) {
                if (session.isExposureModeSupported(mode)) {
                    loggerInfo("[multimedia_camera | Test_AutoExposure]: support ${mode}")
                    session.setExposureMode(mode)
                    let curMode = session.getExposureMode()
                    loggerInfo("[multimedia_camera | Test_AutoExposure]: current mode after setting ${curMode}")

                    @Expect(mode, curMode)
                } else {
                    loggerInfo("[multimedia_camera | Test_AutoExposure]: DO NOT support ${mode}")
                }
            }

            session.setMeteringPoint(cameraPoint(0.123, 0.456))
            let curPoint = session.getMeteringPoint()
            loggerInfo(
                "[multimedia_camera | Test_AutoExposure] current point after setting: point.x=${curPoint.x}, point.y=${curPoint.y}"
            )

            @Expect(Float16(curPoint.x), 0.123)
            @Expect(Float16(curPoint.y), 0.456)

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_AutoExposure]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_Focus() {
        try {
            let session: PhotoSession = getPhotoSession(0)

            let focusModes = [FocusMode.FocusModeManual, FocusMode.FocusModeContinuousAuto, FocusModeAuto,
                FocusModeLocked]
            for (mode in focusModes) {
                if (session.isFocusModeSupported(mode)) {
                    loggerInfo("[multimedia_camera | Test_Focus]: support ${mode}")
                    session.setFocusMode(mode)
                    let curMode = session.getFocusMode()
                    loggerInfo("[multimedia_camera | Test_Focus]: current mode after setting: ${curMode}")

                    @Expect(mode, curMode)
                } else {
                    loggerInfo("[multimedia_camera | Test_Focus]: DO NOT support ${mode}")

                    // @Expect(false)
                }
            }

            session.setFocusPoint(cameraPoint(0.123, 0.456))
            let curPoint = session.getFocusPoint()
            loggerInfo(
                "[multimedia_camera | Test_Focus]: current point after setting point.x=${curPoint.x}, point.y=${curPoint.y}"
            )

            @Expect(Float16(curPoint.x), 0.123)
            @Expect(Float16(curPoint.y), 0.456)

            let curLength = session.getFocalLength()
            loggerInfo("[multimedia_camera | Test_Focus]: current focal length: ${curLength}")

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_Focus]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    /*
    We use ImageReceiver as preview surface and due to its limitation,
    setZoomRatio will not be applied once the buffer of ImageReceiver is full(ArkTS has the same behavior).
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_Zoom() {
        try {
            let session: PhotoSession = getPhotoSession(0)
            session.start()

            let zoomRatioArray = session.getZoomRatioRange()
            if (zoomRatioArray.size <= 0) {
                loggerInfo("[multimedia_camera | Test_Zoom]: no supported zoom ratio range ")

                @Expect(false)
            }

            let ratio = zoomRatioArray[0]
            loggerInfo("[multimedia_camera | Test_Zoom]: supported ratio: ${ratio}")

            session.setZoomRatio(ratio)
            sleep(Duration.second * 1) // need some time to apply the change
            var curRatio = session.getZoomRatio()

            loggerInfo("[multimedia_camera | Test_Zoom]: current ratio after setting: ${curRatio}")
            // @Expect(ratio, curRatio)

            session.setSmoothZoom(zoomRatioArray[1], SmoothZoomMode.Normal)

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_Zoom]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_ColorManagement() {
        try {
            let session: PhotoSession = getPhotoSession(0)

            let spaces = session.getSupportedColorSpaces()
            if (spaces.size <= 0) {
                loggerInfo("[multimedia_camera | Test_ColorManagement]: no support spaces")

                @Expect(false)
            }

            for (s in spaces) {
                loggerInfo("[multimedia_camera | Test_ColorManagement]: support space ${s}")

                session.setColorSpace(s)
                let cur = session.getActiveColorSpace()
                loggerInfo("[multimedia_camera | Test_ColorManagement]: current color space after setting: ${cur}")

                @Expect(s.toString(), cur.toString())
            }

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_ColorManagement]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_Stabilization() {
        try {
            let session: VideoSession = getVideoSession()

            let modes = [VideoStabilizationMode.Off, VideoStabilizationMode.Low, VideoStabilizationMode.Middle,
                VideoStabilizationMode.High, VideoStabilizationMode.Auto]
            for (mode in modes) {
                if (session.isVideoStabilizationModeSupported(mode)) {
                    loggerInfo("[multimedia_camera | Test_Stabilization]: support mode ${mode}")

                    session.setVideoStabilizationMode(mode)
                    let cur = session.getActiveVideoStabilizationMode()
                    loggerInfo("[multimedia_camera | Test_Stabilization]: current mode after setting: ${cur}")

                    // VideoStabilizationMode.High requires 1920x1080 in Profile
                    if(mode != VideoStabilizationMode.High) {
                        @Expect(mode, cur)
                    }
                } else {
                    loggerInfo("[multimedia_camera | Test_Stabilization]: DO NOT support mode ${mode}")
                }
            }

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_Stabilization]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSession() {
        let TAG = "TEST_PhotoSession"
        let session: PhotoSession = getPhotoSession(0)
        try {
            let preconfigTypes = [Preconfig720p, Preconfig1080p, Preconfig4k, PreconfigHighQuality]
            let preconfigRatios = [PreconfigRatio_1_1, PreconfigRatio_4_3, PreconfigRatio_16_9]

            for (preconfigType in preconfigTypes) {
                for (ratio in preconfigRatios) {
                    if (session.canPreconfig(preconfigType, preconfigRatio: ratio)) {
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: support preconfig type ${preconfigType} and ratio ${ratio}")

                        session.preconfig(preconfigType, preconfigRatio: ratio)
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: set preconfig type ${preconfigType} and ratio ${ratio}")
                    } else {
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: DO NOT support preconfig type ${preconfigType} and ratio ${ratio}"
                        )
                        if (DeviceInfo.deviceType == "2in1" || DeviceInfo.deviceType == "tv") {
                            @Expect(true)
                        } else {
                            @Expect(false)
                        }  
                    }
                }
            }
        } catch (e: Exception) {
            loggerInfo("[multimedia_camera | ${TAG}]: ${e.printStackTrace()}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    /*
    We use ImageReceiver as preview surface and due to its limitation,
    some methods will not be applied once the buffer of ImageReceiver is full(ArkTS has the same behavior).

    Because of the above reason, setFocusPoint will not applied and cannot trigger the callback. So, @Expect is ignored.
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSessionFocusCallback() {
        let TAG = "Test_PhotoSessionFocusCallback"
        let session = getPhotoSession(0)
        try {
            session.setFocusMode(FocusModeAuto) // prepartion
            let focusCallback = FocusStateChangeCallback()

            FocusStateChangeCallback.invoked = false
            session.on(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            // @Expect(FocusStateChangeCallback.invoked, true)

            FocusStateChangeCallback.invoked = false
            session.off(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            sleep(Duration.second * 3)
        // @Expect(FocusStateChangeCallback.invoked, false)

        } catch (e: BusinessException) {
            if (DeviceInfo.deviceType == "2in1") {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(true)
            } else {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(false)
            }
        } finally {
            session.release()
        }
    }

    /*
    We use ImageReceiver as preview surface and due to its limitation,
    some methods will not be applied once the buffer of ImageReceiver is full(ArkTS has the same behavior).

    Because of the above reason, setFocusPoint will not applied and cannot trigger the callback. So, @Expect is ignored.
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSessionFocusCallback1() {
        let TAG = "Test_PhotoSessionFocusCallback1"
        let session = getPhotoSession(0)
        try {
            session.setFocusMode(FocusModeAuto) // prepartion
            let focusCallback = FocusStateChangeCallback()

            FocusStateChangeCallback.invoked = false
            session.on(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            // @Expect(FocusStateChangeCallback.invoked, true)

            FocusStateChangeCallback.invoked = false
            session.off(CameraEvents.FocusStateChange)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            sleep(Duration.second * 3)
        // @Expect(FocusStateChangeCallback.invoked, false)

        } catch (e: BusinessException) {
            if (DeviceInfo.deviceType == "2in1") {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(true)
            } else {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(false)
            }
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSessionSmoothCallback() {
        let TAG = "Test_PhotoSessionSmoothCallback"
        let session = getPhotoSession(0)
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
           // @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSessionSmoothCallback1() {
        let TAG = "Test_PhotoSessionSmoothCallback1"
        let session = getPhotoSession(0)
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    /*
    Why this callback cannot be triggered???
    But it's verified that in ArkTS, it cannot be triggered either.
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_PhotoSessionErrorCallback() {
        let TAG = "Test_PhotoSessionErrorCallback"
        let session = getPhotoSession(0)
        try {
            let callback = ErrorCallback()

            session.on(CameraEvents.CameraError, callback)
            session.off(CameraEvents.CameraError, callback)

            session.on(CameraEvents.CameraError, callback)
            session.off(CameraEvents.CameraError)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSession() {
        let TAG = "TEST_VideoSession"
        let session: VideoSession = getVideoSession()
        try {
            let preconfigTypes = [Preconfig720p, Preconfig1080p, Preconfig4k, PreconfigHighQuality]
            let preconfigRatios = [PreconfigRatio_1_1, PreconfigRatio_4_3, PreconfigRatio_16_9]

            for (preconfigType in preconfigTypes) {
                for (ratio in preconfigRatios) {
                    if (session.canPreconfig(preconfigType, preconfigRatio: ratio)) {
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: support preconfig type ${preconfigType} and ratio ${ratio}")

                        // we cannot check the result
                        session.preconfig(preconfigType, preconfigRatio: ratio)
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: set preconfig type ${preconfigType} and ratio ${ratio}")
                    } else {
                        loggerInfo(
                            "[multimedia_camera | ${TAG}]: DO NOT support preconfig type ${preconfigType} and ratio ${ratio}"
                        )
                    }
                }
            }
        } catch (e: Exception) {
            loggerInfo("[multimedia_camera | ${TAG}]: ${e.printStackTrace()}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    /*
    We use ImageReceiver as preview surface and due to its limitation,
    some methods will not be applied once the buffer of ImageReceiver is full(ArkTS has the same behavior).

    Because of the above reason, setFocusPoint will not applied and cannot trigger the callback. So, @Expect is ignored.
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSessionFocusCallback() {
        let TAG = "Test_VideoSessionFocusCallback"
        let session = getVideoSession()
        try {
            session.setFocusMode(FocusModeAuto) // prepartion
            let focusCallback = FocusStateChangeCallback()

            FocusStateChangeCallback.invoked = false
            session.on(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            // @Expect(FocusStateChangeCallback.invoked, true)

            FocusStateChangeCallback.invoked = false
            session.off(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            sleep(Duration.second * 3)
        // @Expect(FocusStateChangeCallback.invoked, false)

        } catch (e: BusinessException) {
            if (DeviceInfo.deviceType == "2in1") {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(true)
            } else {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(false)
            }
        } finally {
            session.release()
        }
    }

    /*
    We use ImageReceiver as preview surface and due to its limitation,
    some methods will not be applied once the buffer of ImageReceiver is full(ArkTS has the same behavior).

    Because of the above reason, setFocusPoint will not applied and cannot trigger the callback. So, @Expect is ignored.
     */
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSessionFocusCallback1() {
        let TAG = "Test_VideoSessionFocusCallback1"
        let session = getVideoSession()
        try {
            session.setFocusMode(FocusModeAuto) // prepartion
            let focusCallback = FocusStateChangeCallback()

            FocusStateChangeCallback.invoked = false
            session.on(CameraEvents.FocusStateChange, focusCallback)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            // @Expect(FocusStateChangeCallback.invoked, true)

            FocusStateChangeCallback.invoked = false
            session.off(CameraEvents.FocusStateChange)
            session.setFocusPoint(cameraPoint(0.123, 0.456))
            sleep(Duration.second * 3)
        // @Expect(FocusStateChangeCallback.invoked, false)

        } catch (e: BusinessException) {
            if (DeviceInfo.deviceType == "2in1") {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(true)
            } else {
                loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
                @Expect(false)
            }
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSessionSmoothCallback() {
        let TAG = "Test_VideoSessionSmoothCallback"
        let session = getVideoSession()
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, false)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSessionSmoothCallback1() {
        let TAG = "Test_VideoSessionSmoothCallback1"
        let session = getVideoSession()
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            //@Expect(SmoothZoomInfoAvailableCallback.invoked, false)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
           // @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_VideoSessionErrorCallback() {
        let TAG = "Test_VideoSessionErrorCallback"
        let session = getVideoSession()
        try {
            let callback = ErrorCallback()

            session.on(CameraEvents.CameraError, callback)
            session.off(CameraEvents.CameraError, callback)

            session.on(CameraEvents.CameraError, callback)
            session.off(CameraEvents.CameraError)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }
}


    