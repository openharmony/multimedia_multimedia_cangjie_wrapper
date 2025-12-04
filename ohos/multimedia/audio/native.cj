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

package ohos.multimedia.audio

import ohos.ffi.{CArrI32}

foreign {
    /**
     * MMA is the abbreviation of MultimediaAudio
     * AudioCapturer
     */
    func FfiMMACreateAudioCapturer(option: CAudioCapturerOptions, errorCode: CPointer<Int32>): Int64

    func FfiMMAAudioCapturerGetState(id: Int64, errorCode: CPointer<Int32>): Int32

    func FfiMMAAudioCapturerStart(id: Int64, errorCode: CPointer<Int32>): Unit

    func FfiMMAAudioCapturerStop(id: Int64, errorCode: CPointer<Int32>): Unit

    func FfiMMAAudioCapturerRelease(id: Int64, errorCode: CPointer<Int32>): Unit

    func FfiMMAAudioCapturerGetAudioCapturerChangeInfo(id: Int64, errorCode: CPointer<Int32>): CAudioCapturerChangeInfo

    func FfiMMAAudioCapturerGetInputDevices(id: Int64, errorCode: CPointer<Int32>): CArrDeviceDescriptor

    func FfiMMAAudioCapturerOn(id: Int64, callbackType: Int32, callbackId: Int64, errCode: CPointer<Int32>): Unit

    func FfiMMAAudioCapturerOnWithFrame(id: Int64, callbackType: Int32, callbackId: Int64, frame: Int64,
        errCode: CPointer<Int32>): Unit

    /**
     * AudioManager
     */
    func FfiMMAAudioManagerGetVolumeManager(id: Int64, errorCode: CPointer<Int32>): Int64

    func FfiMMACreateAudioManager(errorCode: CPointer<Int32>): Int64

    func FfiMMAAudioManagerGetRoutingManager(id: Int64, errorCode: CPointer<Int32>): Int64

    func FfiMMAAudioManagerGetStreamManager(id: Int64, errorCode: CPointer<Int32>): Int64

    func FfiMMAAudioManagerGetSessionManager(id: Int64, errorCode: CPointer<Int32>): Int64

    func FfiMMAAudioManagerGetAudioScene(id: Int64, errorCode: CPointer<Int32>): Int32

    /**
     * AudioStreamManager
     * ASM is the abbreviation of AudioStreamManager
     */
    func FfiMMAASMIsActive(id: Int64, volumeType: Int32, errorCode: CPointer<Int32>): Bool

    func FfiMMAASMGetAudioEffectInfoArray(id: Int64, usage: Int32, errorCode: CPointer<Int32>): CArrI32

    func FfiMMAASMOn(id: Int64, callbackType: Int32, callbackId: Int64, errCode: CPointer<Int32>): Unit

    /**
     * AudioRoutingManager
     * ARM is the abbreviation of AudioRoutingManager
     */
    func FfiMMAARMSetCommunicationDevice(id: Int64, deviceType: Int32, active: Bool, errorCode: CPointer<Int32>): Unit

    func FfiMMAARMIsCommunicationDeviceActive(id: Int64, deviceType: Int32, errorCode: CPointer<Int32>): Bool

    func FfiMMAARMGetDevices(id: Int64, deviceFlag: Int32, errorCode: CPointer<Int32>): CArrDeviceDescriptor

    func FfiMMAARMGetAvailableDevices(id: Int64, deviceUsage: UInt32, errorCode: CPointer<Int32>): CArrDeviceDescriptor

    func FfiMMAARMFreeCArrDeviceDescriptor(deviceDescriptors: CArrDeviceDescriptor): Unit

    func FfiMMAARMGetPreferredInputDeviceForCapturerInfo(id: Int64, capturerInfo: CAudioCapturerInfo,
        errorCode: CPointer<Int32>): CArrDeviceDescriptor

    func FfiMMAARMOn(id: Int64, callbackType: Int32, deviceUsage: UInt32, callbackId: Int64, errCode: CPointer<Int32>): Unit

    func FfiMMAARMOnWithFlags(id: Int64, callbackType: Int32, callbackId: Int64, flags: Int32, errCode: CPointer<Int32>): Unit

    func FfiMMAARMOnWithCapturerInfo(id: Int64, callbackType: Int32, callbackId: Int64, Info: CAudioCapturerInfo,
        errorCode: CPointer<Int32>): Unit

    func FfiMMAGetVolumeManager(id: Int64, errorCode: CPointer<Int32>): Int64
}
