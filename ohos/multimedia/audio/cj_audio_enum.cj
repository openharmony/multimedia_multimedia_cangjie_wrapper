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

import std.deriving.{Derive}
import ohos.labels.{APILevel}
import ohos.business_exception.{BusinessException}

/**
 * Enumerates the audio channel.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioChannel {
    /**
     * Channel 1.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel1
    /**
     * Channel 2.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel2
    /**
     * Channel 3.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel3
    /**
     * Channel 4.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel4
    /**
     * Channel 5.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel5
    /**
     * Channel 6.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel6
    /**
     * Channel 7.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel7
    /**
     * Channel 8.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel8
    /**
     * Channel 9.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel9
    /**
     * Channel 10.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel10
    /**
     * Channel 12.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel12
    /**
     * Channel 14.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel14
    /**
     * Channel 16.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    Channel16
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Channel1 => 1i32
                case Channel2 => 2i32
                case Channel3 => 3i32
                case Channel4 => 4i32
                case Channel5 => 5i32
                case Channel6 => 6i32
                case Channel7 => 7i32
                case Channel8 => 8i32
                case Channel9 => 9i32
                case Channel10 => 10i32
                case Channel12 => 12i32
                case Channel14 => 14i32
                case Channel16 => 16i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(channelVal: Int32): AudioChannel {
        match (channelVal) {
            case 1i32 => Channel1
            case 2i32 => Channel2
            case 3i32 => Channel3
            case 4i32 => Channel4
            case 5i32 => Channel5
            case 6i32 => Channel6
            case 7i32 => Channel7
            case 8i32 => Channel8
            case 9i32 => Channel9
            case 10i32 => Channel10
            case 12i32 => Channel12
            case 14i32 => Channel14
            case 16i32 => Channel16
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Audio AudioChannel Layout
 * A 64-bit integer indicates that the appearance and order of the speakers for recording or playback.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioChannelLayout {
    /**
     * Unknown Channel Layout
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutUnknown
    /**
     * Channel Layout For Mono, 1 channel in total
     * Speaker layout: front center(FC)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutMono
    /**
     * Channel Layout For Stereo, 2 channels in total
     * Speaker layout: front left(FL), front right(FR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutStereo
    /**
     * Channel Layout For Stereo-Downmix, 2 channels in total
     * Speaker layout: Stereo left, stereo right
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutStereoDownmix
    /**
     * Channel Layout For 2.1, 3 channels in total
     * Speaker layout: Stereo plus low-frequency effects(LFE)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point1
    /**
     * Channel Layout For 3.0, 3 channels in total
     * Speaker layout: Stereo plus back center(BC)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point0
    /**
     * Channel Layout For Surround, 3 channels in total
     * Speaker layout: Stereo plus FC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutSurround
    /**
     * Channel Layout For 3.1, 4 channels in total
     * Speaker layout: Surround plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point1
    /**
     * Channel Layout For 4.0, 4 channels in total
     * Speaker layout: Surround plus BC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout4Point0
    /**
     * Channel Layout For Quad, 4 channels in total
     * Speaker layout: Stereo plus left and right back speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutQuad
    /**
     * Channel Layout For Quad-Side, 4 channels in total
     * Speaker layout: Stereo plus left and right side speakers(SL, SR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutQuadSide
    /**
     * Channel Layout For 2.0.2, 4 channels in total
     * Speaker layout: Stereo plus left and right top side speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point0Point2
    /**
     * Channel Layout For ORDER1-ACN-N3D First Order Ambisonic(FOA), 4 channels in total
     * First order, Ambisonic Channel Number(ACN) format, Normalization of three-D(N3D)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1AcnN3D
    /**
     * Channel Layout For ORDER1-ACN-SN3D FOA, 4 channels in total
     * First order, ACN format, Semi-Normalization of three-D(SN3D)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1AcnSn3D
    /**
     * Channel Layout For ORDER1-FUMA FOA, 4 channels in total
     * First order, Furse-Malham(FuMa) format
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder1Fuma
    /**
     * Channel Layout For 4.1, 5 channels in total
     * Speaker layout: 4.0 plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout4Point1
    /**
     * Channel Layout For 5.0, 5 channels in total
     * Speaker layout: Surround plus two side speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point0
    /**
     * Channel Layout For 5.0-Back, 5 channels in total
     * Speaker layout: Surround plus two back speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point0Back
    /**
     * Channel Layout For 2.1.2, 5 channels in total
     * Speaker layout: 2.0.2 plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout2Point1Point2
    /**
     * Channel Layout For 3.0.2, 5 channels in total
     * Speaker layout: 2.0.2 plus FC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point0Point2
    /**
     * Channel Layout For 5.1, 6 channels in total
     * Speaker layout: 5.0 plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1
    /**
     * Channel Layout For 5.1-Back, 6 channels in total
     * Speaker layout: 5.0-Back plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Back
    /**
     * Channel Layout For 6.0, 6 channels in total
     * Speaker layout: 5.0 plus BC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point0
    /**
     * Channel Layout For Hexagonal, 6 channels in total
     * Speaker layout: 5.0-Back plus BC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutHexagonal
    /**
     * Channel Layout For 3.1.2, 6 channels in total
     * Speaker layout: 3.1 plus two top front speakers(TFL, TFR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout3Point1Point2
    /**
     * Channel Layout For 6.0-Front, 6 channels in total
     * Speaker layout: Quad-Side plus left and right front center speakers(FLC, FRC)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point0Front
    /**
     * Channel Layout For 6.1, 7 channels in total
     * Speaker layout: 5.1 plus BC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1
    /**
     * Channel Layout For 6.1-Back, 7 channels in total
     * Speaker layout: 5.1-Back plus BC
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1Back
    /**
     * Channel Layout For 6.1-Front, 7 channels in total
     * Speaker layout: 6.0-Front plus LFE
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout6Point1Front
    /**
     * Channel Layout For 7.0, 7 channels in total
     * Speaker layout: 5.0 plus two back speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point0
    /**
     * Channel Layout For 7.0-Front, 7 channels in total
     * Speaker layout: 5.0 plus left and right front center speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point0Front
    /**
     * Channel Layout For 7.1, 8 channels in total
     * Speaker layout: 5.1 plus two back speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1
    /**
     * Channel Layout For Octagonal, 8 channels in total
     * Speaker layout: 5.0 plus BL, BR and BC.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutOctagonal
    /**
     * Channel Layout For 5.1.2, 8 channels in total
     * Speaker layout: 5.1 plus two top side speakers.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Point2
    /**
     * Channel Layout For 7.1-Wide, 8 channels in total
     * Speaker layout: 5.1 plus left and right front center speakers.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Wide
    /**
     * Channel Layout For 7.1-Wide, 8 channels in total
     * Speaker layout: 5.1-Back plus left and right front center speakers.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1WideBack
    /**
     * Channel Layout For ORDER2-ACN-N3D Higher Order Ambisonics(HOA), 9 channels in total
     * Second order, ACN format, N3D
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2AcnN3D
    /**
     * Channel Layout For ORDER2-ACN-SN3D HOA, 9 channels in total
     * Second order, ACN format, SN3D
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2AcnSn3D
    /**
     * Channel Layout For ORDER2-FUMA HOA, 9 channels in total
     * Second order, FuMa format
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder2Fuma
    /**
     * Channel Layout For 5.1.4, 10 channels in total
     * Speaker layout: 5.1 plus four top speakers(TFL, TFR, TBL, TBR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout5Point1Point4
    /**
     * Channel Layout For 7.1.2, 10 channels in total
     * Speaker layout: 7.1 plus two top side speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Point2
    /**
     * Channel Layout For 7.1.4, 12 channels in total
     * Speaker layout: 7.1 plus four top speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout7Point1Point4
    /**
     * Channel Layout For 10.2, 12 channels in total
     * Speaker layout: FL, FR, FC, TFL, TFR, BL, BR, BC, SL, SR, wide left(WL), and wide right(WR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout10Point2
    /**
     * Channel Layout For 9.1.4, 14 channels in total
     * Speaker layout: 7.1.4 plus two wide speakers(WL, WR)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout9Point1Point4
    /**
     * Channel Layout For 9.1.6, 16 channels in total
     * Speaker layout: 9.1.4 plus two top side speakers
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayout9Point1Point6
    /**
     * Channel Layout For Hexadecagonal, 16 channels in total
     * Speaker layout: Octagonal plus two wide speakers, six top speakers(TFL, TFR, TFC, TBL, TBR, TBC)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutHexadecagonal
    /**
     * Channel Layout For ORDER3-ACN-N3D HOA, 16 channels in total
     * Third order, ACN format, N3D
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3AcnN3D
    /**
     * Channel Layout For ORDER3-ACN-SN3D HOA, 16 channels in total
     * Third order, ACN format, N3D
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3AcnSn3D
    /**
     * Channel Layout For ORDER3-FUMA HOA, 16 channels in total
     * Third order, FuMa format
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    ChLayoutAmbOrder3Fuma
    | ...

    prop value: Int64 {
        get() {
            match (this) {
                case ChLayoutUnknown => 0x0i64
                case ChLayoutMono => 0x4i64
                case ChLayoutStereo => 0x3i64
                case ChLayoutStereoDownmix => 0x60000000i64
                case ChLayout2Point1 => 0xBi64
                case ChLayout3Point0 => 0x103i64
                case ChLayoutSurround => 0x7i64
                case ChLayout3Point1 => 0xFi64
                case ChLayout4Point0 => 0x107i64
                case ChLayoutQuad => 0x33i64
                case ChLayoutQuadSide => 0x603i64
                case ChLayout2Point0Point2 => 0x3000000003i64
                case ChLayoutAmbOrder1AcnN3D => 0x100000000001i64
                case ChLayoutAmbOrder1AcnSn3D => 0x100000001001i64
                case ChLayoutAmbOrder1Fuma => 0x100000000101i64
                case ChLayout4Point1 => 0x10Fi64
                case ChLayout5Point0 => 0x607i64
                case ChLayout5Point0Back => 0x37i64
                case ChLayout2Point1Point2 => 0x300000000Bi64
                case ChLayout3Point0Point2 => 0x3000000007i64
                case ChLayout5Point1 => 0x60Fi64
                case ChLayout5Point1Back => 0x3Fi64
                case ChLayout6Point0 => 0x707i64
                case ChLayoutHexagonal => 0x137i64
                case ChLayout3Point1Point2 => 0x500Fi64
                case ChLayout6Point0Front => 0x6C3i64
                case ChLayout6Point1 => 0x70Fi64
                case ChLayout6Point1Back => 0x13Fi64
                case ChLayout6Point1Front => 0x6CBi64
                case ChLayout7Point0 => 0x637i64
                case ChLayout7Point0Front => 0x6C7i64
                case ChLayout7Point1 => 0x63Fi64
                case ChLayoutOctagonal => 0x737i64
                case ChLayout5Point1Point2 => 0x300000060Fi64
                case ChLayout7Point1Wide => 0x6CFi64
                case ChLayout7Point1WideBack => 0xFFi64
                case ChLayoutAmbOrder2AcnN3D => 0x100000000002i64
                case ChLayoutAmbOrder2AcnSn3D => 0x100000001002i64
                case ChLayoutAmbOrder2Fuma => 0x100000000102i64
                case ChLayout5Point1Point4 => 0x2D60Fi64
                case ChLayout7Point1Point2 => 0x300000063Fi64
                case ChLayout7Point1Point4 => 0x2D63Fi64
                case ChLayout10Point2 => 0x180005737i64
                case ChLayout9Point1Point4 => 0x18002D63Fi64
                case ChLayout9Point1Point6 => 0x318002D63Fi64
                case ChLayoutHexadecagonal => 0x18003F737i64
                case ChLayoutAmbOrder3AcnN3D => 0x100000000003i64
                case ChLayoutAmbOrder3AcnSn3D => 0x100000001003i64
                case ChLayoutAmbOrder3Fuma => 0x100000000103i64
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(channelLayout: Int64): AudioChannelLayout {
        match (channelLayout) {
            case 0x0i64 => ChLayoutUnknown
            case 0x4i64 => ChLayoutMono
            case 0x3i64 => ChLayoutStereo
            case 0x60000000i64 => ChLayoutStereoDownmix
            case 0xBi64 => ChLayout2Point1
            case 0x103i64 => ChLayout3Point0
            case 0x7i64 => ChLayoutSurround
            case 0xFi64 => ChLayout3Point1
            case 0x107i64 => ChLayout4Point0
            case 0x33i64 => ChLayoutQuad
            case 0x603i64 => ChLayoutQuadSide
            case 0x3000000003i64 => ChLayout2Point0Point2
            case 0x100000000001i64 => ChLayoutAmbOrder1AcnN3D
            case 0x100000001001i64 => ChLayoutAmbOrder1AcnSn3D
            case 0x100000000101i64 => ChLayoutAmbOrder1Fuma
            case 0x10Fi64 => ChLayout4Point1
            case 0x607i64 => ChLayout5Point0
            case 0x37i64 => ChLayout5Point0Back
            case 0x300000000Bi64 => ChLayout2Point1Point2
            case 0x3000000007i64 => ChLayout3Point0Point2
            case 0x60Fi64 => ChLayout5Point1
            case 0x3Fi64 => ChLayout5Point1Back
            case 0x707i64 => ChLayout6Point0
            case 0x137i64 => ChLayoutHexagonal
            case 0x500Fi64 => ChLayout3Point1Point2
            case 0x6C3i64 => ChLayout6Point0Front
            case 0x70Fi64 => ChLayout6Point1
            case 0x13Fi64 => ChLayout6Point1Back
            case 0x6CBi64 => ChLayout6Point1Front
            case 0x637i64 => ChLayout7Point0
            case 0x6C7i64 => ChLayout7Point0Front
            case 0x63Fi64 => ChLayout7Point1
            case 0x737i64 => ChLayoutOctagonal
            case 0x300000060Fi64 => ChLayout5Point1Point2
            case 0x6CFi64 => ChLayout7Point1Wide
            case 0xFFi64 => ChLayout7Point1WideBack
            case 0x100000000002i64 => ChLayoutAmbOrder2AcnN3D
            case 0x100000001002i64 => ChLayoutAmbOrder2AcnSn3D
            case 0x100000000102i64 => ChLayoutAmbOrder2Fuma
            case 0x2D60Fi64 => ChLayout5Point1Point4
            case 0x300000063Fi64 => ChLayout7Point1Point2
            case 0x2D63Fi64 => ChLayout7Point1Point4
            case 0x180005737i64 => ChLayout10Point2
            case 0x18002D63Fi64 => ChLayout9Point1Point4
            case 0x318002D63Fi64 => ChLayout9Point1Point6
            case 0x18003F737i64 => ChLayoutHexadecagonal
            case 0x100000000003i64 => ChLayoutAmbOrder3AcnN3D
            case 0x100000001003i64 => ChLayoutAmbOrder3AcnSn3D
            case 0x100000000103i64 => ChLayoutAmbOrder3Fuma
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the audio encoding type.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioEncodingType {
    /**
     * Invalid type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    EncodingTypeInvalid
    /**
     * PCM encoding.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    EncodingTypeRaw
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case EncodingTypeInvalid => -1i32
                case EncodingTypeRaw => 0i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(encodingType: Int32): AudioEncodingType {
        match (encodingType) {
            case -1i32 => EncodingTypeInvalid
            case 0i32 => EncodingTypeRaw
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the audio sample formats.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioSampleFormat {
    /**
     * Invalid format.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatInvalid
    /**
     * Unsigned 8 format.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatU8
    /**
     * Signed 16 bit integer, little endian.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS16Le
    /**
     * Signed 24 bit integer, little endian.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS24Le
    /**
     * Signed 32 bit integer, little endian.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatS32Le
    /**
     * Signed 32 bit float, little endian.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleFormatF32Le
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case SampleFormatInvalid => -1i32
                case SampleFormatU8 => 0i32
                case SampleFormatS16Le => 1i32
                case SampleFormatS24Le => 2i32
                case SampleFormatS32Le => 3i32
                case SampleFormatF32Le => 4i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(sampleFormat: Int32): AudioSampleFormat {
        match (sampleFormat) {
            case -1i32 => SampleFormatInvalid
            case 0i32 => SampleFormatU8
            case 1i32 => SampleFormatS16Le
            case 2i32 => SampleFormatS24Le
            case 3i32 => SampleFormatS32Le
            case 4i32 => SampleFormatF32Le
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the audio sampling rate.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioSamplingRate {
    /**
     * 8kHz sample rate.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate8000
    /**
     * 11.025kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate11025
    /**
     * 12kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate12000
    /**
     * 16kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate16000
    /**
     * 22.05kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate22050
    /**
     * 24kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate24000
    /**
     * 32kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate32000
    /**
     * 44.1kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate44100
    /**
     * 48kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate48000
    /**
     * 64kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate64000
    /**
     * 88.2kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate88200
    /**
     * 96kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate96000
    /**
     * 176.4kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate176400
    /**
     * 192kHz sample rate.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SampleRate192000
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case SampleRate8000 => 8000i32
                case SampleRate11025 => 11025i32
                case SampleRate12000 => 12000i32
                case SampleRate16000 => 16000i32
                case SampleRate22050 => 22050i32
                case SampleRate24000 => 24000i32
                case SampleRate32000 => 32000i32
                case SampleRate44100 => 44100i32
                case SampleRate48000 => 48000i32
                case SampleRate64000 => 64000i32
                case SampleRate88200 => 88200i32
                case SampleRate96000 => 96000i32
                case SampleRate176400 => 176400i32
                case SampleRate192000 => 192000i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(sampleRate: Int32): AudioSamplingRate {
        match (sampleRate) {
            case 8000i32 => SampleRate8000
            case 11025i32 => SampleRate11025
            case 12000i32 => SampleRate12000
            case 16000i32 => SampleRate16000
            case 22050i32 => SampleRate22050
            case 24000i32 => SampleRate24000
            case 32000i32 => SampleRate32000
            case 44100i32 => SampleRate44100
            case 48000i32 => SampleRate48000
            case 64000i32 => SampleRate64000
            case 88200i32 => SampleRate88200
            case 96000i32 => SampleRate96000
            case 176400i32 => SampleRate176400
            case 192000i32 => SampleRate192000
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the audio states.
 */
