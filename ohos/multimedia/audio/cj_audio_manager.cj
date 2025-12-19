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

import ohos.ffi.{RemoteDataLite, Callback1Param, SUCCESS_CODE, releaseFFIData}
import ohos.labels.{APILevel}
import std.collection.ArrayList
import std.sync.Mutex
import std.collection.HashMap
import std.sync.AtomicBool
import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.business_exception.{BusinessException}

/**
 * Obtains an AudioManager instance.
 * @returns { AudioManager } return the AudioManager instance.
 * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core",
    throwexception: true
]
public func getAudioManager(): AudioManager {
    var errorCode = SUCCESS_CODE
    let id: Int64
    id = unsafe { FfiMMACreateAudioManager(inout errorCode) }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, "Create AudioManager failed")
    }
    AudioManager(id)
}

/**
 * Implements audio router management.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class AudioRoutingManager <: RemoteDataLite {
    init(instanceId: Int64) {
        super(instanceId)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtains the audio devices with a specific flag.
     * @param { DeviceFlag } deviceFlag - Audio device flag.
     * @returns { AudioDeviceDescriptors } return the device list.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func getDevices(deviceFlag: DeviceFlag): AudioDeviceDescriptors {
        let cDevices: CArrDeviceDescriptor
        var errorCode = SUCCESS_CODE
        unsafe { cDevices = FfiMMAARMGetDevices(getID(), deviceFlag.value, inout errorCode) }
        checkRet(errorCode, "[AudioRoutingManager] getDevices:")
        let inputDevices = cDevices.toAudioDeviceDescriptors()
        freeCArrDeviceDescriptor(cDevices)
        inputDevices
    }

    /**
     * Subscribes to available device change events. When a device is connected/disconnected, registered clients will receive
     * the callback.
     * @param { DeviceUsage } deviceUsage - Audio device usage.
     * @param { Callback1Argument<DeviceChangeAction> } callback - Callback used to obtain the device update details.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func onAvailableDeviceChange(deviceUsage: DeviceUsage,
        callback: Callback1Argument<DeviceChangeAction>): Unit {
        let callbackType: AudioRoutingManagerCallbackType = AvailableDeviceChange
        subscribe1Arg(callbackType, deviceUsage, callback) {
            infos: CDeviceChangeAction => DeviceChangeAction(infos)
        }
        return
    }

    private func register(callbackType: AudioRoutingManagerCallbackType, deviceUsage: DeviceUsage, id: Int64) {
        synchronized(mapMutex) {
            var errorCode = SUCCESS_CODE
            unsafe {
                FfiMMAARMOn(getID(), callbackType.getValue(), deviceUsage.value, id, inout errorCode)
            }
            checkRet(errorCode, "[AudioRoutingManagerCallbackType] register:")
        }
    }

    private func argWrapper1<CT, T>(callbackType: AudioRoutingManagerCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            let callbackList = synchronized(mapMutex) {
                callbackMap.get(callbackType) ?? ArrayList<CallbackObject>()
            }
            for (caller in callbackList) {
                (caller as Callback1Argument<T>)?.invoke(None, cjType)
            }
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    /**
     * UnSubscribes to  events.
     * @param { CallbackObject } [ callback ] - Callback invoked when the event is triggered.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offAvailableDeviceChange(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioRoutingManagerCallbackType = AvailableDeviceChange
        AUDIO_LOG.debug("unsubscribe AudioRoutingManagerCallbackType ${callbackType}")
        if (!callbackMap.contains(callbackType)) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject(callbackType, v, remove: true)
            return
        }
        callbackMap[callbackType].clear()
        return
    }

    private func subscribe1Arg<CT, T>(callbackType: AudioRoutingManagerCallbackType, deviceUsage: DeviceUsage,
        callback: CallbackObject, ctor: (CT) -> T) where CT <: CType {
        AUDIO_LOG.debug("subscribe AudioRoutingManagerCallbackType ${callbackType}")
        if (registerMap[callbackType].compareAndSwap(false, true)) {
            register(callbackType, deviceUsage, argWrapper1<CT, T>(callbackType, ctor))
        } else {
            if (findCallbackObject(callbackType, callback) >= 0) {
                AUDIO_LOG.info(
                    "The ${callbackType} AudioRoutingManagerCallbackType is registered, no need to re-registered")
                return
            }
        }
        synchronized(mapMutex) {
            callbackMap.addIfAbsent(callbackType, ArrayList<CallbackObject>())
            synchronized(listMutex) {
                callbackMap[callbackType].add(callback)
            }
        }
    }

    private func findCallbackObject(callbackType: AudioRoutingManagerCallbackType, callback: CallbackObject,
        remove!: Bool = false): Int64 {
        let callbackList = callbackMap.get(callbackType) ?? return -1
        for (idx in 0..callbackList.size) {
            if (refEq(callback, callbackList[idx])) {
                if (remove) {
                    callbackList.remove(at: idx)
                }
                return idx
            }
        }
        return -1
    }

    private let mapMutex = Mutex()
    private let listMutex = Mutex()
    private let callbackMap = HashMap<AudioRoutingManagerCallbackType, ArrayList<CallbackObject>>()
    private let registerMap = HashMap<AudioRoutingManagerCallbackType, AtomicBool>(
        [(DeviceChange, AtomicBool(false)), (AvailableDeviceChange, AtomicBool(false)),
            (PreferredInputDeviceChangeForCapturerInfo, AtomicBool(false)),
            (PreferrOutputDeviceChangeForRendererInfo, AtomicBool(false))])
}

/**
 * Implements audio volume and audio device management.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioManager <: RemoteDataLite {
    init(instanceId: Int64) {
        super(instanceId)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtains an AudioRoutingManager instance.
     * @returns { AudioRoutingManager } AudioRoutingManager instance.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func getRoutingManager(): AudioRoutingManager {
        var errorCode = SUCCESS_CODE
        let id: Int64
        id = unsafe { FfiMMAAudioManagerGetRoutingManager(getID(), inout errorCode) }
        if (errorCode != SUCCESS_CODE) {
            throw BusinessException(errorCode, "Create AudioRoutingManager failed")
        }
        AudioRoutingManager(id)
    }
}
