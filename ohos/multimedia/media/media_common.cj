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

package ohos.multimedia.media

import ohos.ffi.SUCCESS_CODE
import ohos.hilog.HilogChannel
import ohos.business_exception.{BusinessException, getUniversalErrorMsg}
import ohos.labels.{APILevel, Hide}

import std.deriving.Derive
import std.collection.HashMap

const LOG_CORE: UInt32 = 3
const LOG_DOMAIN_PLAYER: UInt32 = 0xD002B2B
const MEDIA_MEMORY_ERROR: Int32 = 5400101
const MSERR_INVALID_VAL: Int32 = 331350038
const MSERR_UNKNOWN: Int32 = 331350528
let AV_PLAYER_LOG = HilogChannel(LOG_CORE, LOG_DOMAIN_PLAYER, "CJ-AVPlayer")

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (5400101, "No memory."),
        (5400102, "Operation not allowed."),
        (5400103, "I/O error."),
        (5400104, "Operation timeout."),
        (5400105, "Service died."),
        (5400106, "Unsupported format."),
        (5400107, "Audio interrupted."),
        (5411001, "Can not find host."),
        (5411002, "Connection time out."),
        (5411003, "NetWork abnormal."),
        (5411004, "NetWork unavailable."),
        (5411005, "No permission."),
        (5411006, "Network access denied."),
        (5411007, "Cannot find available network resources."),
        (5411008, "SSL client cert needed."),
        (5411009, "SSL connection failed."),
        (5411010, "SSL server cert needed."),
        (5411011, "Unsupportted request.")
    ]
)

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error"
    }
}

func codeTransform(code: Int32): Int32 {
    const MEDIA_OPERATION_ERROR: Int32 = 5400102
    match (code) {
        case MSERR_UNKNOWN => MEDIA_MEMORY_ERROR
        case MSERR_INVALID_VAL => MEDIA_OPERATION_ERROR
        case _ => code
    }
}

func throwIfNotSuccess(code: Int32, className: String, funcName: String): Unit {
    if (code != SUCCESS_CODE) {
        let errorCode = codeTransform(code)
        AV_PLAYER_LOG.error("${className} ${funcName} failed: ${getErrorMsg(errorCode)}")
        throw BusinessException(errorCode, "${getErrorMsg(errorCode)}")
    }
}

@!Hide
internal enum PixelFormat {
    @!Hide
    Rgb565
    |
    @!Hide
    Rgba8888
    |
    @!Hide
    Rgb888
    | ...
}

