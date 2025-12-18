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

import ohos.ffi.{safeMalloc, SUCCESS_CODE, RemoteDataLite, releaseFFIData}
import ohos.hilog.HilogChannel
import ohos.business_exception.BusinessException
import ohos.labels.APILevel
import std.collection.HashMap

const LOG_DOMAIN_AVRECODER: UInt32 = 0xD002B2C
const COMMON_ERROR: Int32 = -1
const OPERATION_NOT_ALLOW: Int32 = 5400102
const INVALID_RECORDER_VALUE: Int32 = -1
let AV_RECODER_LOG = HilogChannel(LOG_CORE, LOG_DOMAIN_AVRECODER, "AVRecorderLog")

foreign {
    func FfiOHOSMediaAVRecorderCreateAVRecorder(code: CPointer<Int32>): Int64

    func FfiOHOSMediaAVRecorderPrepare(id: Int64, config: CAVRecorderConfig): Int32

    func FfiOHOSMediaAVRecorderGetInputSurface(id: Int64, code: CPointer<Int32>): CString

    func FfiOHOSMediaAVRecorderStart(id: Int64): Int32

    func FfiOHOSMediaAVRecorderPause(id: Int64): Int32

    func FfiOHOSMediaAVRecorderResume(id: Int64): Int32

    func FfiOHOSMediaAVRecorderStop(id: Int64): Int32

    func FfiOHOSMediaAVRecorderReset(id: Int64): Int32

    func FfiOHOSMediaAVRecorderRelease(id: Int64): Int32

    func FfiOHOSMediaAVRecorderGetAVRecorderConfig(id: Int64, code: CPointer<Int32>): CAVRecorderConfig

    func FfiOHOSMediaAVRecorderGetAudioCapturerMaxAmplitude(id: Int64, code: CPointer<Int32>): Int32

    func FfiOHOSMediaAVRecorderUpdateRotation(id: Int64, rotation: Int32, code: CPointer<Int32>): Unit

    func FfiOHOSMediaAVRecorderOn(id: Int64, `type`: Int32, callback: Int64): Int32

    func FfiOHOSMediaAVRecorderOff(id: Int64, `type`: Int32): Int32

    func FfiOHOSMediaAVRecorderGetState(id: Int64, errorCode: CPointer<Int32>): CString
}


@C
struct CErrorInfo {
    CErrorInfo(
        let errorCode: Int32,
        let errorMsg: CString
    ) {}

    func toObject(): BusinessException {
        return BusinessException(errorCode, errorMsg.toString())
    }
}

@C
struct CHashStrPair {
    var key: CString = CString(CPointer())
    var value: CString = CString(CPointer())

    init(key: ?String, value: ?String) {
        unsafe {
            try {
                this.key = LibC.mallocCString(key ?? "")
                this.value = LibC.mallocCString(value ?? "")
            } catch (e: Exception) {
                LibC.free(this.key)
                LibC.free(this.value)
                throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
            }
        }
    }

    func free(): Unit {
        if (key.isNull()) {
            return
        }
        unsafe {
            LibC.free(key)
            LibC.free(value)
        }
    }
}

@C
struct CHashStrArr {
    var headers: CPointer<CHashStrPair> = CPointer<CHashStrPair>()
    var size: Int64 = 0

    init() {}

    init(headers: HashMap<String, String>) {
        if (headers.size == 0) {
            return
        }

        let res: CPointer<CHashStrPair> = safeMalloc<CHashStrPair>(count: headers.size)
        var index = 0
        try {
            for ((k, v) in headers) {
                unsafe { res.write(index, CHashStrPair(k, v)) }
                index++
            }
        } catch (e: Exception) {
            for (i in 0..index) {
                unsafe { res.read(i).free() }
            }
            unsafe { LibC.free(res) }
            throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
        }
        this.headers = res
        this.size = headers.size
    }

    func free(): Unit {
        if (headers.isNull()) {
            return
        }
        for (i in 0..size) {
            unsafe { headers.read(i).free() }
        }
        unsafe { LibC.free(headers) }
    }

    func toHashMap(): HashMap<String, String> {
        if (headers.isNull()) {
            return HashMap<String, String>()
        }

        HashMap<String, String>(size) {
            i: Int64 =>
            let elem: CHashStrPair = unsafe { headers.read(i) }
            (elem.key.toString(), elem.value.toString())
        }
    }

    func toHashMapOption(): HashMap<String, String> {
        toHashMap()
    }
}

