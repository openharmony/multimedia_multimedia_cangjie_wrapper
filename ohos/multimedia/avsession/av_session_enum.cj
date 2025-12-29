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

package ohos.multimedia.avsession

import std.collection.HashMap
import ohos.labels.{APILevel, Hide}
import ohos.business_exception.BusinessException
import ohos.multimedia.image.PixelMap

/**
 * Loop Play Mode Definition
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum LoopMode {
    /**
     * The default mode is sequential playback
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeSequence
    |
    /**
     * Single loop mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeSingle
    |
    /**
     * List loop mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeList
    |
    /**
     * Shuffle playback mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeShuffle
    |
    /**
     * Custom playback mode supported by application
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeCustom
    | ...

    protected prop value: Int32 {
        get() {
            match (this) {
                case LoopModeSequence => 0
                case LoopModeSingle => 1
                case LoopModeList => 2
                case LoopModeShuffle => 3
                case LoopModeCustom => 4
                case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
            }
        }
    }

    protected static func parse(value: Int32): LoopMode {
        match (value) {
            case 0 => LoopModeSequence
            case 1 => LoopModeSingle
            case 2 => LoopModeList
            case 3 => LoopModeShuffle
            case 4 => LoopModeCustom
            case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
        }
    }
}

/**
 * Define different protocol capability
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.AVCast"
]
public enum ProtocolType {
    /**
     * The default cast type "local", media can be routed on the same device,
     * including internal speakers or audio jack on the device itself, A2DP devices.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeLocal
    |
    @!Hide[isChecked: true]
    TypeCastPlusMirror
    |
    /**
     * The Cast+ Stream indicating the media is presenting on a different device
     * the application need get an AVCastController to control remote playback.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeCastPlusStream
    |
    /**
     * The DLNA type indicates the device supports DLNA protocol,
     * the application needs to get an AVCastController to control remote playback.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeDlna
    |
    @!Hide[isChecked: true]
    TypeCastPlusAudio
    | ...

    protected prop value: Int32 {
        get() {
            match (this) {
                case TypeLocal => 0
                case TypeCastPlusStream => 2
                case TypeDlna => 4
                case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
            }
        }
    }

    protected static func parse(value: Int32): ProtocolType {
        match (value) {
            case 0 => TypeLocal
            case 2 => TypeCastPlusStream
            case 4 => TypeDlna
            case _ =>
                LOGGER.debug("Unsupported ProtocolType value:" + value.toString())
                throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
        }
    }
}

/**
 * Supported skip intervals definition
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum SkipIntervals {
    /**
     * 10 seconds
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds10
    |
    /**
     * 15 seconds
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds15
    |
    /**
     * 30 seconds
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds30
    | ...

    protected prop value: Int32 {
        get() {
            match (this) {
                case Seconds10 => 10
                case Seconds15 => 15
                case Seconds30 => 30
                case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
            }
        }
    }

    protected static func parse(value: Int32): SkipIntervals {
        match (value) {
            case 10 => Seconds10
            case 15 => Seconds15
            case 30 => Seconds30
            case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
        }
    }
}

/**
 * The pre-defined display tag by system.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class DisplayTag {
    /**
     * Indicate the AUDIO VIVID property of current media resource.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public static const TAG_AUDIO_VIVID: Int32 = 1

    private init() {}
}

/**
 * Session types
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum AVSessionType {
    /**
     * Session type for audio
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeAudio
    |
    /**
     * Session type for video
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVideo
    |
    /**
     * Session type for voice_call
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVoiceCall
    |
    /**
     * Session type for video_call
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVideoCall
    | ...

    protected prop value: Int32 {
        get() {
            match (this) {
                case SessionTypeAudio => 0
                case SessionTypeVideo => 1
                case SessionTypeVoiceCall => 2
                case SessionTypeVideoCall => 3
                case _ => throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
            }
        }
    }
}

/**
 * Enumerates avsession ValueType types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum ValueType {
    /**
     * Null type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Null(Option<Int32>)
    |
    /**
     * String type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    StringValue(String)
    |
    /**
     * Int32 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Int32Value(Int32)
    |
    /**
     * Int64 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Int64Value(Int64)
    |
    /**
     * Float64 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Float64Value(Float64)
    |
    /**
     * Bool type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    BoolValue(Bool)
    |
    /**
     * Fd type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Fd(Int32)
    |
    /**
     * Array of string type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrString(Array<String>)
    |
    /**
     * Array of Int32 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayI32(Array<Int32>)
    |
    /**
     * Array of Int64 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayI64(Array<Int64>)
    |
    /**
     * Array of Bool type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayBool(Array<Bool>)
    |
    /**
     * Array of Float64 type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayF64(Array<Float64>)
    |
    /**
     * Array of Fd type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayFd(Array<Int32>)
    |
    /**
     * LoopMode type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeValue(LoopMode)
    |
    /**
     * PixelMap type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    PixelMapValue(PixelMap)
    |
    /**
     * HashMap type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    HashMapValue(HashMap<String, ValueType>)
    | ...
}
