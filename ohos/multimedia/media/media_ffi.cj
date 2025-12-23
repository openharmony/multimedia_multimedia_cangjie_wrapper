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

import std.collection.HashMap

@C
protected struct CAVFileDescriptor {
    private var fd_: Int32
    private var offset_: Int64
    private var length_: Int64

    protected init(fileDescriptor: AVFileDescriptor) {
        this(fileDescriptor.fd, fileDescriptor.offset, fileDescriptor.length)
    }

    init(fd: Int32, offset: Int64, length: Int64) {
        fd_ = fd
        offset_ = offset
        length_ = length
    }

    protected func toCJObject(): AVFileDescriptor {
        AVFileDescriptor(fd_, offset: offset_, length: length_)
    }
}

@C
protected struct CPixelMapParams {
    protected var width_: Int32
    protected var height_: Int32

    protected init(param: PixelMapParams) {
        this(param.width, param.height)
    }

    protected init(width: Int32, height: Int32) {
        width_ = width
        height_ = height
    }
}

@C
protected struct CMetaLocation {
    protected var latitude: Float32
    protected var longitude: Float32

    protected init() {
        latitude = 0.0
        longitude = 0.0
    }

    protected func toCJObject(): Location {
        return Location(Float64(latitude), Float64(longitude))
    }
}

@C
protected struct CCustomInfo {
    protected var key: CPointer<CString>
    protected var value: CPointer<CString>
    protected var size: Int64

    protected init() {
        key = CPointer<CString>()
        value = CPointer<CString>()
        size = 0
    }

    protected func toCJObject(): HashMap<String, String> {
        return HashMap<String, String>(size) {
            index: Int64 => unsafe {
                let keyPtr = (key + index).read()
                let valuePtr = (value + index).read()
                (keyPtr.toString(), valuePtr.toString())
            }
        }
    }

    protected mut func free(): Unit {
        unsafe {
            for (index in 0..size) {
                LibC.free((key + index).read())
                LibC.free((value + index).read())
            }
            LibC.free(key)
            LibC.free(value)
            size = 0
        }
    }
}

@C
protected struct CMetaAVMetadata {
    protected var album: CString
    protected var albumArtist: CString
    protected var artist: CString
    protected var author: CString
    protected var dateTime: CString
    protected var dateTimeFormat: CString
    protected var composer: CString
    protected var duration: CString
    protected var genre: CString
    protected var hasAudio: CString
    protected var hasVideo: CString
    protected var mimeType: CString
    protected var trackCount: CString
    protected var sampleRate: CString
    protected var title: CString
    protected var videoHeight: CString
    protected var videoWidth: CString
    protected var videoOrientation: CString
    protected var hdrType: Int32
    protected var location: CMetaLocation
    protected var customInfo: CCustomInfo

    protected init() {
        album = CString(CPointer())
        albumArtist = CString(CPointer())
        artist = CString(CPointer())
        author = CString(CPointer())
        dateTime = CString(CPointer())
        dateTimeFormat = CString(CPointer())
        composer = CString(CPointer())
        duration = CString(CPointer())
        genre = CString(CPointer())
        hasAudio = CString(CPointer())
        hasVideo = CString(CPointer())
        mimeType = CString(CPointer())
        trackCount = CString(CPointer())
        sampleRate = CString(CPointer())
        title = CString(CPointer())
        videoHeight = CString(CPointer())
        videoWidth = CString(CPointer())
        videoOrientation = CString(CPointer())
        hdrType = 0
        location = CMetaLocation()
        customInfo = CCustomInfo()
    }

    func toOptionString(str: CString): String {
        if (str.isEmpty()) {
            ""
        } else {
            str.toString()
        }
    }

    protected func toCJObject(): AVMetadata {
        let album_ = toOptionString(album)
        let albumArtist_ = toOptionString(albumArtist)
        let artist_ = toOptionString(artist)
        let author_ = toOptionString(author)
        let dateTime_ = toOptionString(dateTime)
        let dateTimeFormat_ = toOptionString(dateTimeFormat)
        let composer_ = toOptionString(composer)
        let duration_ = toOptionString(duration)
        let genre_ = toOptionString(genre)
        let hasAudio_ = toOptionString(hasAudio)
        let hasVideo_ = toOptionString(hasVideo)
        let mimeType_ = toOptionString(mimeType)
        let trackCount_ = toOptionString(trackCount)
        let sampleRate_ = toOptionString(sampleRate)
        let title_ = toOptionString(title)
        let videoHeight_ = toOptionString(videoHeight)
        let videoWidth_ = toOptionString(videoWidth)
        let videoOrientation_ = toOptionString(videoOrientation)
        return AVMetadata(album: album_, albumArtist: albumArtist_, artist: artist_, author: author_,
            dateTime: dateTime_, dateTimeFormat: dateTimeFormat_, composer: composer_, duration: duration_,
            genre: genre_, hasAudio: hasAudio_, hasVideo: hasVideo_, mimeType: mimeType_, trackCount: trackCount_,
            sampleRate: sampleRate_, title: title_, videoHeight: videoHeight_, videoWidth: videoWidth_,
            videoOrientation: videoOrientation_, hdrType: HdrType.parse(hdrType), location: location.toCJObject(),
            customInfo: customInfo.toCJObject())
    }

    protected mut func free(): Unit {
        unsafe {
            LibC.free(album)
            LibC.free(albumArtist)
            LibC.free(artist)
            LibC.free(author)
            LibC.free(dateTime)
            LibC.free(dateTimeFormat)
            LibC.free(composer)
            LibC.free(duration)
            LibC.free(genre)
            LibC.free(hasAudio)
            LibC.free(hasVideo)
            LibC.free(mimeType)
            LibC.free(trackCount)
            LibC.free(sampleRate)
            LibC.free(title)
            LibC.free(videoHeight)
            LibC.free(videoWidth)
            LibC.free(videoOrientation)
        }
        customInfo.free()
    }
}