@C
struct CAVRecorderProfile {
    var fileFormat: CString = CString(CPointer()) // ContainerFormatType
    var audioBitrate: Int32 = INVALID_RECORDER_VALUE
    var audioChannels: Int32 = INVALID_RECORDER_VALUE
    var audioCodec: CString = CString(CPointer()) // CodecMimeType
    var audioSampleRate: Int32 = INVALID_RECORDER_VALUE
    var videoBitrate: Int32 = INVALID_RECORDER_VALUE
    var videoCodec: CString = CString(CPointer()) // CodecMimeType
    var videoFrameWidth: Int32 = INVALID_RECORDER_VALUE
    var videoFrameHeight: Int32 = INVALID_RECORDER_VALUE
    var videoFrameRate: Int32 = INVALID_RECORDER_VALUE
    var isHdr: Bool = false
    var enableTemporalScale: Bool = false

    init() {}

    init(recorderProfile: AVRecorderProfile) {
        unsafe {
            try {
                this.fileFormat = LibC.mallocCString(recorderProfile.fileFormat.get())
                this.audioBitrate = matchIntParam(recorderProfile.audioBitrate)
                this.audioChannels = matchIntParam(recorderProfile.audioChannels)
                this.audioCodec = LibC.mallocCString(recorderProfile.audioCodec)
                this.audioSampleRate = matchIntParam(recorderProfile.audioSampleRate)
                this.videoBitrate = matchIntParam(recorderProfile.videoBitrate)
                this.videoCodec = LibC.mallocCString(recorderProfile.videoCodec)
                this.videoFrameWidth = matchIntParam(recorderProfile.videoFrameWidth)
                this.videoFrameHeight = matchIntParam(recorderProfile.videoFrameHeight)
                this.videoFrameRate = matchIntParam(recorderProfile.videoFrameRate)
                this.isHdr = recorderProfile.isHdr
                this.enableTemporalScale = recorderProfile.enableTemporalScale
            } catch (e: Exception) {
                LibC.free(fileFormat)
                LibC.free(audioCodec)
                LibC.free(videoCodec)
                throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
            }
        }
    }

    func matchIntParam(ele: Option<Int32>): Int32 {
        match (ele) {
            case Some(v) => v
            case None => INVALID_RECORDER_VALUE
        }
    }

    func toAVRecorderProfile(): AVRecorderProfile {
        let cjFileFormat = if (!fileFormat.isNull()) {
            ContainerFormatType.parse(fileFormat.toString())
        } else {
            throw IllegalArgumentException("null value")
        }

        let cjAudioCodec = if (!audioCodec.isNull()) {
            audioCodec.toString()
        } else {
            ""
        }

        let cjVideoCodec = if (!videoCodec.isNull()) {
            videoCodec.toString()
        } else {
            ""
        }

        return AVRecorderProfile(cjFileFormat, audioBitrate: audioBitrate, audioChannels: audioChannels,
            audioCodec: cjAudioCodec, audioSampleRate: audioSampleRate, videoBitrate: videoBitrate,
            videoCodec: cjVideoCodec, videoFrameWidth: videoFrameWidth, videoFrameHeight: videoFrameHeight,
            videoFrameRate: videoFrameRate, isHdr: isHdr, enableTemporalScale: enableTemporalScale)
    }

    func free() {
        unsafe {
            LibC.free(fileFormat)
            LibC.free(audioCodec)
            LibC.free(videoCodec)
        }
    }
}

@C
struct CLocation {
    CLocation(
        var latitude: Float64,
        var longitude: Float64,
        var isValid: Bool
    ) {}

    func toLocation(): Location {
        return Location(latitude, longitude);
    }
}

@C
struct CAVMetadata {
    var album: CString = CString(CPointer())
    var albumArtist: CString = CString(CPointer())
    var artist: CString = CString(CPointer())
    var author: CString = CString(CPointer())
    var dateTime: CString = CString(CPointer())
    var dateTimeFormat: CString = CString(CPointer())
    var composer: CString = CString(CPointer())
    var duration: CString = CString(CPointer())
    var genre: CString = CString(CPointer())
    var hasAudio: CString = CString(CPointer())
    var hasVideo: CString = CString(CPointer())
    var mimeType: CString = CString(CPointer())
    var trackCount: CString = CString(CPointer())
    var sampleRate: CString = CString(CPointer())
    var title: CString = CString(CPointer())
    var videoHeight: CString = CString(CPointer())
    var videoWidth: CString = CString(CPointer())
    var videoOrientation: CString = CString(CPointer())
    var hdrType: Int32 = -1
    var location: CLocation = CLocation(0.0, 0.0, false)
    var customInfo: CHashStrArr = CHashStrArr()
    var isValid: Bool = false