/**
 * Media file descriptor. The caller needs to ensure that the fd is valid and
 * the offset and length are correct.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class AVFileDescriptor {
    /**
     * The file descriptor of audio or video source from file system. The caller
     * is responsible to close the file descriptor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var fd: Int32

    /**
     * The offset into the file where the data to be read, in bytes. By default,
     * the offset is zero.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var offset: Int64

    /**
     * The length in bytes of the data to be read. By default, the length is the
     * rest of bytes in the file from the offset.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var length: Int64

    /**
     * AVFileDescriptor constructor.
     * @param { Int32 } fd - The file descriptor of audio or video source from file system.
     * @param { Int64 } [offset] - The offset into the file where the data to be read, in bytes. By default,
     * the offset is zero.
     * @param { Int64 } [length] - The length in bytes of the data to be read. By default, the length is the
     * rest of bytes in the file from the offset.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public init(
        fd: Int32,
        offset!: Int64 = 0,
        length!: Int64 = -1
    ) {
        this.fd = fd
        this.offset = offset
        this.length = length
    }
}

/**
 * Defines the format parameters of the video thumbnail to be obtained.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class PixelMapParams {
    /**
     * Width of the thumbnail. The value must be greater than 0 and less than or equal to the width of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var width: Int32

    /**
     * Height of the thumbnail. The value must be greater than 0 and less than or equal to the height of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var height: Int32

    @!Hide
    internal var colorFormat: PixelFormat = PixelFormat.Rgba8888

    @!Hide
    internal var autoFlip: Bool = false

    /**
     * PixelMapParams constructor.
     * @param { Int32 } [width] - Width of the thumbnail.The default value is -1.
     * @param { Int32 } [height] - Height of the thumbnail.The default value is -1.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public init(width!: Int32 = -1, height!: Int32 = -1) {
        this.width = width
        this.height = height
    }
}

/**
 * Enumerates the relationship between the video frame and the time at which the video thumbnail is obtained.
 *
 * The time passed in for obtaining the thumbnail may be different from the time of the video frame for which
 * the thumbnail is actually obtained. Therefore, you need to specify their relationship.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public enum AVImageQueryOptions {
    /**
     * The key frame at or next to the specified time is selected.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryNextSync
    |

    /**
     * The key frame at or prior to the specified time is selected.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryPreviousSync
    |

    /**
     * The key frame closest to the specified time is selected.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosestSync
    |

    /**
     * The frame (not necessarily a key frame) closest to the specified time is selected.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosest
    | ...

    func getValue(): Int32 {
        match (this) {
            case AvImageQueryNextSync => 0
            case AvImageQueryPreviousSync => 1
            case AvImageQueryClosestSync => 2
            case AvImageQueryClosest => 3
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the audio source types for video recording.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum AudioSourceType {
    /**
     * Default audio source type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeDefault
    |
    /**
     * Microphone audio input source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeMic
    |
    /**
     * Audio source in speech recognition scenarios.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceRecognition
    |
    /**
     * Voice communication source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceCommunication
    |
    /**
     * Voice message source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeVoiceMessage
    |
    /**
     * Audio source in camera recording scenarios.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AudioSourceTypeCamcorder
    | ...

    protected func get(): Int32 {
        match (this) {
            case AudioSourceTypeDefault => 0
            case AudioSourceTypeMic => 1
            case AudioSourceTypeVoiceRecognition => 2
            case AudioSourceTypeVoiceCommunication => 7
            case AudioSourceTypeVoiceMessage => 10
            case AudioSourceTypeCamcorder => 13
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func parse(val: Int32): AudioSourceType {
        match (val) {
            case 0 => AudioSourceTypeDefault
            case 1 => AudioSourceTypeMic
            case 2 => AudioSourceTypeVoiceRecognition
            case 7 => AudioSourceTypeVoiceCommunication
            case 10 => AudioSourceTypeVoiceMessage
            case 13 => AudioSourceTypeCamcorder
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func tryParse(val: ?Int32): ?AudioSourceType {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}

/**
 * The metadata of the current media.Used to set the properties of the current media file.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadata {
    /**
     * The metadata to retrieve the information about the album title
     * of the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var album: String
    /**
     * The metadata to retrieve the information about the performer or
     * artist associated with the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var albumArtist: String
    /**
     * The metadata to retrieve the information about the artist of
     * the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var artist: String
    /**
     * The metadata to retrieve the information about the author of
     * the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var author: String
    /**
     * The metadata to retrieve the information about the created time of
     * the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var dateTime: String
    /**
     * The metadata to retrieve the information about the created or modified time
     * with the specific date format of the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var dateTimeFormat: String
    /**
     * The metadata to retrieve the information about the composer of
     * the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var composer: String
    /**
     * The metadata to retrieve the playback duration of the media source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var duration: String
    /**
     * The metadata to retrieve the content type or genre of the data
     * source.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var genre: String
    /**
     * If this value exists the media contains audio content.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hasAudio: String
    /**
     * If this value exists the media contains video content.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hasVideo: String
    /**
     * The metadata to retrieve the mime type of the media source. Some
     * example mime types include: "video/mp4", "audio/mp4", "audio/amr-wb".
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var mimeType: String
    /**
     * The metadata to retrieve the number of tracks, such as audio, video,
     * text, in the media source, such as a mp4 or 3gpp file.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var trackCount: String
    /**
     * It is the audio sample rate, if available.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var sampleRate: String
    /**
     * The metadata to retrieve the media source title.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var title: String
    /**
     * Description of the media asset.
     */
    @!Hide
    internal var description: ?String  = Option<String>.None
    /**
     * If the media contains video, this key retrieves its height.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoHeight: String
    /**
     * If the media contains video, this key retrieves its width.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoWidth: String
    /**
     * The metadata to retrieve the information about the video
     * orientation.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var videoOrientation: String
    /**
     * HDR type of the media asset.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var hdrType: HdrType
    /**
     * Geographical location of the media asset.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var location: Location
    /**
     * Custom key-value mappings obtained from moov.meta.list.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public var customInfo: HashMap<String, String>

    /**
     * AVMetadata Constructor.
     *
     * @param { String } [ album ] - The metadata to retrieve the information about the album title of the media source.
     * @param { String } [ albumArtist ] - The metadata to retrieve the information about the performer or
     * artist associated with the media source.
     * @param { String } [ artist ] - The metadata to retrieve the information about the artist of the media source.
     * @param { String } [ author ] - The metadata to retrieve the information about the author of the media source.
     * @param { String } [ dateTime ] - The metadata to retrieve the information about the created time of the media source.
     * @param { String } [ dateTimeFormat ] - The metadata to retrieve the information about the created or modified time
     * with the specific date format of the media source.
     * @param { String } [ composer ] - The metadata to retrieve the information about the composer of the media source.
     * @param { String } [ duration ] - The metadata to retrieve the playback duration of the media source.
     * @param { String } [ genre ] - The metadata to retrieve the content type or genre of the data source.
     * @param { String } [ hasAudio ] - If this value exists the media contains audio content.
     * @param { String } [ hasVideo ] - If this value exists the media contains video content.
     * @param { String } [ mimeType ] - The metadata to retrieve the mime type of the media source. Some
     * example mime types include: "video/mp4", "audio/mp4", "audio/amr-wb".
     * @param { String } [ trackCount ] - The metadata to retrieve the number of tracks, such as audio, video,
     * text, in the media source, such as a mp4 or 3gpp file.
     * @param { String } [ sampleRate ] - It is the audio sample rate, if available.
     * @param { String } [ title ] - The metadata to retrieve the media source title.
     * @param { String } [ videoHeight ] - If the media contains video, this key retrieves its height.
     * @param { String } [ videoWidth ] - If the media contains video, this key retrieves its width.
     * @param { String } [ videoOrientation ] - The metadata to retrieve the information about the video orientation.
     * @param { HdrType } [ hdrType ] - HDR type of the media asset.
     * @param { Location } [ location ] - Geographical location of the media asset.
     * @param { HashMap<String, String> } [ customInfo ] - Custom key-value mappings obtained from moov.meta.list.
     */
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

