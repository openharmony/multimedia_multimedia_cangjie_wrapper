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

import ohos.labels.{APILevel}
import std.collection.ArrayList
import std.sync.Mutex
import std.collection.HashMap
import std.sync.AtomicBool
import ohos.ffi.{releaseFFIData, RemoteDataLite, CArrUI8, SUCCESS_CODE, cArr2cjArr, Callback1Param}
import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.business_exception.{BusinessException}
import ohos.base.{NativeOptionBool}

/**
 * Obtains an { AudioCapturer} instance.
 * @param { AudioCapturerOptions } options - Capturer configurations.
 * @returns { AudioCapturer } return the audio capturer instance.
 * @throws { BusinessException } 6800301 - Parameter verification failed, Permission denied, System error.
 * @throws { BusinessException } 6800101 - Mandatory parameters are left unspecified, Incorrect parameter types.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.MICROPHONE",
    syscap: "SystemCapability.Multimedia.Audio.Capturer",
    throwexception: true,
    workerthread: true
]
public func createAudioCapturer(options: AudioCapturerOptions): AudioCapturer {
    let cOptions = options.toCAudioCapturerOptions()
    var errorCode = SUCCESS_CODE
    let id: Int64
    id = unsafe { FfiMMACreateAudioCapturer(cOptions, inout errorCode) }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, "Create AudioCapturer failed")
    }
    AudioCapturer(id)
}

@C
protected struct CAudioCapturerInfo {
    protected CAudioCapturerInfo(let capturerFlags: Int32, let source: Int32) {}
}

/**
 * Describes audio capturer information.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioCapturerInfo {
    /**
     * Audio capturer flags.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var capturerFlags: Int32

    /**
     * Audio source type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var source: SourceType
    /**
     * Constructor used to initialize AudioCapturerInfo.
     * @param { SourceType } source - Audio source type.
     * @param { Int32 } capturerFlags - Audio capturer flags.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public init(source: SourceType, capturerFlags: Int32) {
        this.source = source
        this.capturerFlags = capturerFlags 
    }

    init(cInfo: CAudioCapturerInfo) {
        this.capturerFlags = cInfo.capturerFlags
        this.source = SourceType.parse(cInfo.source)
    }

    func toCAudioCapturerInfo(): CAudioCapturerInfo {
        CAudioCapturerInfo(this.capturerFlags, this.source.value)
    }
}

@C
struct CAudioCapturerOptions {
    CAudioCapturerOptions(
        let capturerInfo: CAudioCapturerInfo,
        let streamInfo: CAudioStreamInfo
    ) {}
}

/**
 * Describes audio capturer configuration options.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturerOptions {
    /**
     * Capturer information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public var capturerInfo: AudioCapturerInfo

    /**
     * Stream information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public var streamInfo: AudioStreamInfo

    /**
     * Constructor used to initialize AudioCapturerOptions.
     * @param { AudioCapturerInfo } captureInfo - Capturer information.
     * @param { AudioStreamInfo } streamInfo - Stream information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public init(captureInfo: AudioCapturerInfo, streamInfo: AudioStreamInfo) {
        this.capturerInfo = captureInfo
        this.streamInfo = streamInfo
    }

    func toCAudioCapturerOptions(): CAudioCapturerOptions {
        CAudioCapturerOptions(this.capturerInfo.toCAudioCapturerInfo(), this.streamInfo.toCAudioStreamInfo())
    }
}

@C
protected struct CAudioCapturerChangeInfo {
    protected CAudioCapturerChangeInfo(
        protected let capturerInfo: CAudioCapturerInfo,
        protected let deviceDescriptors: CArrDeviceDescriptor,
        protected let muted: NativeOptionBool,
        protected let streamId: Int32
    ) {}

    protected func free() {
        freeCArrDeviceDescriptor(this.deviceDescriptors)
    }
}

/**
 * Describes audio capturer change information.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturerChangeInfo {
    /**
     * Audio stream unique id.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let streamId: Int32

    /**
     * Audio capturer muted status.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let muted: ?Bool

    /**
     * Audio capturer information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let capturerInfo: AudioCapturerInfo

    /**
     * Audio input devices.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let deviceDescriptors: AudioDeviceDescriptors

    protected init(cInfo: CAudioCapturerChangeInfo) {
        this.capturerInfo = AudioCapturerInfo(cInfo.capturerInfo)
        unsafe {
            this.deviceDescriptors = cArr2cjArr<CAudioDeviceDescriptor, AudioDeviceDescriptor>(cInfo.deviceDescriptors.size,
                cInfo.deviceDescriptors.head, {i => AudioDeviceDescriptor(i)})
        }
        this.streamId = cInfo.streamId
        if (cInfo.muted.hasValue) {
            this.muted = cInfo.muted.value
        } else {
            this.muted = None
        }
    }
}

/**
 * Provides APIs for audio recording.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturer <: RemoteDataLite {
    init(instanceId: Int64) {
        super(instanceId)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Defines the current capture state.
     * @throws { BusinessException } 6800301 - Parameter verification failed, Permission denied, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public prop state: AudioState {
        get() {
            let val: Int32
            unsafe {
                var errorCode = SUCCESS_CODE
                val = FfiMMAAudioCapturerGetState(getID(), inout errorCode)
                checkRet(errorCode, "[AudioCapturer] state:")
            }
            AudioState.parse(val)
        }
    }

    /**
     * Starts capturing.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func start(): Unit {
        unsafe {
            var errorCode = SUCCESS_CODE
            FfiMMAAudioCapturerStart(getID(), inout errorCode)
            checkRet(errorCode, "[AudioCapturer] start:")
        }
    }

    /**
     * Stops capturing. 
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func stop(): Unit {
        unsafe {
            var errorCode = SUCCESS_CODE
            FfiMMAAudioCapturerStop(getID(), inout errorCode)
            checkRet(errorCode, "[AudioCapturer] stop:")
        }
    }

    /**
     * Releases the capturer. 
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func release(): Unit {
        unsafe {
            var errorCode = SUCCESS_CODE
            FfiMMAAudioCapturerRelease(getID(), inout errorCode)
            checkRet(errorCode, "[AudioCapturer] release:")
            releaseFFIData(getID())
        }
    }

    /**
     * Subscribes to period reached events. When the period of frame rendering reaches the value of frame parameter,
     * the callback is invoked.
     * @param { Int64 } frame - Period during which frame rendering is listened. The value must be greater than 0.
     * @param { Callback1Argument<Int64> } callback - Callback invoked when the event is triggered.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onPeriodReach(frame: Int64, callback: Callback1Argument<Int64>): Unit {
        let callbackType: AudioCapturerCallbackType = PeriodReach
        commonSubscribe1Arg(callbackType, callback, true, frame) {param: Int64 => param}
        return
    }

    /**
     * Unsubscribes from period reached events.
     * @param { ?CallbackObject } [ callback ] - Callback invoked when the event is triggered.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offPeriodReach(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = PeriodReach
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    /**
     * Subscribes to mark reached events. When the number of frames captured reaches the value of the frame parameter,
     * the callback is invoked.
     * @param { Int64 } frame - Number of frames to trigger the event. The value must be greater than 0.
     * @param { Callback1Argument<Int64> } callback - Callback invoked when the event is triggered.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onMarkReach(frame: Int64, callback: Callback1Argument<Int64>): Unit {
        let callbackType: AudioCapturerCallbackType = MarkReach
        commonSubscribe1Arg(callbackType, callback, true, frame) {param: Int64 => param}
        return
    }

    /**
     * Unsubscribes from the mark reached events.
     * @param { ?CallbackObject } [ callback ] - Callback invoked when the event is triggered.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offMarkReach(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = MarkReach
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    /**
     * Subscribes audio capturer info change event callback.
     * The event is triggered when input device change for this stream.
     * @param { Callback1Argument<AudioCapturerChangeInfo> } callback - Callback used to listen device change event.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onAudioCapturerChange(callback: Callback1Argument<AudioCapturerChangeInfo>): Unit {
        let callbackType: AudioCapturerCallbackType = AudioCapturerChange
        commonSubscribe1Arg(callbackType, callback, false, INVALID_FRAME) {
            info: CAudioCapturerChangeInfo => AudioCapturerChangeInfo(info)
        }
        return
    }

    /**
     * Unsubscribes to audio capturer change events.
     * @param { ?CallbackObject } [ callback ] - Callback invoked for the audio capturer change event.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offAudioCapturerChange(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = AudioCapturerChange
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    /**
     * Subscribes input device change event callback.
     * The event is triggered when input device change for this stream.
     * @param { Callback1Argument<AudioDeviceDescriptors> } callback - Callback used to listen device change event.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func onInputDeviceChange(callback: Callback1Argument<AudioDeviceDescriptors>): Unit {
        let callbackType: AudioCapturerCallbackType = InputDeviceChange
        commonSubscribe1Arg(callbackType, callback, false, INVALID_FRAME) {
            devices: CArrDeviceDescriptor => unsafe {
                cArr2cjArr<CAudioDeviceDescriptor, AudioDeviceDescriptor>(devices.size, devices.head,
                    {i => AudioDeviceDescriptor(i)})
            }
        }
        return
    }

     /**
     * Unsubscribes input device change event callback.
     * @param { ?CallbackObject } [ callback ] - Callback used in subscribe.
     */
    @!APILevel[ 
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offInputDeviceChange(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = InputDeviceChange
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    /**
     * Subscribes audio data callback.
     * The event is triggered when audio buffer is available for reading more data.
     * @param { Callback1Argument<Array<Byte>> } callback - Callback with the buffer to read.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onReadData(callback: Callback1Argument<Array<Byte>>): Unit {
        let callbackType: AudioCapturerCallbackType = ReadData
        commonSubscribe1Arg(callbackType, callback, false, INVALID_FRAME) {
            event: CArrUI8 => unsafe { cArr2cjArr<UInt8, Byte>(event.size, event.head, {i => i}) }
        }
        return
    }

    /**
     * Unsubscribes audio data callback.
     * @param { ?CallbackObject } [ callback ] - Callback used in subscribe.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offReadData(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = ReadData
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    /**
     * Listens for audio interrupt events. This method uses a callback to get interrupt events. The interrupt event is
     * triggered when audio recording is interrupted.
     * @param { Callback1Argument<InterruptEvent> } callback - Callback used to listen for interrupt callback.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Interrupt",
        throwexception: true
    ]
    public func onAudioInterrupt(callback: Callback1Argument<InterruptEvent>): Unit {
        let callbackType: AudioCapturerCallbackType = AudioInterrupt
        commonSubscribe1Arg(callbackType, callback, false, INVALID_FRAME) {
            event: CInterruptEvent => event.toInterruptEvent()
        }
        return
    }

    /**
     * UnSubscribes to audio interrupt events.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Interrupt"
    ]
    public func offAudioInterrupt(): Unit {
        let callbackType: AudioCapturerCallbackType = AudioInterrupt
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
        if (!callbackMap.contains(callbackType)) {
            return
        }
        callbackMap[callbackType].clear()
        return
    }

    /**
     * Subscribes audio state change event callback.
     * @param { Callback1Argument<AudioState> } callback - Callback invoked when state change.
     * @throws { BusinessException } 6800301 - Unsupported state, Audio focus request failed, System error.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onStateChange(callback: Callback1Argument<AudioState>): Unit {
        let callbackType: AudioCapturerCallbackType = StateChange
        commonSubscribe1Arg(callbackType, callback, false, INVALID_FRAME) {
            state: Int32 => AudioState.parse(state)
        }
        return
    }

    /**
     * Unsubscribes audio state change event callback.
     * @param { ?CallbackObject } [ callback ] - Callback invoked when state change.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offStateChange(callback!: ?CallbackObject = None): Unit {
        let callbackType: AudioCapturerCallbackType = StateChange
        AUDIO_LOG.debug("unsubscribe AudioCapturerCallback ${callbackType}")
        
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

    private func commonSubscribe1Arg<CT, T>(callbackType: AudioCapturerCallbackType, callback: CallbackObject,
        hasFrame: Bool, frame: Int64, ctor: (CT) -> T) where CT <: CType {
        AUDIO_LOG.debug("subscribe AudioCapturerCallback ${callbackType}")
        if (registerMap[callbackType].compareAndSwap(false, true)) {
            if (hasFrame) {
                registerWithFrame(callbackType, frame, argWrapper1<CT, T>(callbackType, ctor))
            } else {
                register(callbackType, argWrapper1<CT, T>(callbackType, ctor))
            }
        } else {
            if (findCallbackObject(callbackType, callback) >= 0) {
                AUDIO_LOG.info("The ${callbackType} AudioCapturerCallback is registered, no need to re-registered")
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

    private func register(callbackType: AudioCapturerCallbackType, id: Int64) {
        var errorCode = SUCCESS_CODE
        unsafe {
            FfiMMAAudioCapturerOn(getID(), callbackType.getValue(), id, inout errorCode)
        }
        checkRet(errorCode, "[AudioCapturer] register:")
    }

    private func registerWithFrame(callbackType: AudioCapturerCallbackType, frame: Int64, id: Int64) {
        var errorCode = SUCCESS_CODE
        unsafe {
            FfiMMAAudioCapturerOnWithFrame(getID(), callbackType.getValue(), id, frame, inout errorCode)
        }
        checkRet(errorCode, "[AudioCapturer] register:")
    }

    private func argWrapper1<CT, T>(callbackType: AudioCapturerCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
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

    private func findCallbackObject(callbackType: AudioCapturerCallbackType, callback: CallbackObject,
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
    private let callbackMap = HashMap<AudioCapturerCallbackType, ArrayList<CallbackObject>>()
    private let registerMap = HashMap<AudioCapturerCallbackType, AtomicBool>(
        [
            (AudioCapturerChange, AtomicBool(false)),
            (AudioInterrupt, AtomicBool(false)),
            (InputDeviceChange, AtomicBool(false)),
            (MarkReach, AtomicBool(false)),
            (PeriodReach, AtomicBool(false)),
            (ReadData, AtomicBool(false)),
            (StateChange, AtomicBool(false))
        ]
    )
}