    init() {}
    init(metadata: AVMetadata) {
        unsafe {
            try {
                this.album = LibC.mallocCString(metadata.album)
                this.albumArtist = LibC.mallocCString(metadata.albumArtist)
                this.artist = LibC.mallocCString(metadata.artist)
                this.author = LibC.mallocCString(metadata.author)
                this.dateTime = LibC.mallocCString(metadata.dateTime)
                this.dateTimeFormat = LibC.mallocCString(metadata.dateTimeFormat)
                this.composer = LibC.mallocCString(metadata.composer)
                this.duration = LibC.mallocCString(metadata.duration)
                this.genre = LibC.mallocCString(metadata.genre)
                this.hasAudio = LibC.mallocCString(metadata.hasAudio)
                this.hasVideo = LibC.mallocCString(metadata.hasVideo)
                this.mimeType = LibC.mallocCString(metadata.mimeType)
                this.trackCount = LibC.mallocCString(metadata.trackCount)
                this.sampleRate = LibC.mallocCString(metadata.sampleRate)
                this.title = LibC.mallocCString(metadata.title)
                this.videoHeight = LibC.mallocCString(metadata.videoHeight)
                this.videoWidth = LibC.mallocCString(metadata.videoWidth)
                this.videoOrientation = LibC.mallocCString(metadata.videoOrientation)
                this.hdrType = INVALID_RECORDER_VALUE
                this.location = CLocation(0.0, 0.0, false)
                this.customInfo = CHashStrArr(metadata.customInfo)
                this.isValid = true
            } catch (e: Exception) {
                freeAll()
                throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
            }
        }
    }

    func freeAll(): Unit {
        unsafe {
            LibC.free(this.album)
            LibC.free(this.albumArtist)
            LibC.free(this.artist)
            LibC.free(this.author)
            LibC.free(this.dateTime)
            LibC.free(this.dateTimeFormat)
            LibC.free(this.composer)
            LibC.free(this.duration)
            LibC.free(this.genre)
            LibC.free(this.hasAudio)
            LibC.free(this.hasVideo)
            LibC.free(this.mimeType)
            LibC.free(this.trackCount)
            LibC.free(this.sampleRate)
            LibC.free(this.title)
            LibC.free(this.videoHeight)
            LibC.free(this.videoWidth)
            LibC.free(this.videoOrientation)
            this.customInfo.free()
        }
    }

    func toAVMetadata(): AVMetadata {
        let cjHdrType = if (hdrType != -1) {
            Some(HdrType.parse(hdrType))
        } else {
            None<HdrType>
        }
        let cjLocation = location.toLocation()
        let cjCustomInfo = customInfo.toHashMapOption()
        return AVMetadata(album: album.toString(), albumArtist: albumArtist.toString(), author: author.toString(),
            dateTime: dateTime.toString(), dateTimeFormat: dateTimeFormat.toString(), composer: composer.toString(),
            duration: duration.toString(), genre: genre.toString(), hasAudio: hasAudio.toString(),
            hasVideo: hasVideo.toString(), mimeType: mimeType.toString(), trackCount: trackCount.toString(),
            sampleRate: sampleRate.toString(), title: title.toString(), videoHeight: videoHeight.toString(),
            videoWidth: videoWidth.toString(), videoOrientation: videoOrientation.toString(), customInfo: cjCustomInfo)
    }

    func free() {
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
        this.customInfo.free()
    }
}

@C
struct CAVRecorderConfig {
    var profile: CAVRecorderProfile = CAVRecorderProfile()
    var url: CString = CString(CPointer())
    var audioSourceType: Int32 = INVALID_RECORDER_VALUE
    var videoSourceType: Int32 = INVALID_RECORDER_VALUE
    var fileGenerationMode: Int32 = INVALID_RECORDER_VALUE
    var metadata: CAVMetadata = CAVMetadata()
    var maxDuration: Int32 = INVALID_RECORDER_VALUE

    init(recorderConfig: AVRecorderConfig) {
        try {
            this.profile = CAVRecorderProfile(recorderConfig.profile)
            this.url = unsafe { LibC.mallocCString(recorderConfig.url) }
            this.audioSourceType = recorderConfig.audioSourceType.get()
            this.videoSourceType = recorderConfig.videoSourceType.get()
            this.fileGenerationMode = recorderConfig.fileGenerationMode.get()
            this.metadata = CAVMetadata(recorderConfig.metadata)
            this.maxDuration = recorderConfig.maxDuration
        } catch (e: Exception) {
            free()
            throw BusinessException(MEDIA_MEMORY_ERROR, "No memory.")
        }
    }

