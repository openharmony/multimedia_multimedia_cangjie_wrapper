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

package ohos.file.photo_access_helper

import ohos.labels.APILevel
import ohos.ffi.SUCCESS_CODE
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.business_exception.{AsyncCallback, BusinessException}

/**
 * PhotoViewPicker Object
 *
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class PhotoViewPicker {
    let context: UIAbilityContext

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public init(gcontext: UIAbilityContext) {
        context = gcontext
    }

    /**
     * Pull up the photo picker based on the selection mode.
     *
     * @param { PhotoSelectOptions } [option] - represents the options provided in select mode.
     * @returns { PhotoSelectResult } Returns the uris for the selected files.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900042 - Unknown error
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func select(option!: PhotoSelectOptions = PhotoSelectOptions()): PhotoSelectResult {
        var errCode = 0i32
        let cPhotoSelectOptions = CPhotoSelectOptions(option)
        let ret = unsafe {
            FfiPhotoAccessHelperStartPhotoPicker(context.getID(), cPhotoSelectOptions, inout errCode)
        }
        cPhotoSelectOptions.free()
        if (errCode != SUCCESS_CODE) {
            throw BusinessException(errCode, getErrorMsg(errCode))
        } else {
            let result = ret.toPhotoSelectResult()
            ret.free()
            return result
        }
    }
}