@Derive[Equatable]
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum AudioState {
    /**
     * Invalid state.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateInvalid
    /**
     * Create new instance state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateNew
    /**
     * Prepared state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StatePrepared
    /**
     * Running state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateRunning
    /**
     * Stopped state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateStopped
    /**
     * Released state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StateReleased
    /**
     * Paused state.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    StatePaused
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case StateInvalid => -1i32
                case StateNew => 0i32
                case StatePrepared => 1i32
                case StateRunning => 2i32
                case StateStopped => 3i32
                case StateReleased => 4i32
                case StatePaused => 5i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(state: Int32): AudioState {
        match (state) {
            case -1i32 => StateInvalid
            case 0i32 => StateNew
            case 1i32 => StatePrepared
            case 2i32 => StateRunning
            case 3i32 => StateStopped
            case 4i32 => StateReleased
            case 5i32 => StatePaused
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates audio device flags.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public enum DeviceFlag {
    /**
     * Output devices.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    OutputDevicesFlag
    /**
     * Input devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    InputDevicesFlag
    /**
     * All devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllDevicesFlag
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case OutputDevicesFlag => 1i32
                case InputDevicesFlag => 2i32
                case AllDevicesFlag => 3i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }
}

/**
 * Enumerates source types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Core"
]
public enum SourceType {
    /**
     * Invalid source type.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeInvalid
    /**
     * Mic source type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeMic
    /**
     * Voice recognition source type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceRecognition
    /**
     * Voice communication source type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceCommunication
    /**
     * Voice message source type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeVoiceMessage
    /**
     * Camcorder source type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Core"
    ]
    SourceTypeCamcorder
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case SourceTypeInvalid => -1i32
                case SourceTypeMic => 0i32
                case SourceTypeVoiceRecognition => 1i32
                case SourceTypeVoiceCommunication => 7i32
                case SourceTypeVoiceMessage => 10i32
                case SourceTypeCamcorder => 13i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(sourceType: Int32): SourceType {
        match (sourceType) {
            case -1i32 => SourceTypeInvalid
            case 0i32 => SourceTypeMic
            case 1i32 => SourceTypeVoiceRecognition
            case 7i32 => SourceTypeVoiceCommunication
            case 10i32 => SourceTypeVoiceMessage
            case 13i32 => SourceTypeCamcorder
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates audio device for usage.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
public enum DeviceUsage {
    /**
     * Media output devices.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    MediaOutputDevices
    /**
     * Media input devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    MediaInputDevices
    /**
     * All media devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllMediaDevices
    /**
     * Call output devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    CallOutputDevices
    /**
     * Call input devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    CallInputDevices
    /**
     * All call devices.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    AllCallDevices
    | ...

    prop value: UInt32 {
        get() {
            match (this) {
                case MediaOutputDevices => 1u32
                case MediaInputDevices => 2u32
                case AllMediaDevices => 3u32
                case CallOutputDevices => 4u32
                case CallInputDevices => 8u32
                case AllCallDevices => 12u32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(deviceUsage: UInt32): DeviceUsage {
        match (deviceUsage) {
            case 1u32 => MediaOutputDevices
            case 2u32 => MediaInputDevices
            case 3u32 => AllMediaDevices
            case 4u32 => CallOutputDevices
            case 8u32 => CallInputDevices
            case 12u32 => AllCallDevices
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates device roles.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
protected enum DeviceRole {
    /**
     * Input role.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    InputDevice
    /**
     * Output role.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    OutputDevice
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case InputDevice => 1i32
                case OutputDevice => 2i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(deviceRole: Int32): DeviceRole {
        match (deviceRole) {
            case 1i32 => InputDevice
            case 2i32 => OutputDevice
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates device types.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
protected enum DeviceType {
    /**
     * Invalid device.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    INVALID
    /**
     * Built-in earpiece.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    EARPIECE
    /**
     * Built-in speaker.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    SPEAKER
    /**
     * Wired headset, which is a combination of a pair of earpieces and a microphone.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    WIRED_HEADSET
    /**
     * A pair of wired headphones.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    WIRED_HEADPHONES
    /**
     * Bluetooth device using the synchronous connection oriented link (SCO).
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    BLUETOOTH_SCO
    /**
     * Bluetooth device using advanced audio distribution profile (A2DP).
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    BLUETOOTH_A2DP
    /**
     * Built-in microphone.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    MIC
    /**
     * USB audio headset.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    USB_HEADSET
    /**
     * Display port device.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    DISPLAY_PORT
    /**
     * Device type for rerouting audio to other remote devices by system application
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    REMOTE_CAST
    /**
     * Default device type.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    DEFAULT
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case INVALID => 0i32
                case EARPIECE => 1i32
                case SPEAKER => 2i32
                case WIRED_HEADSET => 3i32
                case WIRED_HEADPHONES => 4i32
                case BLUETOOTH_SCO => 7i32
                case BLUETOOTH_A2DP => 8i32
                case MIC => 15i32
                case USB_HEADSET => 22i32
                case DISPLAY_PORT => 23i32
                case REMOTE_CAST => 24i32
                case DEFAULT => 1000i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(deviceType: Int32): DeviceType {
        match (deviceType) {
            case 0i32 => INVALID
            case 1i32 => EARPIECE
            case 2i32 => SPEAKER
            case 3i32 => WIRED_HEADSET
            case 4i32 => WIRED_HEADPHONES
            case 7i32 => BLUETOOTH_SCO
            case 8i32 => BLUETOOTH_A2DP
            case 15i32 => MIC
            case 22i32 => USB_HEADSET
            case 23i32 => DISPLAY_PORT
            case 24i32 => REMOTE_CAST
            case 1000i32 => DEFAULT
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates device change types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Device"
]
@Derive[ToString]
public enum DeviceChangeType {
    /**
     * Device connection.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    Connect
    /**
     * Device disconnection.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Device"
    ]
    Disconnect
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Connect => 0i32
                case Disconnect => 1i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(deviceChangeType: Int32): DeviceChangeType {
        match (deviceChangeType) {
            case 0i32 => Connect
            case 1i32 => Disconnect
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the interrupt types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptType {
    /**
     * Audio playback interruption started.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptTypeBegin
    /**
     * Audio playback interruption ended.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptTypeEnd
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case InterruptTypeBegin => 1i32
                case InterruptTypeEnd => 2i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(reason: Int32): InterruptType {
        match (reason) {
            case 1i32 => InterruptTypeBegin
            case 2i32 => InterruptTypeEnd
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the interrupt force types.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptForceType {
    /**
     * Forced action taken by system.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptForce
    /**
     * Share type, application can choose to take action or ignore.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptShare
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case InterruptForce => 0i32
                case InterruptShare => 1i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(reason: Int32): InterruptForceType {
        match (reason) {
            case 0i32 => InterruptForce
            case 1i32 => InterruptShare
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}

/**
 * Enumerates the interrupt hints.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.Audio.Renderer"
]
public enum InterruptHint {
    /**
     * None.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintNone
    /**
     * Resume the playback.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintResume
    /**
     * Paused/Pause the playback.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintPause
    /**
     * Stopped/Stop the playback.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintStop
    /**
     * Ducked the playback. (In ducking, the audio volume is reduced, but not silenced.)
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintDuck
    /**
     * Unducked the playback.
     */
    | @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.Audio.Renderer"
    ]
    InterruptHintUnduck
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case InterruptHintNone => 0i32
                case InterruptHintResume => 1i32
                case InterruptHintPause => 2i32
                case InterruptHintStop => 3i32
                case InterruptHintDuck => 4i32
                case InterruptHintUnduck => 5i32
                case _ => throw BusinessException(6800101, "invalid parameter.")
            }
        }
    }

    static func parse(reason: Int32): InterruptHint {
        match (reason) {
            case 0i32 => InterruptHintNone
            case 1i32 => InterruptHintResume
            case 2i32 => InterruptHintPause
            case 3i32 => InterruptHintStop
            case 4i32 => InterruptHintDuck
            case 5i32 => InterruptHintUnduck
            case _ => throw BusinessException(6800101, "invalid parameter.")
        }
    }
}