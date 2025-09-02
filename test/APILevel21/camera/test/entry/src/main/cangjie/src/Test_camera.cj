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

var cameraManager: Option<CameraManager> = None

@Test
class Test_camera {
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
            } catch (e: Exception) {}
        }
        cameraManager = getCameraManager(getAbilityContext())
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_GetSupportedCameras() {
        let devices = getCameraManager().getSupportedCameras()
        @Expect(devices.size, 2)
        @Expect(devices[0].cameraId, "device/0")
        @Expect(devices[0].cameraPosition.toString(), "CameraPosition.CameraPositionBack")
        @Expect(devices[0].cameraType.toString(), "CameraType.CameraTypeDefault")
        @Expect(devices[0].connectionType.toString(), "ConnectionType.CameraConnectionBuiltIn")
        @Expect(devices[0].cameraOrientation, 90)
        @Expect(devices[1].cameraId, "device/1")
        @Expect(devices[1].cameraPosition.toString(), "CameraPosition.CameraPositionFront")
        @Expect(devices[1].cameraType.toString(), "CameraType.CameraTypeDefault")
        @Expect(devices[1].connectionType.toString(), "ConnectionType.CameraConnectionBuiltIn")
        @Expect(devices[1].cameraOrientation, 270)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_GetSupportedSceneModes() {
        let device = getCameraManager().getSupportedCameras()[0]
        let modes = getCameraManager().getSupportedSceneModes(device)
        @Expect(modes.size, 3)
        @Expect(modes[0].toString(), "SceneMode.NormalPhoto")
        @Expect(modes[1].toString(), "SceneMode.NormalVideo")
        @Expect(modes[2].toString(), "SceneMode.SecurePhoto")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_GetSupportedOutputCapability() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        @Expect(ability.previewProfiles.size, 15)
        @Expect(ability.previewProfiles[0].format.toString(), "CameraFormat.CameraFormatYuv420Sp")
        @Expect(ability.previewProfiles[0].size.height, 480)
        @Expect(ability.previewProfiles[0].size.width, 480)
        @Expect(ability.photoProfiles.size, 17)
        @Expect(ability.photoProfiles[0].format.toString(), "CameraFormat.CameraFormatJpeg")
        @Expect(ability.photoProfiles[0].size.height, 480)
        @Expect(ability.photoProfiles[0].size.width, 640)
        @Expect(ability.videoProfiles.size, 0)
        @Expect(ability.supportedMetadataObjectTypes.size, 1)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_IsCameraMuted() {
        @Expect(getCameraManager().isCameraMuted(), false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_IsTorchSupported() {
        @Expect(getCameraManager().isTorchSupported(), true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_IsTorchModeSupported() {
        @Expect(getCameraManager().isTorchModeSupported(TorchMode.Off), true)
        @Expect(getCameraManager().isTorchModeSupported(TorchMode.On), true)
        @Expect(getCameraManager().isTorchModeSupported(TorchMode.Auto), false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_SetTorchMode() {
        @Expect(getCameraManager().getTorchMode(), TorchMode.Off)
        getCameraManager().setTorchMode(TorchMode.On)
        @Expect(getCameraManager().getTorchMode(), TorchMode.On)
        getCameraManager().setTorchMode(TorchMode.Off)
        @Expect(getCameraManager().getTorchMode(), TorchMode.Off)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_Onoff_CameraStatus() {
        let testCallbackCameraStatus = TestCallbackCameraStatus()
        getCameraManager().on(CameraEvents.CameraStatus, testCallbackCameraStatus)
        getCameraManager().on(CameraEvents.CameraStatus, testCallbackCameraStatus)
        getCameraManager().off(CameraEvents.CameraStatus, testCallbackCameraStatus)
        getCameraManager().off(CameraEvents.CameraStatus, testCallbackCameraStatus)
        getCameraManager().on(CameraEvents.CameraStatus, testCallbackCameraStatus)
        getCameraManager().off(CameraEvents.CameraStatus)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_Onoff_FoldStatusChange() {
        let testCallbackFoldStatusChange = TestCallbackFoldStatusChange()
        getCameraManager().on(CameraEvents.FoldStatusChange, testCallbackFoldStatusChange)
        getCameraManager().on(CameraEvents.FoldStatusChange, testCallbackFoldStatusChange)
        getCameraManager().off(CameraEvents.FoldStatusChange, testCallbackFoldStatusChange)
        getCameraManager().off(CameraEvents.FoldStatusChange, testCallbackFoldStatusChange)
        getCameraManager().on(CameraEvents.FoldStatusChange, testCallbackFoldStatusChange)
        getCameraManager().off(CameraEvents.FoldStatusChange)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_Onoff_TorchStatusChange() {
        let testCallbackTorchStatusChange = TestCallbackTorchStatusChange()
        getCameraManager().on(CameraEvents.TorchStatusChange, testCallbackTorchStatusChange)
        getCameraManager().on(CameraEvents.TorchStatusChange, testCallbackTorchStatusChange)
        getCameraManager().off(CameraEvents.TorchStatusChange, testCallbackTorchStatusChange)
        getCameraManager().off(CameraEvents.TorchStatusChange, testCallbackTorchStatusChange)
        getCameraManager().on(CameraEvents.TorchStatusChange, testCallbackTorchStatusChange)
        getCameraManager().off(CameraEvents.TorchStatusChange)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreateCameraInput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        try {
            getCameraManager().createCameraInput(CameraPosition.CameraPositionUnspecified,
                CameraType.CameraTypeTrueDepth)
            @Expect(true)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreateCameraInput2_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        try {
            getCameraManager().createCameraInput(CameraPosition.CameraPositionUnspecified,
                CameraType.CameraTypeWideAngle)
            @Expect(true)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreateCameraInput3_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        try {
            getCameraManager().createCameraInput(CameraPosition.CameraPositionUnspecified,
                CameraType.CameraTypeUltraWide)
            @Expect(true)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreateCameraInput4_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        try {
            getCameraManager().createCameraInput(CameraPosition.CameraPositionUnspecified,
                CameraType.CameraTypeTelephoto)
            @Expect(true)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreatePreviewOutput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        try {
            getCameraManager().createPreviewOutput(ability.photoProfiles[0], "")
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            try {
                getCameraManager().createPreviewOutput("123")
            } catch (e: BusinessException) {
                @Expect(e.code, 7400201)
                return
            }
        }
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraManager_CreateVideoOutput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        try {
            getCameraManager().createVideoOutput(ability.videoProfiles[0], "")
        } catch (e: BusinessException) {
            try {
                getCameraManager().createVideoOutput("123")
            } catch (e: BusinessException) {
                @Expect(e.code, 7400201)
                return
            }
            @Expect(e.code, 7400201)
        }
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraInput_OnOff() {
        let device = getCameraManager().getSupportedCameras()[0]
        let input = getCameraManager().createCameraInput(device)
        let testCallbackError = TestCallbackError()
        input.on(CameraEvents.CameraError, device, testCallbackError)
        input.on(CameraEvents.CameraError, device, testCallbackError)
        input.off(CameraEvents.CameraError, device, testCallbackError)
        input.off(CameraEvents.CameraError, device, testCallbackError)
        input.on(CameraEvents.CameraError, device, testCallbackError)
        input.off(CameraEvents.CameraError, device)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraInput_Open() {
        let device = getCameraManager().getSupportedCameras()[0]
        let input = getCameraManager().createCameraInput(device)
        input.open()
        input.close()
        try {
            input.open()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            try {
                input.open(true)
            } catch (e: BusinessException) {
                @Expect(e.code, 7400201)
                try {
                    input.open(false)
                } catch (e: BusinessException) {
                    @Expect(e.code, 7400201)
                    return
                }
            }
        }
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraInput_Close() {
        let device = getCameraManager().getSupportedCameras()[0]
        let input = getCameraManager().createCameraInput(device)
        let testCallbackError = TestCallbackError()
        input.open()
        input.close()
        try {
            input.close()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            return
        }
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        @Expect(photoSession.canAddInput(input), true)
        photoSession.addInput(input)
        photoSession.removeInput(input)
        photoSession.addInput(input)
        @Expect(photoSession.canAddOutput(previewOutput), true)
        photoSession.addOutput(previewOutput)
        photoSession.removeOutput(previewOutput)
        photoSession.addOutput(previewOutput)
        photoSession.commitConfig()
        photoSession.start()
        sleep(Duration.second * 2)
        photoSession.stop()
        photoSession.release()
        previewOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_SetFrameRate_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        try {
            previewOutput.setFrameRate(15, 20)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400103)
            previewOutput.release()
            return
        }
        previewOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_GetPreviewRotation_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        try {
            previewOutput.getPreviewRotation(0)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            previewOutput.release()
            return
        }
        previewOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_GetActiveProfile() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        try {
            previewOutput.getActiveProfile()
        } catch (e: BusinessException) {
            @Expect(false)
        }
        previewOutput.release()
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_SetPreviewRotation_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        try {
            previewOutput.setPreviewRotation(ImageRotation.Rotation0)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            previewOutput.release()
            return
        }
        previewOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_Onoff_FrameStart() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let testCallbackFrameStart = TestCallbackFrameStart()
        previewOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        previewOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        previewOutput.off(CameraEvents.FrameStart, testCallbackFrameStart)
        previewOutput.off(CameraEvents.FrameStart, testCallbackFrameStart)
        previewOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        previewOutput.off(CameraEvents.FrameStart)
        previewOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_Onoff_FrameEnd() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let testCallbackFrameEnd = TestCallbackFrameEnd()
        previewOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        previewOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        previewOutput.off(CameraEvents.FrameEnd, testCallbackFrameEnd)
        previewOutput.off(CameraEvents.FrameEnd, testCallbackFrameEnd)
        previewOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        previewOutput.off(CameraEvents.FrameEnd)
        previewOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_Onoff_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let testCallbackError = TestCallbackError()
        previewOutput.on(CameraEvents.CameraError, testCallbackError)
        previewOutput.on(CameraEvents.CameraError, testCallbackError)
        previewOutput.off(CameraEvents.CameraError, testCallbackError)
        previewOutput.off(CameraEvents.CameraError, testCallbackError)
        previewOutput.on(CameraEvents.CameraError, testCallbackError)
        previewOutput.off(CameraEvents.CameraError)
        previewOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_GetSupportedFrameRates() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(previewOutput)
        let supportedFrameRates = previewOutput.getSupportedFrameRates()
        @Expect(supportedFrameRates.size, 1)
        @Expect(supportedFrameRates[0].min, 12)
        @Expect(supportedFrameRates[0].max, 30)
        previewOutput.release()
        photoSession.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreviewOutput_SetFrameRate() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(previewOutput)
        photoSession.commitConfig()

        previewOutput.setFrameRate(15, 20)
        let activeFrameRate = previewOutput.getActiveFrameRate()
        @Expect(activeFrameRate.min, 15)
        @Expect(activeFrameRate.max, 20)

        previewOutput.release()
        photoSession.release()
        input.close()
    }

    @TestCase // setPreviewRotation设置不生效（与ArkTs一致）
    func Test_PreviewOutput_GetPreviewRotation() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(previewOutput)
        photoSession.commitConfig()
        photoSession.start()
        @Expect(previewOutput.getPreviewRotation(0), ImageRotation.Rotation90)
        previewOutput.setPreviewRotation(ImageRotation.Rotation0, isDisplayLocked: true)
        //        @Expect(previewOutput.getPreviewRotation(0), ImageRotation.Rotation0)
        previewOutput.release()
        photoSession.release()
        input.close()
    }

    @TestCase // setPreviewRotation设置不生效（与ArkTs一致）
    func Test_PreviewOutput_GetPreviewRotation_180() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(previewOutput)
        photoSession.commitConfig()
        photoSession.start()
        @Expect(previewOutput.getPreviewRotation(0), ImageRotation.Rotation90)
        previewOutput.setPreviewRotation(ImageRotation.Rotation180, isDisplayLocked: true)
        previewOutput.release()
        photoSession.release()
        input.close()
    }

    @TestCase // setPreviewRotation设置不生效（与ArkTs一致）
    func Test_PreviewOutput_GetPreviewRotation270() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(previewOutput)
        photoSession.commitConfig()
        photoSession.start()
        @Expect(previewOutput.getPreviewRotation(0), ImageRotation.Rotation90)
        previewOutput.setPreviewRotation(ImageRotation.Rotation270, isDisplayLocked: true)
        previewOutput.release()
        photoSession.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoOutput.capture()
        photoSession.start()
        sleep(Duration.second * 2)
        photoSession.stop()
        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutputNoInput() {
        try {
            let photoOutput = getCameraManager().createPhotoOutput()
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Capture_Medium() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoOutput.capture(PhotoCaptureSetting(location: Location(1.0, 2.0, 3.0)))
        photoSession.start()
        sleep(Duration.second * 2)
        photoSession.stop()
        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Capture_High() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoOutput.capture(PhotoCaptureSetting(quality: QualityLevelHigh))
        photoSession.start()
        sleep(Duration.second * 2)
        photoSession.stop()
        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Capture_Low() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoOutput.capture(PhotoCaptureSetting(quality: QualityLevelLow))
        photoSession.start()
        sleep(Duration.second * 2)
        photoSession.stop()
        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Capture_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        try {
            photoOutput.capture()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400104)
            try {
                photoOutput.capture(PhotoCaptureSetting())
            } catch (e: BusinessException) {
                @Expect(e.code, 7400104)
                photoOutput.release()
                return
            }
        }
        photoOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_EnableMirror_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoOutput.enableMirror(true)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            photoOutput.release()
            return
        }
        @Expect(false)
        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_GetPhotoRotation_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoOutput.getPhotoRotation(0)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            photoOutput.release()
            return
        }
        @Expect(false)
        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_CaptureStartWithInfo() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackCaptureStartWithInfo = TestCallbackCaptureStartWithInfo()
        photoOutput.on(CameraEvents.CaptureStartWithInfo, testCallbackCaptureStartWithInfo)
        photoOutput.on(CameraEvents.CaptureStartWithInfo, testCallbackCaptureStartWithInfo)
        photoOutput.off(CameraEvents.CaptureStartWithInfo, testCallbackCaptureStartWithInfo)
        photoOutput.off(CameraEvents.CaptureStartWithInfo, testCallbackCaptureStartWithInfo)
        photoOutput.on(CameraEvents.CaptureStartWithInfo, testCallbackCaptureStartWithInfo)
        photoOutput.off(CameraEvents.CaptureStartWithInfo)

        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_CaptureEnd() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackCaptureEnd = TestCallbackCaptureEnd()
        photoOutput.on(CameraEvents.CaptureEnd, testCallbackCaptureEnd)
        photoOutput.on(CameraEvents.CaptureEnd, testCallbackCaptureEnd)
        photoOutput.off(CameraEvents.CaptureEnd, testCallbackCaptureEnd)
        photoOutput.off(CameraEvents.CaptureEnd, testCallbackCaptureEnd)
        photoOutput.on(CameraEvents.CaptureEnd, testCallbackCaptureEnd)
        photoOutput.off(CameraEvents.CaptureEnd)

        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_FrameShutter() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackFrameShutter = TestCallbackFrameShutter()
        photoOutput.on(CameraEvents.FrameShutter, testCallbackFrameShutter)
        photoOutput.on(CameraEvents.FrameShutter, testCallbackFrameShutter)
        photoOutput.off(CameraEvents.FrameShutter, testCallbackFrameShutter)
        photoOutput.off(CameraEvents.FrameShutter, testCallbackFrameShutter)
        photoOutput.on(CameraEvents.FrameShutter, testCallbackFrameShutter)
        photoOutput.off(CameraEvents.FrameShutter)
        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_FrameShutterEnd() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackFrameShutterEnd = TestCallbackFrameShutterEnd()
        photoOutput.on(CameraEvents.FrameShutterEnd, testCallbackFrameShutterEnd)
        photoOutput.on(CameraEvents.FrameShutterEnd, testCallbackFrameShutterEnd)
        photoOutput.off(CameraEvents.FrameShutterEnd, testCallbackFrameShutterEnd)
        photoOutput.off(CameraEvents.FrameShutterEnd, testCallbackFrameShutterEnd)
        photoOutput.on(CameraEvents.FrameShutterEnd, testCallbackFrameShutterEnd)
        photoOutput.off(CameraEvents.FrameShutterEnd)

        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_CaptureReady() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackCaptureReady = TestCallbackCaptureReady()
        photoOutput.on(CameraEvents.CaptureReady, testCallbackCaptureReady)
        photoOutput.on(CameraEvents.CaptureReady, testCallbackCaptureReady)
        photoOutput.off(CameraEvents.CaptureReady, testCallbackCaptureReady)
        photoOutput.off(CameraEvents.CaptureReady, testCallbackCaptureReady)
        photoOutput.on(CameraEvents.CaptureReady, testCallbackCaptureReady)
        photoOutput.off(CameraEvents.CaptureReady)

        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_EstimatedCaptureDuration() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackEstimatedCaptureDuration = TestCallbackEstimatedCaptureDuration()
        photoOutput.on(CameraEvents.EstimatedCaptureDuration, testCallbackEstimatedCaptureDuration)
        photoOutput.on(CameraEvents.EstimatedCaptureDuration, testCallbackEstimatedCaptureDuration)
        photoOutput.off(CameraEvents.EstimatedCaptureDuration, testCallbackEstimatedCaptureDuration)
        photoOutput.off(CameraEvents.EstimatedCaptureDuration, testCallbackEstimatedCaptureDuration)
        photoOutput.on(CameraEvents.EstimatedCaptureDuration, testCallbackEstimatedCaptureDuration)
        photoOutput.off(CameraEvents.EstimatedCaptureDuration)

        photoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_Onoff_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        let testCallbackError = TestCallbackError()
        photoOutput.on(CameraEvents.CameraError, testCallbackError)
        photoOutput.on(CameraEvents.CameraError, testCallbackError)
        photoOutput.off(CameraEvents.CameraError, testCallbackError)
        photoOutput.off(CameraEvents.CameraError, testCallbackError)
        photoOutput.on(CameraEvents.CameraError, testCallbackError)
        photoOutput.off(CameraEvents.CameraError)

        photoOutput.release()
    }

    @TestCase // enableMovingPhoto修改无效
    func Test_PhotoOutput_EnableMovingPhoto() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        @Expect(photoOutput.isMovingPhotoSupported(), true)
        photoOutput.enableMovingPhoto(false)
        //        @Expect(photoOutput.isMovingPhotoSupported(), false)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_IsMovingPhotoSupported_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        try {
            photoOutput.isMovingPhotoSupported()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            photoOutput.release()
            return
        }
        photoOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_EnableMovingPhoto_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        try {
            photoOutput.enableMovingPhoto(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            photoOutput.release()
            return
        }
        photoOutput.release()
        @Expect(false)
    }

    @TestCase // enableMirror修改无效
    func Test_PhotoOutput_EnableMirror() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        @Expect(photoOutput.isMirrorSupported(), false)
        photoOutput.enableMirror(true)
        //        @Expect(photoOutput.isMirrorSupported(), true)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_SetMovingPhotoVideoCodecType() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        let arr = photoOutput.getSupportedMovingPhotoVideoCodecTypes()
        @Expect(arr.size, 2)
        photoOutput.setMovingPhotoVideoCodecType(VideoCodecType.Avc)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_SetMovingPhotoVideoCodecType2() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        let arr = photoOutput.getSupportedMovingPhotoVideoCodecTypes()
        @Expect(arr.size, 2)
        photoOutput.setMovingPhotoVideoCodecType(VideoCodecType.Hevc)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_GetActiveProfile() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        let profile = photoOutput.getActiveProfile()
        @Expect(profile.format, CameraFormat.CameraFormatJpeg)
        @Expect(profile.size.height, 480)
        @Expect(profile.size.width, 640)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoOutput_GetPhotoRotation() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let photoOutput = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        photoSession.beginConfig()
        photoSession.addInput(input)
        photoSession.addOutput(photoOutput)
        photoSession.commitConfig()
        photoSession.start()
        let rotation = photoOutput.getPhotoRotation(0)
        @Expect(rotation, ImageRotation.Rotation90)

        photoSession.release()
        photoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let videoSession = (getCameraManager().createSession(SceneMode.NormalVideo) as VideoSession).getOrThrow()
        videoSession.beginConfig()
        videoSession.addInput(input)
        videoSession.addOutput(videoOutput)
        videoSession.commitConfig()

        videoOutput.start()
        sleep(Duration.second * 2)
        videoOutput.stop()

        videoSession.release()
        videoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_Start_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        try {
            videoOutput.start()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400103)
            videoOutput.release()
            return
        }
        @Expect(false)
        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_Stop_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        try {
            videoOutput.stop()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            videoOutput.release()
            return
        }
        @Expect(false)
        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_GetVideoRotation_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        try {
            videoOutput.getVideoRotation(0)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            videoOutput.release()
            return
        }
        @Expect(false)
        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_Onoff_FrameStart() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)

        let testCallbackFrameStart = TestCallbackFrameStart()
        videoOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        videoOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        videoOutput.off(CameraEvents.FrameStart, testCallbackFrameStart)
        videoOutput.off(CameraEvents.FrameStart, testCallbackFrameStart)
        videoOutput.on(CameraEvents.FrameStart, testCallbackFrameStart)
        videoOutput.off(CameraEvents.FrameStart)

        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_Onoff_FrameEnd() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)

        let testCallbackFrameEnd = TestCallbackFrameEnd()
        videoOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        videoOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        videoOutput.off(CameraEvents.FrameEnd, testCallbackFrameEnd)
        videoOutput.off(CameraEvents.FrameEnd, testCallbackFrameEnd)
        videoOutput.on(CameraEvents.FrameEnd, testCallbackFrameEnd)
        videoOutput.off(CameraEvents.FrameEnd)

        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_Onoff_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)

        let testCallbackError = TestCallbackError()
        videoOutput.on(CameraEvents.CameraError, testCallbackError)
        videoOutput.on(CameraEvents.CameraError, testCallbackError)
        videoOutput.off(CameraEvents.CameraError, testCallbackError)
        videoOutput.off(CameraEvents.CameraError, testCallbackError)
        videoOutput.on(CameraEvents.CameraError, testCallbackError)
        videoOutput.off(CameraEvents.CameraError)

        videoOutput.release()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_GetSupportedFrameRates() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let videoSession = (getCameraManager().createSession(SceneMode.NormalVideo) as VideoSession).getOrThrow()
        videoSession.beginConfig()
        videoSession.addInput(input)
        videoSession.addOutput(videoOutput)
        videoSession.commitConfig()

        let supportedFrameRates = videoOutput.getSupportedFrameRates()
        @Expect(supportedFrameRates.size, 2)
        @Expect(supportedFrameRates[0].min, 1)
        @Expect(supportedFrameRates[0].max, 30)

        videoSession.release()
        videoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_SetFrameRate() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let videoSession = (getCameraManager().createSession(SceneMode.NormalVideo) as VideoSession).getOrThrow()
        videoSession.beginConfig()
        videoSession.addInput(input)
        videoSession.addOutput(videoOutput)
        videoSession.commitConfig()

        videoOutput.setFrameRate(10, 20)
        let activeFrameRate = videoOutput.getActiveFrameRate()
        @Expect(activeFrameRate.min, 10)
        @Expect(activeFrameRate.max, 20)

        videoSession.release()
        videoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_SetFrameRate_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        try {
            videoOutput.setFrameRate(15, 20)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400103)
            videoOutput.release()
            return
        }
        videoOutput.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_GetActiveProfile() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let videoSession = (getCameraManager().createSession(SceneMode.NormalVideo) as VideoSession).getOrThrow()
        videoSession.beginConfig()
        videoSession.addInput(input)
        videoSession.addOutput(videoOutput)
        videoSession.commitConfig()

        let profile = videoOutput.getActiveProfile()
        @Expect(profile.format, CameraFormat.CameraFormatYuv420Sp)
        @Expect(profile.size.width, 640)
        @Expect(profile.size.height, 480)
        @Expect(profile.frameRateRange.min, 1)
        @Expect(profile.frameRateRange.max, 30)

        videoSession.release()
        videoOutput.release()
        input.close()
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoOutput_GetVideoRotation() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[1]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let videoOutput = getCameraManager().createVideoOutput(ability.videoProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let videoSession = (getCameraManager().createSession(SceneMode.NormalVideo) as VideoSession).getOrThrow()
        videoSession.beginConfig()
        videoSession.addInput(input)
        videoSession.addOutput(videoOutput)
        videoSession.commitConfig()

        @Expect(videoOutput.getVideoRotation(0), ImageRotation.Rotation90)

        videoSession.release()
        videoOutput.release()
        input.close()
    }


    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_CommitConfig_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.commitConfig()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400102)
            photoSession.release()
            return
        }
        photoSession.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_AddInput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.addInput(input)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400102)
            photoSession.release()
            input.close()
            return
        }
        photoSession.release()
        input.close()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_RemoveInput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.removeInput(input)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400102)
            photoSession.release()
            input.close()
            return
        }
        photoSession.release()
        input.close()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_AddOutput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.addOutput(previewOutput)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400102)
            photoSession.release()
            input.close()
            return
        }
        photoSession.release()
        input.close()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_RemoveOutput_Error() {
        let device = getCameraManager().getSupportedCameras()[0]
        let mode = getCameraManager().getSupportedSceneModes(device)[0]
        let ability = getCameraManager().getSupportedOutputCapability(device, mode)
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 8)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)
        let input = getCameraManager().createCameraInput(device)
        input.open()
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.removeOutput(previewOutput)
        } catch (e: BusinessException) {
            @Expect(e.code, 7400102)
            photoSession.release()
            input.close()
            return
        }
        photoSession.release()
        input.close()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_Start_Error() {
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.start()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400103)
            photoSession.release()
            return
        }
        photoSession.release()
        @Expect(false)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Session_Stop_Error() {
        let photoSession = (getCameraManager().createSession(SceneMode.NormalPhoto) as PhotoSession).getOrThrow()
        try {
            photoSession.stop()
        } catch (e: BusinessException) {
            @Expect(e.code, 7400201)
            photoSession.release()
            return
        }
        photoSession.release()
        @Expect(false)
    }

    func getPhotoSession(index: Int64): PhotoSession {
        let session: PhotoSession = (getCameraManager()
            .createSession(SceneMode.NormalPhoto) as PhotoSession)
            .getOrThrow()

        // input
        let device = getCameraManager().getSupportedCameras()[index]
        let input = getCameraManager().createCameraInput(device)

        let ability = getCameraManager().getSupportedOutputCapability(device, SceneMode.NormalPhoto)

        // preview output
        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 64)
        let receiverId = receiver.getReceivingSurfaceId()
        let previewOutput = getCameraManager().createPreviewOutput(ability.previewProfiles[0], receiverId)

        // output
        let output = getCameraManager().createPhotoOutput(profile: ability.photoProfiles[0])

        input.open()
        session.beginConfig()
        session.addInput(input)
        session.addOutput(previewOutput)
        session.addOutput(output)
        session.commitConfig()

        return session
    }

    func getVideoSession(): VideoSession {
        let session: VideoSession = (getCameraManager()
            .createSession(SceneMode.NormalVideo) as VideoSession)
            .getOrThrow();

        let device = getCameraManager().getSupportedCameras()[0]
        let input = getCameraManager().createCameraInput(device)

        let ability = getCameraManager().getSupportedOutputCapability(device, SceneMode.NormalVideo)

        let size = ImageSize(8192, 8)
        let receiver = createImageReceiver(size, ImageFormat.Jpeg, 64)
        let surfaceId: String = receiver.getReceivingSurfaceId()
        let output = getCameraManager().createPreviewOutput(ability.previewProfiles[0], surfaceId)

        input.open()
        session.beginConfig()
        session.addInput(input)
        session.addOutput(output)
        session.commitConfig()

        return session
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_Flash(): Unit {
        try {
            loggerInfo("[multimedia_camera | Test_Flash]: test_flash start!")
            let session: PhotoSession = getPhotoSession(0)

            let res = session.hasFlash()
            loggerInfo("[multimedia_camera | Test_Flash]: hasFlash = ${res}")
            if (!res) {
                @Expect(false)
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

                    @Expect(false)
                }
            }

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_Flash]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
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

            @Expect(Float32(curPoint.x), 0.123)
            @Expect(Float32(curPoint.y), 0.456)

            session.release()
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | Test_AutoExposure]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
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

            @Expect(Float32(curPoint.x), 0.123)
            @Expect(Float32(curPoint.y), 0.456)

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
    @Tag[APILevel21, TestLevel0]
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
    @Tag[APILevel21, TestLevel0]
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
    @Tag[APILevel21, TestLevel0]
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
    @Tag[APILevel21, TestLevel0]
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

                        @Expect(false)
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
    @Tag[APILevel21, TestLevel0]
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
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
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
    @Tag[APILevel21, TestLevel0]
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
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoSessionSmoothCallback() {
        let TAG = "Test_PhotoSessionSmoothCallback"
        let session = getPhotoSession(0)
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PhotoSessionSmoothCallback1() {
        let TAG = "Test_PhotoSessionSmoothCallback1"
        let session = getPhotoSession(0)
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
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
    @Tag[APILevel21, TestLevel0]
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
    @Tag[APILevel21, TestLevel0]
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
    @Tag[APILevel21, TestLevel0]
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
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
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
    @Tag[APILevel21, TestLevel0]
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
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoSessionSmoothCallback() {
        let TAG = "Test_VideoSessionSmoothCallback"
        let session = getVideoSession()
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoSessionSmoothCallback1() {
        let TAG = "Test_VideoSessionSmoothCallback1"
        let session = getVideoSession()
        try {
            let callback = SmoothZoomInfoAvailableCallback()

            SmoothZoomInfoAvailableCallback.invoked = false
            session.on(CameraEvents.SmoothZoomInfoAvailable, callback)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, true)

            SmoothZoomInfoAvailableCallback.invoked = false
            session.off(CameraEvents.SmoothZoomInfoAvailable)
            session.setSmoothZoom(0.3, SmoothZoomMode.Normal)
            sleep(Duration.second * 1)
            @Expect(SmoothZoomInfoAvailableCallback.invoked, false)
        } catch (e: BusinessException) {
            loggerInfo("[multimedia_camera | ${TAG}]: Exception ${e.code}: ${e.message}")
            @Expect(false)
        } finally {
            session.release()
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
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


    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_TorchMode() {
        let torchModeArr: Array<TorchMode> = [Off, TorchMode.On, Auto]
        let torchModeArr2: Array<TorchMode> = [Off, TorchMode.On, Auto]
        let torchModeStrArr: Array<String> = ["TorchMode.Off", "TorchMode.On", "TorchMode.Auto"]
        for (i in 0..torchModeArr.size) {
            @Expect(torchModeArr[i].toString() == torchModeStrArr[i])
            @Expect(torchModeArr[i] == torchModeArr2[i])
            if (i + 1 < torchModeArr.size) {
                @Expect(torchModeArr[i] != torchModeArr[i + 1])
            } else {
                @Expect(torchModeArr[i] != torchModeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_ImageRotation() {
        let imageRotationArr: Array<ImageRotation> = [
            Rotation0,
            Rotation90,
            Rotation180,
            Rotation270
        ]
        let imageRotationArr2: Array<ImageRotation> = [
            Rotation0,
            Rotation90,
            Rotation180,
            Rotation270
        ]
        let imageRotationStrArr: Array<String> = [
            "ImageRotation.Rotation0",
            "ImageRotation.Rotation90",
            "ImageRotation.Rotation180",
            "ImageRotation.Rotation270"
        ]
        for (i in 0..imageRotationArr.size) {
            @Expect(imageRotationArr[i].toString() == imageRotationStrArr[i])
            @Expect(imageRotationArr[i] == imageRotationArr2[i])
            if (i + 1 < imageRotationArr.size) {
                @Expect(imageRotationArr[i] != imageRotationArr[i + 1])
            } else {
                @Expect(imageRotationArr[i] != imageRotationArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraStatus() {
        let cameraStatusArr: Array<CameraStatus> = [
            CameraStatusAppear,
            CameraStatusDisappear,
            CameraStatusAvailable,
            CameraStatusUnavailable
        ]
        let cameraStatusArr2: Array<CameraStatus> = [
            CameraStatusAppear,
            CameraStatusDisappear,
            CameraStatusAvailable,
            CameraStatusUnavailable
        ]
        let cameraStatusStrArr: Array<String> = [
            "CameraStatus.CameraStatusAppear",
            "CameraStatus.CameraStatusDisappear",
            "CameraStatus.CameraStatusAvailable",
            "CameraStatus.CameraStatusUnavailable"
        ]
        for (i in 0..cameraStatusArr.size) {
            @Expect(cameraStatusArr[i].toString() == cameraStatusStrArr[i])
            @Expect(cameraStatusArr[i] == cameraStatusArr2[i])
            if (i + 1 < cameraStatusArr.size) {
                @Expect(cameraStatusArr[i] != cameraStatusArr[i + 1])
            } else {
                @Expect(cameraStatusArr[i] != cameraStatusArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_FoldStatus() {
        let foldStatusArr: Array<FoldStatus> = [
            NonFoldable,
            Expanded,
            Folded
        ]
        let foldStatusArr2: Array<FoldStatus> = [
            NonFoldable,
            Expanded,
            Folded
        ]
        let foldStatusStrArr: Array<String> = [
            "FoldStatus.NonFoldable",
            "FoldStatus.Expanded",
            "FoldStatus.Folded"
        ]
        for (i in 0..foldStatusArr.size) {
            @Expect(foldStatusArr[i].toString() == foldStatusStrArr[i])
            @Expect(foldStatusArr[i] == foldStatusArr2[i])
            if (i + 1 < foldStatusArr.size) {
                @Expect(foldStatusArr[i] != foldStatusArr[i + 1])
            } else {
                @Expect(foldStatusArr[i] != foldStatusArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_ConnectionType() {
        let connectionTypeArr: Array<ConnectionType> = [
            CameraConnectionBuiltIn,
            CameraConnectionUsbPlugin,
            CameraConnectionRemote
        ]
        let connectionTypeArr2: Array<ConnectionType> = [
            CameraConnectionBuiltIn,
            CameraConnectionUsbPlugin,
            CameraConnectionRemote
        ]
        let connectionTypeStrArr: Array<String> = [
            "ConnectionType.CameraConnectionBuiltIn",
            "ConnectionType.CameraConnectionUsbPlugin",
            "ConnectionType.CameraConnectionRemote"
        ]
        for (i in 0..connectionTypeArr.size) {
            @Expect(connectionTypeArr[i].toString() == connectionTypeStrArr[i])
            @Expect(connectionTypeArr[i] == connectionTypeArr2[i])
            if (i + 1 < connectionTypeArr.size) {
                @Expect(connectionTypeArr[i] != connectionTypeArr[i + 1])
            } else {
                @Expect(connectionTypeArr[i] != connectionTypeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraFormat() {
        let cameraFormatArr: Array<CameraFormat> = [
            CameraFormatYcrcbP010,
            CameraFormatYcbcrP010,
            CameraFormatHeic,
            CameraFormatJpeg,
            CameraFormatYuv420Sp,
            CameraFormatRgba8888
        ]
        let cameraFormatArr2: Array<CameraFormat> = [
            CameraFormatYcrcbP010,
            CameraFormatYcbcrP010,
            CameraFormatHeic,
            CameraFormatJpeg,
            CameraFormatYuv420Sp,
            CameraFormatRgba8888
        ]
        let cameraFormatStrArr: Array<String> = [
            "CameraFormat.CameraFormatYcrcbP010",
            "CameraFormat.CameraFormatYcbcrP010",
            "CameraFormat.CameraFormatHeic",
            "CameraFormat.CameraFormatJpeg",
            "CameraFormat.CameraFormatYuv420Sp",
            "CameraFormat.CameraFormatRgba8888"
        ]
        for (i in 0..cameraFormatArr.size) {
            @Expect(cameraFormatArr[i].toString() == cameraFormatStrArr[i])
            @Expect(cameraFormatArr[i] == cameraFormatArr2[i])
            if (i + 1 < cameraFormatArr.size) {
                @Expect(cameraFormatArr[i] != cameraFormatArr[i + 1])
            } else {
                @Expect(cameraFormatArr[i] != cameraFormatArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraEvents() {
        let CameraEventsArr: Array<CameraEvents> = [
            CameraError,
            CameraEvents.CameraStatus,
            FoldStatusChange,
            TorchStatusChange,
            FrameStart,
            FrameEnd,
            CaptureStartWithInfo,
            FrameShutter,
            CaptureEnd,
            FrameShutterEnd,
            CaptureReady,
            EstimatedCaptureDuration,
            MetadataObjectsAvailable,
            FocusStateChange,
            SmoothZoomInfoAvailable
        ]
        let CameraEventsArr2: Array<CameraEvents> = [
            CameraError,
            CameraEvents.CameraStatus,
            FoldStatusChange,
            TorchStatusChange,
            FrameStart,
            FrameEnd,
            CaptureStartWithInfo,
            FrameShutter,
            CaptureEnd,
            FrameShutterEnd,
            CaptureReady,
            EstimatedCaptureDuration,
            MetadataObjectsAvailable,
            FocusStateChange,
            SmoothZoomInfoAvailable
        ]
        let CameraEventsStrArr: Array<String> = [
            "error",
            "cameraStatus",
            "foldStatusChange",
            "torchStatusChange",
            "frameStart",
            "frameEnd",
            "captureStartWithInfo",
            "frameShutter",
            "captureEnd",
            "frameShutterEnd",
            "captureReady",
            "estimatedCaptureDuration",
            "metadataObjectsAvailable",
            "focusStateChange",
            "smoothZoomInfoAvailable"
        ]
        for (i in 0..CameraEventsArr.size) {
            @Expect(CameraEventsArr[i] == CameraEventsArr2[i])
            if (i + 1 < CameraEventsArr.size) {
                @Expect(CameraEventsArr[i] != CameraEventsArr[i + 1])
            } else {
                @Expect(CameraEventsArr[i] != CameraEventsArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraPosition() {
        let cameraPositionArr: Array<CameraPosition> = [
            CameraPositionUnspecified,
            CameraPositionBack,
            CameraPositionFront
        ]
        let cameraPositionArr2: Array<CameraPosition> = [
            CameraPositionUnspecified,
            CameraPositionBack,
            CameraPositionFront
        ]
        let cameraPositionStrArr: Array<String> = [
            "CameraPosition.CameraPositionUnspecified",
            "CameraPosition.CameraPositionBack",
            "CameraPosition.CameraPositionFront"
        ]
        for (i in 0..cameraPositionArr.size) {
            @Expect(cameraPositionArr[i].toString() == cameraPositionStrArr[i])
            @Expect(cameraPositionArr[i] == cameraPositionArr2[i])
            if (i + 1 < cameraPositionArr.size) {
                @Expect(cameraPositionArr[i] != cameraPositionArr[i + 1])
            } else {
                @Expect(cameraPositionArr[i] != cameraPositionArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_CameraType() {
        let cameraTypeArr: Array<CameraType> = [
            CameraTypeDefault,
            CameraTypeWideAngle,
            CameraTypeUltraWide,
            CameraTypeTelephoto,
            CameraTypeTrueDepth
        ]
        let cameraTypeArr2: Array<CameraType> = [
            CameraTypeDefault,
            CameraTypeWideAngle,
            CameraTypeUltraWide,
            CameraTypeTelephoto,
            CameraTypeTrueDepth
        ]
        let cameraTypeStrArr: Array<String> = [
            "CameraType.CameraTypeDefault",
            "CameraType.CameraTypeWideAngle",
            "CameraType.CameraTypeUltraWide",
            "CameraType.CameraTypeTelephoto",
            "CameraType.CameraTypeTrueDepth"
        ]
        for (i in 0..cameraTypeArr.size) {
            @Expect(cameraTypeArr[i].toString() == cameraTypeStrArr[i])
            @Expect(cameraTypeArr[i] == cameraTypeArr2[i])
            if (i + 1 < cameraTypeArr.size) {
                @Expect(cameraTypeArr[i] != cameraTypeArr[i + 1])
            } else {
                @Expect(cameraTypeArr[i] != cameraTypeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_SceneMode() {
        let sceneModeArr: Array<SceneMode> = [
            NormalPhoto,
            NormalVideo,
            SecurePhoto
        ]
        let sceneModeStrArr: Array<String> = [
            "SceneMode.NormalPhoto",
            "SceneMode.NormalVideo",
            "SceneMode.SecurePhoto"
        ]
        for (i in 0..sceneModeArr.size) {
            @Expect(sceneModeArr[i].toString() == sceneModeStrArr[i])
            @Expect(sceneModeArr[i] == sceneModeArr[i])
            if (i + 1 < sceneModeArr.size) {
                @Expect(sceneModeArr[i] != sceneModeArr[i + 1])
            } else {
                @Expect(sceneModeArr[i] != sceneModeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_QualityLevel() {
        let qualityLevelArr: Array<QualityLevel> = [
            QualityLevelHigh,
            QualityLevelMedium,
            QualityLevelLow
        ]
        let qualityLevelArr2: Array<QualityLevel> = [
            QualityLevelHigh,
            QualityLevelMedium,
            QualityLevelLow
        ]
        let qualityLevelStrArr: Array<String> = [
            "QualityLevel.QualityLevelHigh",
            "QualityLevel.QualityLevelMedium",
            "QualityLevel.QualityLevelLow"
        ]
        for (i in 0..qualityLevelArr.size) {
            @Expect(qualityLevelArr[i].toString() == qualityLevelStrArr[i])
            @Expect(qualityLevelArr[i] == qualityLevelArr2[i])
            if (i + 1 < qualityLevelArr.size) {
                @Expect(qualityLevelArr[i] != qualityLevelArr[i + 1])
            } else {
                @Expect(qualityLevelArr[i] != qualityLevelArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_VideoCodecType() {
        @Expect(Avc.toString() == "VideoCodecType.Avc")
        @Expect(Hevc.toString() == "VideoCodecType.Hevc")
        @Expect(Avc != Hevc)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreconfigType() {
        let preconfigTypeArr: Array<PreconfigType> = [
            Preconfig720p,
            Preconfig1080p,
            Preconfig4k,
            PreconfigHighQuality
        ]
        let preconfigTypeArr2: Array<PreconfigType> = [
            Preconfig720p,
            Preconfig1080p,
            Preconfig4k,
            PreconfigHighQuality
        ]
        let preconfigTypeStrArr: Array<String> = [
            "PreconfigType.Preconfig720p",
            "PreconfigType.Preconfig1080p",
            "PreconfigType.Preconfig4k",
            "PreconfigType.PreconfigHighQuality"
        ]
        for (i in 0..preconfigTypeArr.size) {
            @Expect(preconfigTypeArr[i].toString() == preconfigTypeStrArr[i])
            @Expect(preconfigTypeArr[i] == preconfigTypeArr2[i])
            if (i + 1 < preconfigTypeArr.size) {
                @Expect(preconfigTypeArr[i] != preconfigTypeArr[i + 1])
            } else {
                @Expect(preconfigTypeArr[i] != preconfigTypeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_FocusState() {
        let focusStateArr: Array<FocusState> = [
            FocusStateScan,
            FocusStateFocused,
            FocusStateUnfocused
        ]
        let focusStateArr2: Array<FocusState> = [
            FocusStateScan,
            FocusStateFocused,
            FocusStateUnfocused
        ]
        let focusStateStrArr: Array<String> = [
            "FocusState.FocusStateScan",
            "FocusState.FocusStateFocused",
            "FocusState.FocusStateUnfocused"
        ]
        for (i in 0..focusStateArr.size) {
            @Expect(focusStateArr[i].toString() == focusStateStrArr[i])
            @Expect(focusStateArr[i] == focusStateArr2[i])
            if (i + 1 < focusStateArr.size) {
                @Expect(focusStateArr[i] != focusStateArr[i + 1])
            } else {
                @Expect(focusStateArr[i] != focusStateArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_PreconfigRatio() {
        let preconfigRatioArr: Array<PreconfigRatio> = [
            PreconfigRatio_1_1,
            PreconfigRatio_4_3,
            PreconfigRatio_16_9
        ]
        let preconfigRatioArr2: Array<PreconfigRatio> = [
            PreconfigRatio_1_1,
            PreconfigRatio_4_3,
            PreconfigRatio_16_9
        ]
        let preconfigRatioStrArr: Array<String> = [
            "PreconfigRatio.PreconfigRatio_1_1",
            "PreconfigRatio.PreconfigRatio_4_3",
            "PreconfigRatio.PreconfigRatio_16_9"
        ]
        for (i in 0..preconfigRatioArr.size) {
            @Expect(preconfigRatioArr[i].toString() == preconfigRatioStrArr[i])
            @Expect(preconfigRatioArr[i] == preconfigRatioArr2[i])
            if (i + 1 < preconfigRatioArr.size) {
                @Expect(preconfigRatioArr[i] != preconfigRatioArr[i + 1])
            } else {
                @Expect(preconfigRatioArr[i] != preconfigRatioArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_ErrorCase() {
        let session: PhotoSession = (getCameraManager().createSession(NormalPhoto) as PhotoSession).getOrThrow()
        Test_ErrorCaseFlash(session)
        Test_ErrorCaseAutoExposure(session)
        Test_ErrorCaseFocus(session)
        Test_ErrorCaseZoom(session)
        Test_ErrorCaseColor(session)

        let vsession: VideoSession = (getCameraManager().createSession(NormalVideo) as VideoSession).getOrThrow()
        Test_ErrorCaseFlash(vsession)
        Test_ErrorCaseAutoExposure(vsession)
        Test_ErrorCaseFocus(vsession)
        Test_ErrorCaseZoom(vsession)
        Test_ErrorCaseColor(vsession)
        Test_ErrorCaseStabilization(vsession)
    }

    func Test_ErrorCaseFlash(session: Flash) {
        loggerInfo("[multimedia_camera]: ErrorCaseFlash")

        try {
            session.hasFlash();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.isFlashModeSupported(FlashModeAlwaysOpen);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getFlashMode();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setFlashMode(FlashModeAlwaysOpen);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    func Test_ErrorCaseAutoExposure(session: AutoExposure) {
        loggerInfo("[multimedia_camera]: ErrorCaseAutoExposure")

        try {
            session.isExposureModeSupported(ExposureModeContinuousAuto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getExposureBiasRange();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getExposureMode();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setExposureMode(ExposureMode.ExposureModeContinuousAuto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getMeteringPoint();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setMeteringPoint(cameraPoint(0.5, 0.5));
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setExposureBias(0.5);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getExposureValue();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    func Test_ErrorCaseFocus(session: Focus) {
        loggerInfo("[multimedia_camera]: ErrorCaseFocus")

        try {
            session.isFocusModeSupported(FocusMode.FocusModeAuto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setFocusMode(FocusMode.FocusModeAuto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getFocusMode();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setFocusPoint(cameraPoint(0.5, 0.5));
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getFocusPoint();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getFocalLength();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    func Test_ErrorCaseZoom(session: Zoom) {
        loggerInfo("[multimedia_camera]: ErrorCaseZoom")

        try {
            session.getZoomRatioRange();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setZoomRatio(0.5);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getZoomRatio();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setSmoothZoom(0.5, SmoothZoomMode.Normal);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setSmoothZoom(0.5);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    func Test_ErrorCaseStabilization(session: Stabilization) {
        loggerInfo("[multimedia_camera]: ErrorCaseStabilization")

        try {
            session.isVideoStabilizationModeSupported(VideoStabilizationMode.Auto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getActiveVideoStabilizationMode();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setVideoStabilizationMode(VideoStabilizationMode.Auto);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    func Test_ErrorCaseColor(session: ColorManagement) {
        loggerInfo("[multimedia_camera]: ErrorCaseColor")

        // both ArkTS and C++ implementations don't return error code,
        // cj does the same thing
        try {
            session.getSupportedColorSpaces()
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.setColorSpace(ColorSpace.DisplayP3);
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }

        try {
            session.getActiveColorSpace();
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_ExposureMode() {
        let arr1: Array<ExposureMode> = [
            ExposureModeLocked,
            ExposureModeAuto,
            ExposureModeContinuousAuto
        ]
        let arrStr: Array<String> = [
            "ExposureMode.ExposureModeLocked",
            "ExposureMode.ExposureModeAuto",
            "ExposureMode.ExposureModeContinuousAuto"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_FlashMode() {
        let arr1: Array<FlashMode> = [
            FlashModeClose,
            FlashModeOpen,
            FlashModeAuto,
            FlashModeAlwaysOpen
        ]
        let arrStr: Array<String> = [
            "FlashMode.FlashModeClose",
            "FlashMode.FlashModeOpen",
            "FlashMode.FlashModeAuto",
            "FlashMode.FlashModeAlwaysOpen"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_FocusMode() {
        let arr1: Array<FocusMode> = [
            FocusModeManual,
            FocusModeContinuousAuto,
            FocusModeAuto,
            FocusModeLocked
        ]
        let arrStr: Array<String> = [
            "FocusMode.FocusModeManual",
            "FocusMode.FocusModeContinuousAuto",
            "FocusMode.FocusModeAuto",
            "FocusMode.FocusModeLocked"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_VideoStabilizationMode() {
        let arr1: Array<VideoStabilizationMode> = [
            Off,
            Low,
            Middle,
            High,
            Auto
        ]
        let arrStr: Array<String> = [
            "VideoStabilizationMode.Off",
            "VideoStabilizationMode.Low",
            "VideoStabilizationMode.Middle",
            "VideoStabilizationMode.High",
            "VideoStabilizationMode.Auto"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_SmoothZoomMode() {
        let arr1: Array<SmoothZoomMode> = [SmoothZoomMode.Normal]
        let arrStr: Array<String> = ["SmoothZoomMode.Normal"]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_MetadataObjectType() {
        let arr1: Array<MetadataObjectType> = [MetadataObjectType.FaceDetection]
        let arrStr: Array<String> = ["MetadataObjectType.FaceDetection"]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i].toString() == arrStr[i])
        }
     }
}

class TestCallbackBusinessException <: Callback1Argument<BusinessException> {
    public func invoke(err: ?BusinessException, val: BusinessException): Unit {
        loggerInfo("Call back.")
    }
}

func getCameraManager(): CameraManager {
    return cameraManager.getOrThrow()
}

class TestCallbackTorchStatusChange <: Callback1Argument<TorchStatusInfo> {
    public init() {}
    public func invoke(rr: ?BusinessException, res: TorchStatusInfo): Unit {
        loggerInfo(
            "Call invoke torchStatusChange. isTorchAvailable: ${res.isTorchAvailable}, isTorchActive: ${res.isTorchActive}, torchLevel:${res.torchLevel}"
        )
    }
}

class TestCallbackCameraStatus <: Callback1Argument<CameraStatusInfo> {
    public init() {}
    public func invoke(rr: ?BusinessException, res: CameraStatusInfo): Unit {
        loggerInfo("Call invoke cameraStatus. CameraDevice: ${res.camera.cameraId}, CameraStatus: ${res.status}")
    }
}

class TestCallbackFoldStatusChange <: Callback1Argument<FoldStatusInfo> {
    public init() {}
    public func invoke(rr: ?BusinessException, res: FoldStatusInfo): Unit {
        loggerInfo("Call invoke foldStatusChange.")
    }
}

class TestCallbackError <: Callback0Argument {
    public init() {}
    public func invoke(err: ?BusinessException): Unit {
        if (let Some(v) <- err) {
            loggerInfo("Call invoke error. code: ${v.code}, msg: ${v.message}")
            return
        }
        loggerInfo("no error in TestCallbackError")
    }
}

class TestCallbackFrameStart <: Callback0Argument {
    public init() {}
    public func invoke(err: ?BusinessException): Unit {
        loggerInfo("Call invoke frameStart.")
    }
}

class TestCallbackFrameEnd <: Callback0Argument {
    public init() {}
    public func invoke(err: ?BusinessException): Unit {
        loggerInfo("Call invoke frameEnd.")
    }
}

class TestCallbackCaptureStartWithInfo <: Callback1Argument<CaptureStartInfo> {
    public init() {}
    public func invoke(err: ?BusinessException, res: CaptureStartInfo): Unit {
        loggerInfo("Call invoke captureStartWithInfo. captureId: ${res.captureId}, time： ${res.time}")
    }
}

class TestCallbackCaptureEnd <: Callback1Argument<CaptureEndInfo> {
    public init() {}
    public func invoke(err: ?BusinessException, res: CaptureEndInfo): Unit {
        loggerInfo("Call invoke captureEnd. captureId: ${res.captureId}, frameCount： ${res.frameCount}")
    }
}

class TestCallbackFrameShutter <: Callback1Argument<FrameShutterInfo> {
    public init() {}
    public func invoke(err: ?BusinessException, res: FrameShutterInfo): Unit {
        loggerInfo("Call invoke frameShutter. captureId: ${res.captureId}, timestamp： ${res.timestamp}")
    }
}

class TestCallbackFrameShutterEnd <: Callback1Argument<FrameShutterEndInfo> {
    public init() {}
    public func invoke(err: ?BusinessException, res: FrameShutterEndInfo): Unit {
        loggerInfo("Call invoke frameShutterEnd. captureId: ${res.captureId}")
    }
}

class TestCallbackCaptureReady <: Callback0Argument {
    public init() {}
    public func invoke(err: ?BusinessException): Unit {
        loggerInfo("Call invoke captureReady.")
    }
}

class TestCallbackEstimatedCaptureDuration <: Callback1Argument<Float64> {
    public init() {}
    public func invoke(err: ?BusinessException, res: Float64): Unit {
        loggerInfo("Call invoke estimatedCaptureDuration. time: ${res}")
    }
}

class FocusStateChangeCallback <: Callback1Argument<FocusState> {
    public static var invoked = false

    public func invoke(err: ?BusinessException, state: FocusState) {
        loggerInfo("[multimedia_camera | FocusStateChange Callback]: focus state: ${state}")

        invoked = true
    }
}

class ErrorCallback <: Callback0Argument {
    public static var invoked = false

    public func invoke(err: ?BusinessException) {
        if (let Some(v) <- err) {
            loggerInfo("Call invoke error. code: ${v.code}, msg: ${v.message}")
            return
        }
        loggerInfo("no error in TestCallbackError")
        invoked = true
    }
}

class SmoothZoomInfoAvailableCallback <: Callback1Argument<SmoothZoomInfo> {
    public static var invoked = false

    public func invoke(err: ?BusinessException, info: SmoothZoomInfo) {
        loggerInfo("[multimedia_camera | SmoothZoomInfoAvailable Callback]: info: ${info.duration}")

        invoked = true
    }
}
