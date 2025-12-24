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

import ohos.ffi.{RemoteDataLite, releaseFFIData}
import ohos.labels.APILevel

foreign {
    func FfiMultimediaAVSessionActivate(sessionId: Int64): Int32
    func FfiMultimediaAVSessionDestroy(sessionId: Int64): Int32
}

/**
 * AVSession object.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core"
]
public class AVSession <: RemoteDataLite {
    /**
     * unique session Id
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public let sessionId: String
    /**
     * Get current session type
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core"
    ]
    public let sessionType: AVSessionType
    private let remoteId: Int64

    protected init(id: Int64, sessionId: String, sessionType: AVSessionType) {
        super(id)
        this.sessionId = sessionId
        this.sessionType = sessionType
        remoteId = id
    }

    ~init() {
        unsafe { FfiMultimediaAVSessionDestroy(remoteId) }
        releaseFFIData(myDataId)
    }

    /**
     * Activate the session, indicating that the session can accept control commands
     *
     * @throws { BusinessException } 6600101 - Session service exception.
     * @throws { BusinessException } 6600102 - The session does not exist.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Multimedia.AVSession.Core",
        throwexception: true
    ]
    public func activate(): Unit {
        let code = unsafe { FfiMultimediaAVSessionActivate(remoteId) }
        checkAndReturn(code, "activate")
    }
}