    func toAVRecorderConfig(): AVRecorderConfig {
        let configProfile = this.profile.toAVRecorderProfile()
        let configUrl = unsafe { this.url.toString() }
        let configAudioSourceType = if (this.audioSourceType != -1) {
            AudioSourceType.parse(this.audioSourceType)
        } else {
            AudioSourceTypeDefault
        }
        let configVideoSourceType = if (this.videoSourceType != -1) {
            VideoSourceType.parse(this.videoSourceType)
        } else {
            VideoSourceTypeSurfaceYuv
        }
        let configFileGenerationMode = if (this.fileGenerationMode != -1) {
            FileGenerationMode.parse(this.fileGenerationMode)
        } else {
            AppCreate
        }
        let configMetadata = if (this.metadata.isValid) {
            this.metadata.toAVMetadata()
        } else {
            AVMetadata()
        }
        let configMaxDuration = this.maxDuration
        return AVRecorderConfig(configProfile, configUrl, audioSourceType: configAudioSourceType,
            videoSourceType: configVideoSourceType, fileGenerationMode: configFileGenerationMode,
            metadata: configMetadata, maxDuration: configMaxDuration)
    }

    func free(): Unit {
        unsafe {
            LibC.free(url)
            this.profile.free()
            this.metadata.free()
        }
    }
}

/**
 * Creates an AVRecorder instance.
 *
 * @returns { AVRecorder } An instance used to return AVRecorder instance if the operation is successful.
 * @throws { BusinessException } 5400101 - No memory.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder",
    throwexception: true,
    workerthread: true
]
public func createAVRecorder(): AVRecorder {
    var errCode = 0i32
    var id = unsafe { FfiOHOSMediaAVRecorderCreateAVRecorder(inout errCode) }

    if (errCode != SUCCESS_CODE) {
        throw BusinessException(errCode, getErrorMsg(errCode))
    }
    return AVRecorder(id)
}

/**
 * Manages and record audio/video. Before calling an AVRecorder method, you must use createAVRecorder()
 * to create an AVRecorder instance.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Media.AVRecorder"
]
public class AVRecorder <: RemoteDataLite {
    protected init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Sets audio and video recording parameters.
     *
     * @param { AVRecorderConfig } config - Recording parameters.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 5400102 - Operate not permit.
     * @throws { BusinessException } 5400105 - Service died.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.MICROPHONE",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func prepare(config: AVRecorderConfig): Unit {
        let cRecorderConfig = CAVRecorderConfig(config)
        let ret = unsafe { FfiOHOSMediaAVRecorderPrepare(getID(), cRecorderConfig) }
        if (ret != SUCCESS_CODE) {
            cRecorderConfig.free()
            throw BusinessException(ret, getErrorMsg(ret))
        }
        cRecorderConfig.free()
    }

    /**
     * Obtains the surface required for recording.
     *
     * @returns { String } - return the input surface id in string.
     * @throws { BusinessException } 5400102 - Operate not permit.
     * @throws { BusinessException } 5400103 - IO error.
     * @throws { BusinessException } 5400105 - Service died.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func getInputSurface(): String {
        var errCode = 0i32
        let ret: CString = unsafe { FfiOHOSMediaAVRecorderGetInputSurface(getID(), inout errCode) }
        if (errCode != SUCCESS_CODE) {
            unsafe { LibC.free(ret) }
            throw BusinessException(errCode, getErrorMsg(errCode))
        }
        let surfaceId = ret.toString();
        unsafe { LibC.free(ret) }
        return surfaceId
    }

    /**
     * Start AVRecorder, it will to started state.
     *
     * @throws { BusinessException } 5400102 - Operate not permit.
     * @throws { BusinessException } 5400103 - IO error.
     * @throws { BusinessException } 5400105 - Service died.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func start(): Unit {
        let ret = unsafe { FfiOHOSMediaAVRecorderStart(getID()) }
        if (ret != SUCCESS_CODE) {
            throw BusinessException(ret, getErrorMsg(ret))
        }
        return
    }

    /**
     * Stop AVRecorder, it will to stopped state.
     *
     * @throws { BusinessException } 5400102 - Operate not permit.
     * @throws { BusinessException } 5400103 - IO error.
     * @throws { BusinessException } 5400105 - Service died.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Media.AVRecorder",
        throwexception: true,
        workerthread: true
    ]
    public func stop(): Unit {
        let ret = unsafe { FfiOHOSMediaAVRecorderStop(getID()) }
        if (ret != SUCCESS_CODE) {
            throw BusinessException(ret, getErrorMsg(ret))
        }
        return
    }
}
