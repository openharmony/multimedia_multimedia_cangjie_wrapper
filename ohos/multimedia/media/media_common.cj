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

func throwIfNotSuccess(code: Int32, className: String, funcName: String): Unit {
    if (code != SUCCESS_CODE) {
        throw BusinessException(code, "${className} ${funcName} failed: ${getErrorMsg(code)}")
    }
}

/**
 * Media file descriptor. The caller needs to ensure that the fd is valid and
 * the offset and length are correct.
 *
 * @relation interface AVFileDescriptor
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.Core"
]
public class AVFileDescriptor {
    /**
     * The file descriptor of audio or video source from file system. The caller
     * is responsible to close the file descriptor.
     *
     * @relation fd: number
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var fd: Int32

    /**
     * The offset into the file where the data to be read, in bytes. By default,
     * the offset is zero.
     *
     * @relation offset?: number
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var offset: Int64

    /**
     * The length in bytes of the data to be read. By default, the length is the
     * rest of bytes in the file from the offset.
     *
     * @relation length?: number
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.Core"
    ]
    public var length: Int64

    /**
     * AVFileDescriptor constructor.
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
 *
 * @relation interface PixelMapParams
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public class PixelMapParams {
    /**
     * Width of the thumbnail. The value must be greater than 0 and less than or equal to the width of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     *
     * @relation width?: number
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var width: Int32

    /**
     * Height of the thumbnail. The value must be greater than 0 and less than or equal to the height of the original
     * video. Otherwise, the returned thumbnail will not be scaled.
     *
     * @relation height?: number
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    public var height: Int32

    /**
     * PixelMapParams constructor.
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
 * @relation enum AVImageQueryOptions
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
]
public enum AVImageQueryOptions {
    /**
     * The key frame at or next to the specified time is selected.
     *
     * @relation AV_IMAGE_QUERY_NEXT_SYNC = 0
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryNextSync
    |

    /**
     * The key frame at or prior to the specified time is selected.
     *
     * @relation AV_IMAGE_QUERY_PREVIOUS_SYNC = 1
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryPreviousSync
    |

    /**
     * The key frame closest to the specified time is selected.
     *
     * @relation AV_IMAGE_QUERY_CLOSEST_SYNC = 2
     */    
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"
    ]
    AvImageQueryClosestSync
    |

    /**
     * The frame (not necessarily a key frame) closest to the specified time is selected.
     *
     * @relation AV_IMAGE_QUERY_CLOSEST = 3
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
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}
