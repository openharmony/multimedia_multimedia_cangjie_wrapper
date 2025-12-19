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

import std.collection.ArrayList
import std.collection.HashMap
import ohos.ffi.{CArrI32, SUCCESS_CODE, cArr2cjArr, cjArr2CArr}
import ohos.hilog.{HilogChannel}
import ohos.labels.{APILevel}
import ohos.business_exception.{BusinessException, getUniversalErrorMsg}

const LOG_CORE: UInt32 = 3
const LOG_TAG_DOMAIN_ID_AUDIO: UInt32 = 0xD002B12
let AUDIO_LOG = HilogChannel(LOG_CORE, LOG_TAG_DOMAIN_ID_AUDIO, "multimedia audio")

/**
 * Array of AudioDeviceDescriptors.
 */
public type AudioDeviceDescriptors = Array<AudioDeviceDescriptor>

protected const ERR_INVALID_PARAM: Int32 = 6800101i32
protected const ERR_NO_MEMORY: Int32 = 6800102i32
protected const ERR_ILLEGAL_STATE: Int32 = 6800103i32
protected const ERR_UNSUPPORTED: Int32 = 6800104i32
protected const ERR_TIMEOUT: Int32 = 6800105i32
protected const ERR_STREAM_LIMIT: Int32 = 6800201i32
protected const ERR_SYSTEM: Int32 = 6800301i32
protected const INVALID_FRAME: Int64 = 0i64
let ERROR_CODE_MAP = HashMap<Int32, String>(
    [(ERR_INVALID_PARAM, "Invalid parameter."), (ERR_NO_MEMORY, "Memory allocation failure."),
        (ERR_ILLEGAL_STATE, "Unsupported state."), (ERR_UNSUPPORTED, "Unsupported parameter value."),
        (ERR_TIMEOUT, "Processing timeout."), (ERR_STREAM_LIMIT, "Too many audio streams."),
        (ERR_SYSTEM, "System error.")])

protected func checkRet(errCode: Int32, message: String): Unit {
    if (errCode != SUCCESS_CODE) {
        var msg: String
        if (let Some(v) <- getUniversalErrorMsg(errCode)) {
            msg = message + " " + v
            throw BusinessException(errCode, msg)
        } else if (ERROR_CODE_MAP.contains(errCode)) {
            msg = message + ERROR_CODE_MAP[errCode]
            throw BusinessException(errCode, msg)
        } else {
            msg = message + " Unknown error code: ${errCode}"
            throw BusinessException(errCode, msg)
        }
    }
}

@C
struct CAudioStreamInfo {
    CAudioStreamInfo(
        let channels: Int32,
        let encodingType: Int32,
        let sampleFormat: Int32,
        let samplingRate: Int32,
        let channelLayout: Int64
    ) {}
}

