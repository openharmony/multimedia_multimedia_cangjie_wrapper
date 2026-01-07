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

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator", throwexception: true, workerthread: true]
public func createAVImageGenerator(): AVImageGenerator {
    return AVImageGenerator()
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
public class AVImageGenerator {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVMetadataExtractor", throwexception: true]
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

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator", throwexception: true, workerthread: true]
    public func fetchFrameByTime(timeUs: Int64, options: AVImageQueryOptions, param: PixelMapParams): PixelMap {
        return PixelMap()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.Core"]
public class AVFileDescriptor {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.Core"]
    public var fd: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.Core"]
    public var offset: Int64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.Core"]
    public var length: Int64

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.Core"]
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

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
public class PixelMapParams {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public var width: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public var height: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public init(width!: Int32 = -1, height!: Int32 = -1) {
        super()
        this.width = 0
        this.height = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
public enum AVImageQueryOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    AvImageQueryNextSync
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    AvImageQueryPreviousSync
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    AvImageQueryClosestSync
    | @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    AvImageQueryClosest
    | ...
}

extend AVImageQueryOptions <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public func toString(): String {
        return String()
    }
}

extend AVImageQueryOptions <: Equatable<AVImageQueryOptions> {
    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public operator func ==(other: AVImageQueryOptions): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Multimedia.Media.AVImageGenerator"]
    public operator func !=(other: AVImageQueryOptions): Bool {
        return true
    }
}