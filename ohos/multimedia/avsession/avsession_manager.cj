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

import ohos.ffi.safeMalloc
import ohos.business_exception.BusinessException
import ohos.labels.APILevel
import ohos.app.ability.ui_ability.{UIAbilityContext, getStageContext}

foreign func FfiMultimediaAVSessionManagerCreateAVSession(context: CPointer<Unit>, tag: CPointer<CString>,
    `type`: CPointer<Int32>, session: CPointer<Int64>, sessionId: CPointer<CString>): Int32

/**
 * Create an AVSession instance. An ability can only create one AVSession
 *
 * @param { UIAbilityContext } context - The context of application
 * @param { String } tag - A user-defined name for this session
 * @param { AVSessionType } avSessionType - The type of session
 * @returns { AVSession } Returns the AVSession instance.
 * @throws { BusinessException } 6600101 - Session service exception.
 * @throws { BusinessException } 6611106 -  - The parameter is invalid.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Multimedia.AVSession.Core",
    throwexception: true
]
public func createAVSession(context: UIAbilityContext, tag: String, avSessionType: AVSessionType): AVSession {
    let contextPtr = getStageContext(context)
    if (contextPtr.isNull()) {
        LOGGER.error("Invalid context: context must not be null")
        throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
    }
    if (tag.isEmpty()) {
        LOGGER.error("Invalid tag: tag must not be null")
        throw BusinessException(CAST_GENERICERR_EXT_API13_INVALID_PARAM, "The parameter is invalid.")
    }
    try (
        tagPtr = safeMalloc<CString>().asResource(),
        sessionIdPtr = safeMalloc<CString>().asResource(),
        tagStr = unsafe { LibC.mallocCString(tag).asResource() }
    ) {
        unsafe { tagPtr.value.write(tagStr.value) }
        var session = 0i64
        var typeValue = avSessionType.value
        let code = unsafe { FfiMultimediaAVSessionManagerCreateAVSession(contextPtr, tagPtr.value, inout typeValue,
            inout session, sessionIdPtr.value) }
        checkAndReturn(code, "createAVSession")
        let sessionId = unsafe { sessionIdPtr.value.read().toString() }
        unsafe { LibC.free(sessionIdPtr.value.read()) }
        return unsafe { AVSession(session, sessionId, avSessionType) }
    }
    throwBusinessException(ERR_NO_MEMORY)
}