/**
 * Provides the media recorder configuration definitions.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorderConfig {
    /**
     * Recording profile. This parameter is mandatory.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var profile: AVRecorderProfile
    /**
     * File output uri, support a kind of uri now.
     * format like: "fd://" + "context".
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var url: String
    /**
     * Type of the audio source to record. This parameter is mandatory for audio recording.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioSourceType: AudioSourceType
    /**
     * Type of the video source to record. This parameter is mandatory for video recording.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoSourceType: VideoSourceType
    /**
     * Mode for creating the file, which is used together with on('photoAssetAvailable').
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var fileGenerationMode: FileGenerationMode
    /**
     * Metadata. For details, see AVMetadata.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var metadata: AVMetadata
    /**
     * Maximum recording duration, in seconds. The value range is [1, 2^31-1]. If an invalid value is provided,
     * it is reset to the maximum allowed duration. Once the recording reaches the specified duration,
     * it stops automatically and notifies via the **stateChange** callback that the recording has stopped:
     * AVRecorderState = 'stopped', StateChangeReason = BACKGROUND.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var maxDuration: Int32

    /**
     * AVRecorderConfig Constructor.
     *
     * @param { AVRecorderProfile } profile - Recording profile. This parameter is mandatory.
     * @param { String } url - File output uri, support a kind of uri now. format like: "fd://" + "context".
     * @param { AudioSourceType } [ audioSourceType ] - Type of the audio source to record. This parameter is mandatory for audio recording.
     * @param { VideoSourceType } [ videoSourceType ] - Type of the video source to record. This parameter is mandatory for video recording.
     * @param { FileGenerationMode } [ fileGenerationMode ] - Mode for creating the file.
     * @param { AVMetadata } [ metadata ] - Metadata. For details, see AVMetadata.
     * @param { Int32 } [ maxDuration ] - Maximum recording duration, in seconds. The value range is [1, 2^31-1].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public init(profile: AVRecorderProfile, url: String, audioSourceType!: AudioSourceType = AudioSourceTypeDefault,
    videoSourceType!: VideoSourceType = VideoSourceTypeSurfaceYuv, fileGenerationMode!: FileGenerationMode = AppCreate,
    metadata!: AVMetadata = AVMetadata(), maxDuration!: Int32 = 0x7fffffff) {
        this.profile = profile
        this.url = url
        this.audioSourceType = audioSourceType
        this.videoSourceType = videoSourceType
        this.fileGenerationMode = fileGenerationMode
        this.metadata = metadata
        this.maxDuration = maxDuration
    }
}

/**
 * Describes the audio and video recording profile.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorderProfile {
    /**
     * Indicates the output file format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var fileFormat: ContainerFormatType
    /**
     * Indicates the audio bitrate.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioBitrate: Int32
    /**
     * Indicates the number of audio channels.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioChannels: Int32
    /**
     * Audio encoding format. This parameter is mandatory for audio recording. Currently, AUDIO_AAC, AUDIO_MP3,
     * AUDIO_G711MU, AUDIO_AMR_NB, and AUDIO_AMR_WB are supported.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioCodec: String
    /**
     * Indicates the audio sampling rate.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var audioSampleRate: Int32
    /**
     * Video encoding bit rate. This parameter is mandatory for video recording. The value range is [10000 - 100000000].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoBitrate: Int32
    /**
     * Video encoding format. This parameter is mandatory for video recording. Currently, VIDEO_AVC is supported.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoCodec: String
    /**
     * Width of a video frame. This parameter is mandatory for video recording. The value range is [176 - 4096].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameWidth: Int32
    /**
     * Height of a video frame. This parameter is mandatory for video recording. The value range is [144 - 4096].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameHeight: Int32
    /**
     * Video frame rate. This parameter is mandatory for video recording. The value range is [1 - 60].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var videoFrameRate: Int32
    /**
     * HDR encoding. This parameter is optional for video recording. The default value is false, and there is no
     * requirement on the encoding format. When isHdr is set to true, the encoding format must be video/hevc.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var isHdr: Bool
    /**
     * Whether temporal layered encoding is supported. This parameter is optional for video recording. The default value
     * is false. If this parameter is set to true, some frames in the video output streams can be skipped
     * without being encoded.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public var enableTemporalScale: Bool

    /**
     * AVRecorderProfile Constructor.
     *
     * @param { ContainerFormatType } fileFormat - Indicates the output file format.
     * @param { Int32 } [ audioBitrate ] - Indicates the audio bitrate.
     * @param { Int32 } [ audioChannels ] - Indicates the number of audio channels.
     * @param { String } [ audioCodec ] - Audio encoding format. This parameter is mandatory for audio recording. Currently, AUDIO_AAC, AUDIO_MP3,
     * AUDIO_G711MU, AUDIO_AMR_NB, and AUDIO_AMR_WB are supported.
     * @param { Int32 } [ audioSampleRate ] - Indicates the audio sampling rate.
     * @param { Int32 } [ videoBitrate ] - Video encoding bit rate. This parameter is mandatory for video recording. The value range is [10000 - 100000000].
     * @param { String } [ videoCodec ] - Video encoding format. This parameter is mandatory for video recording. Currently, VIDEO_AVC is supported.
     * @param { Int32 } [ videoFrameWidth ] - Width of a video frame. This parameter is mandatory for video recording. The value range is [176 - 4096].
     * @param { Int32 } [ videoFrameHeight ] - Height of a video frame. This parameter is mandatory for video recording. The value range is [144 - 4096].
     * @param { Int32 } [ videoFrameRate ] - Video frame rate. This parameter is mandatory for video recording. The value range is [1 - 60].
     * @param { Bool } [ isHdr ] - HDR encoding. This parameter is optional for video recording. The default value is false, and there is no
     * requirement on the encoding format. When isHdr is set to true, the encoding format must be video/hevc.
     * @param { Bool } [ enableTemporalScale ] - Whether temporal layered encoding is supported. This parameter is optional for video recording. The default value
     * is false. If this parameter is set to true, some frames in the video output streams can be skipped without being encoded.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    public init(fileFormat: ContainerFormatType, audioBitrate!: Int32 = 48000, audioChannels!: Int32 = 2,
        audioCodec!: String = "", audioSampleRate!: Int32 = 48000, videoBitrate!: Int32 = 48000,
        videoCodec!: String = "", videoFrameWidth!: Int32 = -1, videoFrameHeight!: Int32 = -1,
        videoFrameRate!: Int32 = 30, isHdr!: Bool = false, enableTemporalScale!: Bool = false) {
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

/**
 * Class of Codec MIME types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class CodecMimeType {
    /**
     * H.263 codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_H263: String = "video/h263"
    /**
     * H.264 codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_AVC: String = "video/avc"
    /**
     * MPEG2 codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_MPEG2: String = "video/mpeg2"
    /**
     * MPEG4 codec MIME type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_MPEG4: String = "video/mp4v-es"
    /**
     * VP8 codec MIME type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_VP8: String = "video/x-vnd.on2.vp8"
    /**
     * AAC codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_AAC: String = "audio/mp4a-latm"
    /**
     * vorbis codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_VORBIS: String = "audio/vorbis"
    /**
     * flac codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_FLAC: String = "audio/flac"
    /**
     * H.265 codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const VIDEO_HEVC: String = "video/hevc"
    /**
     * mp3 codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_MP3: String = "audio/mpeg"
    /**
     * G711-mulaw codec MIME type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public static const AUDIO_G711MU: String = "audio/g711mu"

    init() {}
}

/**
 * Enumerates container format type(The abbreviation for 'container format type' is CFT).
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public enum ContainerFormatType {
    /**
     * A video container format type mp4.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMpeg4
    |
    /**
     * A audio container format type m4a.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMpeg4A
    |
    /**
     * A audio container format type mp3.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftMp3
    |
    /**
     * A audio container format type wav.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    CftWav
    | ...

    protected func get(): String {
        match (this) {
            case CftMpeg4 => "mp4"
            case CftMpeg4A => "m4a"
            case CftMp3 => "mp3"
            case CftWav => "wav"
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func parse(val: String): ContainerFormatType {
        match (val) {
            case "mp4" => CftMpeg4
            case "m4a" => CftMpeg4A
            case "mp3" => CftMp3
            case "wav" => CftWav
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func tryParse(val: ?String): ?ContainerFormatType {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}

/**
 * Enumerates the modes for creating media files.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum FileGenerationMode {
    /**
     * The application creates a media file in the sandbox.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AppCreate
    |
    /**
     * The system creates a media file. Currently, this mode takes effect only in camera recording scenarios.
     * The URL set by the application is ignored.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    AutoCreateCameraScene
    | ...

    protected func get(): Int32 {
        match (this) {
            case AppCreate => 0
            case AutoCreateCameraScene => 1
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func parse(val: Int32): FileGenerationMode {
        match (val) {
            case 0 => AppCreate
            case 1 => AutoCreateCameraScene
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func tryParse(val: ?Int32): ?FileGenerationMode {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}

/**
 * Enumerates the video source types for video recording.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public enum VideoSourceType {
    /**
     * The input surface carries raw data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    VideoSourceTypeSurfaceYuv
    |
    /**
     * The input surface carries ES data.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder"
    ]
    VideoSourceTypeSurfaceEs
    | ...

    protected func get(): Int32 {
        match (this) {
            case VideoSourceTypeSurfaceYuv => 0
            case VideoSourceTypeSurfaceEs => 1
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func parse(val: Int32): VideoSourceType {
        match (val) {
            case 0 => VideoSourceTypeSurfaceYuv
            case 1 => VideoSourceTypeSurfaceEs
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func tryParse(val: ?Int32): ?VideoSourceType {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}

/**
 * Provides the geographical location definitions for media resources.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class Location {
    /**
     * Latitude of the geographical location. The value range is [-90, 90].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var latitude: Float64
    /**
     * Longitude of the geographical location. The value range is [-180, 180].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var longitude: Float64

    /**
     * Location Constructor.
     *
     * @param { Float64 } latitude - Latitude of the geographical location. The value range is [-90, 90].
     * @param { Float64 } longitude - Longitude of the geographical location. The value range is [-180, 180].
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public init(latitude: Float64, longitude: Float64) {
        this.latitude = latitude
        this.longitude =longitude
    }
}

/**
 * Enumerates options about the HDR Type of the video.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public enum HdrType {
    /**
     * This option is used to mark none HDR type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeNone
    |
    /**
     * This option is used to mark HDR Vivid type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeVivid
    | ...

    protected func get(): Int32 {
        match (this) {
            case AvHdrTypeNone => 0
            case AvHdrTypeVivid => 1
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func parse(val: Int32): HdrType {
        match (val) {
            case 0 => AvHdrTypeNone
            case 1 => AvHdrTypeVivid
            case _ => throw BusinessException(5400106, "The type is not supported.")
        }
    }

    static func tryParse(val: ?Int32): ?HdrType {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}
