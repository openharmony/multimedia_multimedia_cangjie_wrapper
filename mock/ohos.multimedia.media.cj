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

package ohos.multimedia.media

import ohos.labels.APILevel
import ohos.multimedia.image.PixelMap
import std.collection.HashMap

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator",
    throwexception: true,
    workerthread: true
]
public func createAVImageGenerator(): AVImageGenerator {
    return AVImageGenerator()
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class AVImageGenerator {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
        throwexception: true
    ]
    public mut prop fdSrc: AVFileDescriptor {
        
        get() {
            return AVFileDescriptor(
                0,
                offset: 0,
                length: 0
            )
        }
        
        set(_) {}
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator",
        throwexception: true,
        workerthread: true
    ]
    public func fetchFrameByTime(timeUs: Int64, options: AVImageQueryOptions, param: PixelMapParams): PixelMap {
        return PixelMap()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator",
        throwexception: true,
        workerthread: true
    ]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class AVFileDescriptor {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var fd: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var offset: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var length: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public init(
        fd: Int32,
        offset!: Int64 = 0,
        length!: Int64 = -1
    ) {
        super()
        this.fd = 0
        this.offset = 0
        this.length = 0
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class PixelMapParams {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var width: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var height: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public init(width!: Int32 = -1, height!: Int32 = -1) {
        super()
        this.width = 0
        this.height = 0
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public enum AVImageQueryOptions {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryNextSync
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryPreviousSync
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosestSync
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosest
    | ...
}

extend AVImageQueryOptions <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public func toString(): String {
        return String()
    }
}

extend AVImageQueryOptions <: Equatable<AVImageQueryOptions> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public operator func ==(other: AVImageQueryOptions): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public operator func !=(other: AVImageQueryOptions): Bool {
        return true
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
    throwexception: true,
    workerthread: true
]
public func createAVMetadataExtractor(): AVMetadataExtractor {
    return AVMetadataExtractor(AVFileDescriptor(0))
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadataExtractor {
    init(fdSrc: AVFileDescriptor) {
        this.fdSrc = fdSrc
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var fdSrc: AVFileDescriptor

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
        throwexception: true,
        workerthread: true
    ]
    public func fetchMetadata(): AVMetadata {
        return AVMetadata()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor",
        throwexception: true,
        workerthread: true
    ]
    public func release(): Unit {
        return ()
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder",
    throwexception: true,
    workerthread: true
]
public func createAVRecorder(): AVRecorder {
    return AVRecorder()
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorder {
    @!APILevel[
        since: "24",
        permission: "ohos.permission.MICROPHONE",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func prepare(config: AVRecorderConfig): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func getInputSurface(): String {
        return String()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func start(): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func stop(): Unit {
        return ()
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum AudioSourceType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeDefault
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeMic
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceRecognition
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceCommunication
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceMessage
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeCamcorder
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadata {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var album: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var albumArtist: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var artist: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var author: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var dateTime: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var dateTimeFormat: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var composer: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var duration: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var genre: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hasAudio: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hasVideo: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var mimeType: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var trackCount: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var sampleRate: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var title: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoHeight: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoWidth: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoOrientation: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hdrType: HdrType
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var location: Location
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var customInfo: HashMap<String, String>

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public init(album!: String = "", albumArtist!: String = "", artist!: String = "",author!: String = "",
        dateTime!: String = "", dateTimeFormat!: String = "",composer!: String = "", duration!: String = "", 
        genre!: String = "", hasAudio!: String = "", hasVideo!: String = "", mimeType!: String = "", trackCount!: String = "",
        sampleRate!: String = "", title!: String = "", videoHeight!: String = "", videoWidth!: String = "",
        videoOrientation!: String = "", hdrType!: HdrType = HdrType.AvHdrTypeNone, location!: Location = Location(0.0, 0.0),
        customInfo!: HashMap<String, String> = HashMap<String, String>()
    ) {
        super()
        this.album = album
        this.albumArtist = albumArtist
        this.artist = artist 
        this.author = author
        this.dateTime = dateTime
        this.dateTimeFormat = dateTimeFormat
        this.composer = composer
        this.duration = duration
        this.genre = genre
        this.hasAudio = hasAudio
        this.hasVideo = hasVideo
        this.mimeType = mimeType
        this.trackCount = trackCount
        this.sampleRate = sampleRate
        this.title = title
        this.videoHeight = videoHeight
        this.videoWidth = videoWidth
        this.videoOrientation = videoOrientation
        this.hdrType = hdrType
        this.location = location
        this.customInfo = customInfo
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorderConfig {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var profile: AVRecorderProfile
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var url: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioSourceType: AudioSourceType
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoSourceType: VideoSourceType
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var fileGenerationMode: FileGenerationMode
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var metadata: AVMetadata
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var maxDuration: Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public init(profile: AVRecorderProfile, url: String, audioSourceType!: AudioSourceType = AudioSourceTypeDefault,
    videoSourceType!: VideoSourceType = VideoSourceTypeSurfaceYuv, fileGenerationMode!: FileGenerationMode = AppCreate,
    metadata!: AVMetadata = AVMetadata(), maxDuration!: Int32 = 0x7fffffff) {
        super()
        this.profile = profile
        this.url = url
        this.audioSourceType = audioSourceType
        this.videoSourceType = videoSourceType
        this.fileGenerationMode = fileGenerationMode
        this.metadata = metadata
        this.maxDuration = maxDuration
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorderProfile {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var fileFormat: ContainerFormatType
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioBitrate: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioChannels: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioCodec: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioSampleRate: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoBitrate: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoCodec: String
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameWidth: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameHeight: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameRate: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var isHdr: Bool
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var enableTemporalScale: Bool

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public init(fileFormat: ContainerFormatType, audioBitrate!: Int32 = 48000, audioChannels!: Int32 = 2,
        audioCodec!: String = "", audioSampleRate!: Int32 = 48000, videoBitrate!: Int32 = 48000,
        videoCodec!: String = "", videoFrameWidth!: Int32 = -1, videoFrameHeight!: Int32 = -1,
        videoFrameRate!: Int32 = 30, isHdr!: Bool = false, enableTemporalScale!: Bool = false) {
        super()
        this.fileFormat = fileFormat
        this.audioBitrate = audioBitrate
        this.audioChannels = audioChannels
        this.audioCodec = audioCodec
        this.audioSampleRate = audioSampleRate
        this.videoBitrate = videoBitrate
        this.videoCodec = videoCodec
        this.videoFrameWidth = videoFrameWidth
        this.videoFrameHeight = videoFrameHeight
        this.videoFrameRate = videoFrameRate
        this.isHdr = isHdr
        this.enableTemporalScale = enableTemporalScale
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class CodecMimeType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_H263: String = "video/h263"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_AVC: String = "video/avc"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_MPEG2: String = "video/mpeg2"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_MPEG4: String = "video/mp4v-es"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_VP8: String = "video/x-vnd.on2.vp8"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_AAC: String = "audio/mp4a-latm"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_VORBIS: String = "audio/vorbis"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_FLAC: String = "audio/flac"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_HEVC: String = "video/hevc"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_MP3: String = "audio/mpeg"
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_G711MU: String = "audio/g711mu"

    init() {
        super()
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public enum ContainerFormatType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMpeg4
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMpeg4A
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMp3
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftWav
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum FileGenerationMode {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AppCreate
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AutoCreateCameraScene
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum VideoSourceType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    VideoSourceTypeSurfaceYuv
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    VideoSourceTypeSurfaceEs
    | ...
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class Location {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var latitude: Float64
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var longitude: Float64

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public init(latitude: Float64, longitude: Float64) {
        super()
        this.latitude = latitude
        this.longitude = longitude
    }
}


@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public enum HdrType {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeNone
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeVivid
    | ...
}
