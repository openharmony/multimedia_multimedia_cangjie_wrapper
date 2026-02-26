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

package ohos.multimedia.avsession

import std.time.DateTime
import ohos.multimedia.image.PixelMap
import ohos.labels.APILevel
import ohos.app.ability.ui_ability.{UIAbilityContext, getStageContext}
import std.collection.HashMap

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class AVMetadata {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var assetId: String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var title: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var artist: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var author: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueName: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueId: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueImage: ?ValueType

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var album: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var writer: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var composer: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var duration: ?Int64

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var mediaImage: ?ValueType

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var publishDate: ?DateTime

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var subtitle: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var description: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var lyric: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var previousAssetId: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var nextAssetId: ?String

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var filter: ?Array<ProtocolType>

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var drmSchemes: ?Array<String>

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var skipIntervals: ?SkipIntervals

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var displayTags: ?Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public init(
        assetId: String,
        title!: ?String = None,
        artist!: ?String = None,
        author!: ?String = None,
        avQueueName!: ?String = None,
        avQueueId!: ?String = None,
        avQueueImage!: ?ValueType = None,
        album!: ?String = None,
        writer!: ?String = None,
        composer!: ?String = None,
        duration!: ?Int64 = None,
        mediaImage!: ?ValueType = None,
        publishDate!: ?DateTime = None,
        subtitle!: ?String = None,
        description!: ?String = None,
        lyric!: ?String = None,
        previousAssetId!: ?String = None,
        nextAssetId!: ?String = None,
        filter!: ?Array<ProtocolType> = None,
        drmSchemes!: ?Array<String> = None,
        skipIntervals!: ?SkipIntervals = None,
        displayTags!: ?Int32 = None
    ) {
        super()
        this.assetId = assetId
        this.title = title
        this.artist = artist
        this.author = author
        this.avQueueName = avQueueName
        this.avQueueId = avQueueId
        this.avQueueImage = avQueueImage
        this.album = album
        this.writer = writer
        this.composer = composer
        this.duration = duration
        this.mediaImage = mediaImage
        this.publishDate = publishDate
        this.subtitle = subtitle
        this.description = description
        this.lyric = lyric
        this.previousAssetId = previousAssetId
        this.nextAssetId = nextAssetId
        this.filter = filter
        this.drmSchemes = drmSchemes
        this.skipIntervals = skipIntervals
        this.displayTags = displayTags
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum LoopMode {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeSequence
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeSingle
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeList
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeShuffle
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeCustom
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.AVCast"
]
public enum ProtocolType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeLocal
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeCastPlusStream
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.AVCast"
    ]
    TypeDlna
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum SkipIntervals {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds10
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds15
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Seconds30
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class DisplayTag {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public static const TAG_AUDIO_VIVID: Int32 = 1

    private init() {
        super()
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum AVSessionType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeAudio
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVideo
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVoiceCall
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    SessionTypeVideoCall
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public enum ValueType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Null(Option<Int32>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    StringValue(String)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Int32Value(Int32)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Int64Value(Int64)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Float64Value(Float64)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    BoolValue(Bool)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    Fd(Int32)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrString(Array<String>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayI32(Array<Int32>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayI64(Array<Int64>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayBool(Array<Bool>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayF64(Array<Float64>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    ArrayFd(Array<Int32>)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    LoopModeValue(LoopMode)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    PixelMapValue(PixelMap)
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    HashMapValue(HashMap<String, ValueType>)
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core",
    throwexception: true
]
public func createAVSession(context: UIAbilityContext, tag: String, avSessionType: AVSessionType): AVSession {
    return  AVSession(0, "", AVSessionType.SessionTypeAudio)
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class AVSession {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public let sessionId: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public let sessionType: AVSessionType

    protected init(id: Int64, sessionId: String, sessionType: AVSessionType) {
        super()
        this.sessionId = sessionId
        this.sessionType = sessionType
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core",
        throwexception: true
    ]
    public func activate(): Unit {
        return ()
    }
}