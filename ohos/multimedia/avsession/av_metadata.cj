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

import std.time.DateTime
import ohos.labels.{APILevel, Hide}
import ohos.multimedia.image.PixelMap

/**
 * The metadata of the current media.Used to set the properties of the current media file
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class AVMetadata {
    /**
     * Unique ID used to represent this media.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var assetId: String

    /**
     * The title of this media, for display in media center.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var title: ?String

    /**
     * The artist of this media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var artist: ?String

    /**
     * The author of this media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var author: ?String

    /**
     * The name of play list which current media belongs to
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueName: ?String

    /**
     * The id of play list which current media belongs to, it should be an unique identifier in the application.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueId: ?String

    /**
     * The artwork of play list as a PixelMap or an uri formatted String,
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var avQueueImage: ?ValueType

    /**
     * The album of this media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var album: ?String

    /**
     * The writer of this media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var writer: ?String

    /**
     * The composer of this media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var composer: ?String

    /**
     * The duration of this media, used to automatically calculate playback position
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var duration: ?Int64

    /**
     * The image of the media as a PixelMap or an uri formatted String,
     * used to display in media center.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var mediaImage: ?ValueType

    @!Hide[isChecked: true]
    protected let bundleIcon: ?PixelMap = None

    /**
     * The publishDate of the media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var publishDate: ?DateTime

    /**
     * The subtitle of the media, used for display
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var subtitle: ?String

    /**
     * The discription of the media, used for display
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var description: ?String

    /**
     * The lyric of the media, it should be in standard lyric format
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var lyric: ?String

    @!Hide[isChecked: true]
    protected let singleLyricText: ?String = None

    /**
     * The previous playable media id.
     * Used to tell the controller if there is a previous playable media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var previousAssetId: ?String

    /**
     * The next playable media id.
     * Used to tell the controller if there is a next playable media
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var nextAssetId: ?String

    /**
     * The protocols supported by this session, if not set, the default is ProtocolType.TypeCastPlusStream.
     * See ProtocolType
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var filter: ?Array<ProtocolType>

    /**
     * The drm schemes supported by this session which are represented by uuid.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var drmSchemes: ?Array<String>

    /**
     * The supported skipIntervals when doing fast forward and rewind operation.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var skipIntervals: ?SkipIntervals

    /**
     * The display tags supported by application to be displayed on media center
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public var displayTags: ?Int32

    /**
     * Create AVMetadata instance.
     *
     * @param { String } assetId - Unique ID used to represent this media.
     * @param { ?String } [ title ] - The title of this media, for display in media center.
     * @param { ?String } [ artist ] - The artist of this media
     * @param { ?String } [ author ] - The author of this media
     * @param { ?String } [ avQueueName ] - The name of play list which current media belongs to
     * @param { ?String } [ avQueueId ] - The id of play list which current media belongs to
     * @param { ?ValueType } [ avQueueImage ] - The artwork of play list as a PixelMap or an uri formatted String
     * @param { ?String } [ album ] - The album of this media
     * @param { ?String } [ writer ] - The writer of this media
     * @param { ?String } [ composer ] - The composer of this media
     * @param { ?Int64 } [ duration ] - The duration of this media
     * @param { ?ValueType } [ mediaImage ] - The image of the media as a PixelMap or an uri formatted String
     * @param { ?DateTime } [ publishDate ] - The publishDate of the media
     * @param { ?String } [ subtitle ] - The subtitle of the media, used for display
     * @param { ?String } [ description ] - The discription of the media, used for display
     * @param { ?String } [ lyric ] - The lyric of the media, it should be in standard lyric format
     * @param { ?String } [ previousAssetId ] - The previous playable media id.
     * @param { ?String } [ nextAssetId ] - The next playable media id.
     * @param { ?Array<ProtocolType> } [ filter ] - The protocols supported by this session.
     * @param { ?Array<String> } [ drmSchemes ] - The drm schemes supported by this session which are represented by uuid.
     * @param { ?SkipIntervals } [ skipIntervals ] - The supported skipIntervals
     * when doing fast forward and rewind operation.
     * @param { ?Int32 } [ displayTags ] - The display tags supported by application to be displayed on media center
     */
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
