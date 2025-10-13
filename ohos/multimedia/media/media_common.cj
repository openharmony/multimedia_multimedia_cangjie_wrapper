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

import ohos.ffi.*
import ohos.hilog.HilogChannel
import ohos.business_exception.*
import ohos.labels.APILevel

import std.deriving.Derive
import std.collection.*

const LOG_CORE: UInt32 = 3
const LOG_DOMAIN_PLAYER: UInt32 = 0xD002B2B
const MEDIA_MEMORY_ERROR: Int32 = 5400101
const MEDIA_OPERATION_ERROR: Int32 = 5400102
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

/**
 * Media file descriptor. The caller needs to ensure that the fd is valid and
 * the offset and length are correct.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class AVFileDescriptor {
    /**
     * The file descriptor of audio or video source from file system. The caller
     * is responsible to close the file descriptor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var fd: Int32

    /**
     * The offset into the file where the data to be read, in bytes. By default,
     * the offset is zero.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var offset: Int64

    /**
     * The length in bytes of the data to be read. By default, the length is the
     * rest of bytes in the file from the offset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var length: Int64

    /**
     * AVFileDescriptor constructor.
     */
    @!APILevel[
        22,
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
 * Defines the descriptor of an audio and video file, which is used in DataSource playback mode.
 * Use scenario: An application can create a playback instance and start playback before it finishes
 * downloading the audio and video resources.
 *
 * @relation interface AVFileDescriptor
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVPlayer"
]
public class AVDataSrcDescriptor {
    /**
     * Size of the file, -1 means the file size is unknown, in this case,
     * seek and setSpeed can't be executed, loop can't be set, and can't replay.
     *
     * @relation fileSize: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVPlayer"
    ]
    public var fileSize: Int64

    /**
     * Callback function implemented by users, which is used to fill data.
     * buffer - The buffer need to fill.
     * length - The stream length player want to get.
     * pos - The stream position player want get start, and is an optional parameter.
     * When fileSize set to -1, this parameter is not used.
     * Returns length of the data to be filled, Return -1 to indicate that the end of the stream is reached,
     * Return -2 to indicate that an unrecoverable error has been encountered.
     *
     * @relation callback: (buffer: ArrayBuffer, length: number, pos?: number) => number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVPlayer"
    ]
    public var callback: (Array<UInt8>, UInt32, ?Int64) -> Int32

    /**
     * AVDataSrcDescriptor constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVPlayer"
    ]
    public init(fileSize: Int64, callback: (Array<UInt8>, UInt32, ?Int64) -> Int32) {
        this.fileSize = fileSize
        this.callback = callback
    }
}

/**
 * Defines the format parameters of the video thumbnail to be obtained.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class PixelMapParams {
    /**
     * Width of the thumbnail. The value must be greater than 0 and less than or equal to the width of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var width: Int32

    /**
     * Height of the thumbnail. The value must be greater than 0 and less than or equal to the height of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var height: Int32

    /**
     * PixelMapParams constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public init(width!: Int32 = -1, height!: Int32 = -1) {
        this.width = width
        this.height = height
    }
}

/**
 * Defines the audio and video metadata. Parameters that are not declared as read-only in
 * AVRecorderConfig can be used as input parameters for recording of AVRecorder.
 *
 * @relation interface AVMetadata
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
]
public class AVMetadata {
    /**
     * Title of the album. This parameter is read-only in the current version.
     *
     * @relation album?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let album: ?String
    /**
     * Artist of the album. This parameter is read-only in the current version.
     *
     * @relation albumArtist?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let albumArtist: ?String
    /**
     * Artist of the media asset. This parameter is read-only in the current version.
     *
     * @relation artist?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let artist: ?String
    /**
     * Author of the media asset. This parameter is read-only in the current version.
     *
     * @relation author?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let author: ?String
    /**
     * Time when the media asset is created. This parameter is read-only in the current version.
     *
     * @relation dateTime?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let dateTime: ?String
    /**
     * Time when the media asset is created. The value is in the YYYY-MM-DD HH:mm:ss format.
     * This parameter is read-only in the current version.
     *
     * @relation dateTimeFormat?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let dateTimeFormat: ?String
    /**
     * Composer of the media asset. This parameter is read-only in the current version.
     *
     * @relation composer?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let composer: ?String
    /**
     * Duration of the media asset. This parameter is read-only in the current version.
     *
     * @relation duration?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let duration: ?String
    /**
     * Type or genre of the media asset.
     *
     * @relation genre?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let genre: ?String
    /**
     * Whether the media asset contains audio. This parameter is read-only in the current version.
     *
     * @relation hasAudio?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let hasAudio: ?String
    /**
     * Whether the media asset contains a video. This parameter is read-only in the current version.
     *
     * @relation hasVideo?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let hasVideo: ?String
    /**
     * MIME type of the media asset. This parameter is read-only in the current version.
     * Some example mime types include: "video/mp4", "audio/mp4", "audio/amr-wb".
     *
     * @relation mimeType?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let mimeType: ?String
    /**
     * Number of tracks of the media asset. This parameter is read-only in the current version.
     *
     * @relation trackCount?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let trackCount: ?String
    /**
     * Audio sampling rate, in Hz. This parameter is read-only in the current version.
     *
     * @relation sampleRate?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let sampleRate: ?String
    /**
     * Title of the media asset. This parameter is read-only in the current version.
     *
     * @relation title?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let title: ?String
    /**
     * Video height, in px. This parameter is read-only in the current version.
     *
     * @relation videoHeight?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let videoHeight: ?String
    /**
     * Video width, in px. This parameter is read-only in the current version.
     *
     * @relation videoWidth?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let videoWidth: ?String
    /**
     * Video rotation direction, in degrees.
     *
     * @relation videoOrientation?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let videoOrientation: ?String
    /**
     * HDR type of the media asset. This parameter is read-only in the current version.
     *
     * @relation hdrType?: HdrType
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let hdrType: ?HdrType
    /**
     * Geographical location of the media asset.
     *
     * @relation location?: Location
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let location: ?Location
    /**
     * Custom key-value mappings obtained from **moov.meta.list**.
     *
     * @relation customInfo?: Record<string, string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor"
    ]
    public let customInfo: HashMap<String, String>

    protected init(
        album!: ?String = None,
        albumArtist!: ?String = None,
        artist!: ?String = None,
        author!: ?String = None,
        dateTime!: ?String = None,
        dateTimeFormat!: ?String = None,
        composer!: ?String = None,
        duration!: ?String = None,
        genre!: ?String = None,
        hasAudio!: ?String = None,
        hasVideo!: ?String = None,
        mimeType!: ?String = None,
        trackCount!: ?String = None,
        sampleRate!: ?String = None,
        title!: ?String = None,
        videoHeight!: ?String = None,
        videoWidth!: ?String = None,
        videoOrientation!: ?String = None,
        hdrType!: ?HdrType = None,
        location!: ?Location = None,
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
 * Enumerates options about the HDR Type of the video.
 *
 * @relation enum HdrType
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public enum HdrType {
    /**
     * This option is used to mark none HDR type.
     *
     * @relation AV_HDR_TYPE_NONE = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeNone
    |
    /**
     * This option is used to mark HDR Vivid type.
     *
     * @relation AV_HDR_TYPE_VIVID = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    AvHdrTypeVivid
    | ...

    protected func get(): Int32 {
        match (this) {
            case AvHdrTypeNone => 0
            case AvHdrTypeVivid => 1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: Int32): HdrType {
        match (val) {
            case 0 => AvHdrTypeNone
            case 1 => AvHdrTypeVivid
            case _ => throw IllegalArgumentException("Unknown value")
        }
    }

    static func tryParse(val: ?Int32): ?HdrType {
        match (val) {
            case Some(v) => parse(v)
            case None => None
        }
    }
}

/**
 * Provides the geographical location definitions for media resources.
 *
 * @relation interface Location
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class Location {
    /**
     * Latitude.
     *
     * @relation latitude: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public let latitude: Float64
    /**
     * Longitude.
     *
     * @relation longitude: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public let longitude: Float64

    protected Location(latitude: Float64, longitude: Float64) {
        this.latitude = latitude
        this.longitude = longitude
    }
}

/**
 * Enumerates the relationship between the video frame and the time at which the video thumbnail is obtained.
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public enum AVImageQueryOptions {
    /**
     * The key frame at or next to the specified time is selected.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryNextSync
    |

    /**
     * The key frame at or prior to the specified time is selected.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryPreviousSync
    |

    /**
     * The key frame closest to the specified time is selected.
     */    
    @!APILevel[
        22,
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosestSync
    |

    /**
     * The frame (not necessarily a key frame) closest to the specified time is selected.
     */
    @!APILevel[
        22,
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
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}