/**
 * Describes audio stream information.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public class AudioStreamInfo {
    /**
     * Audio channel layout.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var channelLayout: AudioChannelLayout

   /**
    * Audio channels.
    */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var channels: AudioChannel

    /**
    * Audio encoding type.
    */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var encodingType: AudioEncodingType

    /**
     * Audio sample format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var sampleFormat: AudioSampleFormat

    /**
     * Sampling rate.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public var samplingRate: AudioSamplingRate

    /**
     * Constructor used to initialize AudioStreamInfo.
     * @param { AudioChannel } channels - Audio channels.
     * @param { AudioEncodingType } encodingType - Audio encoding type.
     * @param { AudioSampleFormat } sampleFormat - Audio sample format. 
     * @param { AudioSamplingRate } samplingRate - Sampling rate.
     * @param { AudioChannelLayout } [ channelLayout ] - Audio channel layout. The default value is ChLayoutUnknown.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    public init(channels: AudioChannel, encodingType: AudioEncodingType, sampleFormat: AudioSampleFormat,
        samplingRate: AudioSamplingRate, channelLayout!: AudioChannelLayout = AudioChannelLayout.ChLayoutUnknown) {
        this.channels = channels
        this.encodingType = encodingType
        this.sampleFormat = sampleFormat
        this.samplingRate = samplingRate
        this.channelLayout = channelLayout
    }

    init(cInfo: CAudioStreamInfo) { 
        this.channels = AudioChannel.parse(cInfo.channels)
        this.encodingType = AudioEncodingType.parse(cInfo.encodingType)
        this.sampleFormat = AudioSampleFormat.parse(cInfo.sampleFormat)
        this.samplingRate = AudioSamplingRate.parse(cInfo.samplingRate)
        if (cInfo.channelLayout != 0) {
            this.channelLayout = AudioChannelLayout.parse(cInfo.channelLayout)
        } else {
            this.channelLayout = AudioChannelLayout.ChLayoutUnknown
        }
    }

    func toCAudioStreamInfo(): CAudioStreamInfo {
        CAudioStreamInfo(this.channels.value, this.encodingType.value, this.sampleFormat.value, this.samplingRate.value,
            this.channelLayout.value)
    }
}

@C
protected struct CAudioStreamDeviceChangeInfo {
    CAudioStreamDeviceChangeInfo(let changeReason: Int32, let devices: CArrDeviceDescriptor) {}

    func free() {
        freeCArrDeviceDescriptor(this.devices)
    }
}

@C
protected struct CArrDeviceDescriptor {
    protected CArrDeviceDescriptor(protected let head: CPointer<CAudioDeviceDescriptor>, protected let size: Int64) {}

    protected func toAudioDeviceDescriptors(): AudioDeviceDescriptors {
        var res = ArrayList<AudioDeviceDescriptor>()
        if (head.isNotNull()) {
            for (i in 0..size) {
                unsafe { res.add(AudioDeviceDescriptor(head.read(i))) }
            }
        }
        res.toArray()
    }
}

func freeCArrDeviceDescriptor(arr: CArrDeviceDescriptor) {
    unsafe {
        if (arr.head.isNotNull()) {
            for (i in 0..arr.size) {
                arr.head.read(i).free()
            }
            LibC.free<CAudioDeviceDescriptor>(arr.head)
        }
    }
}

@C
protected struct COptionArr {
    COptionArr(protected let arr: CArrI32, protected let hasValue: Bool) {}
}

@C
protected struct CAudioDeviceDescriptor {
    protected CAudioDeviceDescriptor(
        protected let address: CString,
        protected let channelCounts: CArrI32,
        protected let channelMasks: CArrI32,
        protected let deviceRole: Int32,
        protected let deviceType: Int32,
        protected let displayName: CString,
        protected let encodingTypes: COptionArr,
        protected let id: Int32,
        protected let name: CString,
        protected let sampleRates: CArrI32
    ) {}

    protected func free() {
        unsafe {
            LibC.free(address)
            LibC.free(displayName)
            LibC.free(name)
            LibC.free<Int32>(channelCounts.head)
            LibC.free<Int32>(channelMasks.head)
            LibC.free<Int32>(encodingTypes.arr.head)
            LibC.free<Int32>(sampleRates.head)
        }
    }
}

/**
 * Describes an audio device.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class AudioDeviceDescriptor {
    /**
     * Audio device address.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public let address: String

    /**
     * Audio device name.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public let name: String

    let _channelCounts: Array<Int32>
    let _channelMasks: Array<Int32>
    let _deviceRole: DeviceRole
    let _deviceType: DeviceType
    let _displayName: String
    let _encodingTypes: ?Array<AudioEncodingType>
    let _id: Int32
    let _sampleRates: Array<Int32>

    init(cDescriptor: CAudioDeviceDescriptor) {
        this.address = cDescriptor.address.toString()
        _deviceRole = DeviceRole.parse(cDescriptor.deviceRole)
        _deviceType = DeviceType.parse(cDescriptor.deviceType)
        _displayName = cDescriptor.displayName.toString()
        _id = cDescriptor.id
        this.name = cDescriptor.name.toString()
        unsafe {
            _channelCounts = cArr2cjArr<Int32, Int32>(cDescriptor.channelCounts.size, cDescriptor.channelCounts.head,
                {i => i})
            _channelMasks = cArr2cjArr<Int32, Int32>(cDescriptor.channelMasks.size, cDescriptor.channelMasks.head,
                {i => i})
            _sampleRates = cArr2cjArr<Int32, Int32>(
                cDescriptor.sampleRates.size,
                cDescriptor.sampleRates.head,
                {i => i}
            )
            if (cDescriptor.encodingTypes.hasValue && cDescriptor.encodingTypes.arr.head.isNotNull()) {
                _encodingTypes = cArr2cjArr<Int32, AudioEncodingType>(cDescriptor.encodingTypes.arr.size,
                    cDescriptor.encodingTypes.arr.head, {i => AudioEncodingType.parse(i)})
            } else {
                _encodingTypes = None
            }
        }
    }

    private func cjOptArr2cOptArr(): COptionArr {
        var hasVal: Bool = false
        var head: CPointer<Int32> = CPointer<Int32>()
        var size: Int64 = 0

        if (let Some(encodingType) <- _encodingTypes && encodingType.size > 0) {
            hasVal = true
            head = unsafe { cjArr2CArr<AudioEncodingType, Int32>(encodingType, {i => i.value}) }
            size = encodingType.size
        }
        return COptionArr(CArrI32(head, size), hasVal)
    }

    func toCAudioDeviceDescriptor(): CAudioDeviceDescriptor {
        var address = CString(CPointer())
        var channelCounts = CArrI32(CPointer<Int32>(), 0)
        var channelMasks = CArrI32(CPointer<Int32>(), 0)
        var displayName = CString(CPointer())
        var name = CString(CPointer())
        var sampleRates = CArrI32(CPointer<Int32>(), 0)
        var encodingTypes = COptionArr(CArrI32(CPointer<Int32>(), 0), false)

        try {
            address = unsafe { LibC.mallocCString(this.address) }
            channelCounts = CArrI32(unsafe { cjArr2CArr<Int32, Int32>(_channelCounts, {i => i}) }, _channelCounts.size)
            channelMasks = CArrI32(unsafe { cjArr2CArr<Int32, Int32>(_channelMasks, {i => i}) }, _channelMasks.size)
            displayName = unsafe { LibC.mallocCString(_displayName) }
            encodingTypes = cjOptArr2cOptArr()
            name = unsafe { LibC.mallocCString(this.name) }
            sampleRates = CArrI32(unsafe { cjArr2CArr<Int32, Int32>(_sampleRates, {i => i}) }, _sampleRates.size)
        } catch (e: Exception) {
            unsafe {
                LibC.free(address)
                LibC.free(displayName)
                LibC.free(name)
                LibC.free<Int32>(channelCounts.head)
                LibC.free<Int32>(channelMasks.head)
                LibC.free<Int32>(sampleRates.head)
                LibC.free<Int32>(encodingTypes.arr.head)
            }
            throw BusinessException(6800101, "invalid parameter.")
        }
        return CAudioDeviceDescriptor(
            address,
            channelCounts,
            channelMasks,
            _deviceRole.value,
            _deviceType.value,
            displayName,
            encodingTypes,
            _id,
            name,
            sampleRates
        )
    }
}


@C
struct CDeviceChangeAction {
    CDeviceChangeAction(let deviceDescriptors: CArrDeviceDescriptor, let changeType: Int32) {}

    func free() {
        freeCArrDeviceDescriptor(this.deviceDescriptors)
    }
}

/**
 * Describes the device change type and device information.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public class DeviceChangeAction {
    /**
     * Device information.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public var deviceDescriptors: AudioDeviceDescriptors

    /**
     * Device change type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    public var deviceChangeType: DeviceChangeType

    init(cInfo: CDeviceChangeAction) {
        unsafe {
            this.deviceDescriptors = cArr2cjArr<CAudioDeviceDescriptor, AudioDeviceDescriptor>(cInfo.deviceDescriptors.size,
                cInfo.deviceDescriptors.head, {i => AudioDeviceDescriptor(i)})
        }
        this.deviceChangeType = DeviceChangeType.parse(cInfo.changeType)
    }
}

@C
protected struct CInterruptEvent {
    protected CInterruptEvent(let eventType: Int32, let forceType: Int32, let hintType: Int32) {}

    protected func toInterruptEvent(): InterruptEvent {
        InterruptEvent(this)
    }
}

/**
 * Describes the interrupt event received by the app when playback is interrupted.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public class InterruptEvent {
    /**
     * Indicates whether the interruption has started or finished.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var eventType: InterruptType

    /**
     * Indicates whether the action is taken by system or to be taken by the app.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var forceType: InterruptForceType

    /**
     * Indicates the kind of action.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    public var hintType: InterruptHint

    init(cInfo: CInterruptEvent) {
        this.eventType = InterruptType.parse(cInfo.eventType)
        this.forceType = InterruptForceType.parse(cInfo.forceType)
        this.hintType = InterruptHint.parse(cInfo.hintType)
    }

    protected init(eventType: Int32, forceType: Int32, hintType: Int32) {
        this.eventType = InterruptType.parse(eventType)
        this.forceType = InterruptForceType.parse(forceType)
        this.hintType = InterruptHint.parse(hintType)
    }
}
