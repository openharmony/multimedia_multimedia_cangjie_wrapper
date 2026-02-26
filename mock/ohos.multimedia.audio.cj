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

package ohos.multimedia.audio

import ohos.labels.{APILevel}
import std.collection.ArrayList
import std.collection.HashMap
import std.sync.AtomicBool
import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.base.NativeOptionBool
import ohos.ffi.{CArrUI8, SUCCESS_CODE, cArr2cjArr, Callback1Param}

@!APILevel[
    since: "24",
    permission: "ohos.permission.MICROPHONE",
    syscap: "SystemCapability.Multimedia.Audio.Capturer",
    throwexception: true,
    workerthread: true
]
public func createAudioCapturer(options: AudioCapturerOptions): AudioCapturer {
    AudioCapturer()
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioCapturerInfo {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var capturerFlags: Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var source: SourceType

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public init(source: SourceType, capturerFlags: Int32) {
        super()
        this.source = source
        this.capturerFlags = capturerFlags 
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturerOptions {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public var capturerInfo: AudioCapturerInfo

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public var streamInfo: AudioStreamInfo

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public init(captureInfo: AudioCapturerInfo, streamInfo: AudioStreamInfo) {
        super()
        this.capturerInfo = captureInfo
        this.streamInfo = streamInfo
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturerChangeInfo {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let streamId: Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let muted: ?Bool

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let capturerInfo: AudioCapturerInfo

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public let deviceDescriptors: AudioDeviceDescriptors

    init(streamId: Int32, muted: ?Bool, capturerInfo: AudioCapturerInfo, deviceDescriptors: AudioDeviceDescriptors) {
        super()
        this.streamId = streamId
        this.muted = muted
        this.capturerInfo = capturerInfo
        this.deviceDescriptors = deviceDescriptors
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Capturer"
]
public class AudioCapturer {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public prop state: AudioState {
        get() {
            AudioState.StateInvalid
        }
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func start(): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func stop(): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true,
        workerthread: true
    ]
    public func release(): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onPeriodReach(frame: Int64, callback: Callback1Argument<Int64>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offPeriodReach(callback!: ?CallbackObject = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onMarkReach(frame: Int64, callback: Callback1Argument<Int64>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offMarkReach(callback!: ?CallbackObject = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onAudioCapturerChange(callback: Callback1Argument<AudioCapturerChangeInfo>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offAudioCapturerChange(callback!: ?CallbackObject = None): Unit {
        return
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func onInputDeviceChange(callback: Callback1Argument<AudioDeviceDescriptors>): Unit {
        return ()
    }

    @!APILevel[ 
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offInputDeviceChange(callback!: ?CallbackObject = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onReadData(callback: Callback1Argument<Array<Byte>>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offReadData(callback!: ?CallbackObject = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Interrupt",
        throwexception: true
    ]
    public func onAudioInterrupt(callback: Callback1Argument<InterruptEvent>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Interrupt"
    ]
    public func offAudioInterrupt(): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer",
        throwexception: true
    ]
    public func onStateChange(callback: Callback1Argument<AudioState>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Capturer"
    ]
    public func offStateChange(callback!: ?CallbackObject = None): Unit {
        return ()
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioChannel {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel3
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel4
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel5
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel6
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel7
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel8
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel9
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel10
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel12
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel14
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel16
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioChannelLayout {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutUnknown
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutMono
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutStereo
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutStereoDownmix
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point0
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutSurround
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout4Point0
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutQuad
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutQuadSide
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point0Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1AcnN3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1AcnSn3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1Fuma
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout4Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point0
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point0Back
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point1Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point0Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Back
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point0
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutHexagonal
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point1Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point0Front
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1Back
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1Front
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point0
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point0Front
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutOctagonal
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Wide
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1WideBack
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2AcnN3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2AcnSn3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2Fuma
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Point4
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Point4
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout10Point2
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout9Point1Point4
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout9Point1Point6
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutHexadecagonal
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3AcnN3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3AcnSn3D
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3Fuma
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioEncodingType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    EncodingTypeInvalid
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    EncodingTypeRaw
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioSampleFormat {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatInvalid
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatU8
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS16Le
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS24Le
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS32Le
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatF32Le
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioSamplingRate {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate8000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate11025
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate12000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate16000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate22050
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate24000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate32000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate44100
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate48000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate64000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate88200
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate96000
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate176400
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate192000
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioState {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateInvalid
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateNew
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StatePrepared
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateRunning
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateStopped
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateReleased
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StatePaused
    | ...
}

extend AudioState <: Equatable<AudioState> {
    @!APILevel[since: "24", syscap: "SystemCapability.Multimedia.Audio.Core"]
    public operator func ==(other: AudioState): Bool {
        return true
    }

    @!APILevel[since: "24", syscap: "SystemCapability.Multimedia.Audio.Core"]
    public operator func !=(other: AudioState): Bool {
        return true
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public enum DeviceFlag {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    OutputDevicesFlag
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    InputDevicesFlag
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllDevicesFlag
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum SourceType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeInvalid
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeMic
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceRecognition
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceCommunication
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceMessage
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeCamcorder
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public enum DeviceUsage {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    MediaOutputDevices
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    MediaInputDevices
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllMediaDevices
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    CallOutputDevices
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    CallInputDevices
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllCallDevices
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public enum DeviceChangeType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    Connect
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    Disconnect
    | ...
}

extend DeviceChangeType <: ToString {
    @!APILevel[since: "24", syscap: "SystemCapability.Multimedia.Audio.Device"]
    public func toString(): String {
        return String()
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptTypeBegin
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptTypeEnd
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptForceType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptForce
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptShare
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptHint {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintNone
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintResume
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintPause
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintStop
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintDuck
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintUnduck
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core",
    throwexception: true
]
public func getAudioManager(): AudioManager {
    return AudioManager()
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class AudioRoutingManager {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func getDevices(deviceFlag: DeviceFlag): AudioDeviceDescriptors {
        return Array<AudioDeviceDescriptor>()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func onAvailableDeviceChange(deviceUsage: DeviceUsage,
        callback: Callback1Argument<DeviceChangeAction>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public func offAvailableDeviceChange(callback!: ?CallbackObject = None): Unit {
        return ()
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioManager {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device",
        throwexception: true
    ]
    public func getRoutingManager(): AudioRoutingManager {
        return AudioRoutingManager()
    }
}

public type AudioDeviceDescriptors = Array<AudioDeviceDescriptor>

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioStreamInfo {
    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var channelLayout: AudioChannelLayout

   
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var channels: AudioChannel

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var encodingType: AudioEncodingType

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var sampleFormat: AudioSampleFormat

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var samplingRate: AudioSamplingRate

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public init(channels: AudioChannel, encodingType: AudioEncodingType, sampleFormat: AudioSampleFormat,
        samplingRate: AudioSamplingRate, channelLayout!: AudioChannelLayout = AudioChannelLayout.ChLayoutUnknown) {
        super()
        this.channels = channels
        this.encodingType = encodingType
        this.sampleFormat = sampleFormat
        this.samplingRate = samplingRate
        this.channelLayout = channelLayout
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class AudioDeviceDescriptor {
    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public let address: String

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public let name: String

    init(address: String, name: String) {
        super()
        this.address = address
        this.name = name
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class DeviceChangeAction {
    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public var deviceDescriptors: AudioDeviceDescriptors

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public var deviceChangeType: DeviceChangeType

    init(deviceDescriptors: AudioDeviceDescriptors, deviceChangeType: DeviceChangeType) {
        super()
        this.deviceDescriptors = deviceDescriptors
        this.deviceChangeType = deviceChangeType
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public class InterruptEvent {

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var eventType: InterruptType

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var forceType: InterruptForceType

    
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var hintType: InterruptHint

    init(eventType: InterruptType, forceType: InterruptForceType, hintType: InterruptHint) {
        super()
        this.eventType = eventType
        this.forceType = forceType
        this.hintType = hintType
    }
}