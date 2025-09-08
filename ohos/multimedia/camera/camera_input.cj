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

package ohos.multimedia.camera

import ohos.labels.*
import ohos.business_exception.*
import ohos.callback_invoke.*
import ohos.ffi.*
import std.collection.*
import std.sync.*

/**
 * Camera input object.
 *
 * @relation interface CameraInput
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class CameraInput <: RemoteDataLite {
    let errorList = ArrayList<(CallbackObject, Int64)>()
    let errorMutex = Mutex()

    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Open camera.
     *
     * @throws { BusinessException } 7400102 - Operation not allowed.
     * @throws { BusinessException } 7400107 - Can not use camera cause of conflict.
     * @throws { BusinessException } 7400108 - Camera disabled cause of security reason.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     * @relation open(): Promise<void>
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func open(): Unit {
        unsafe {
            let errCode = FfiCameraInputOpen(this.getID())
            successOrThrow(errCode)
        }
    }

    /**
     * Open camera.
     *
     * @param { Bool } isSecureEnabled - Setting true enables the camera to be opened in a safe way,
     * setting false does the opposite. Failure of an interface call returns an error code of type CameraErrorCode.
     * @returns { UInt64 } Return the result.
     * @throws { BusinessException } 7400107 - Can not use camera cause of conflict.
     * @throws { BusinessException } 7400108 - Camera disabled cause of security reason.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     * @relation open(isSecureEnabled: boolean): Promise<bigint>
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func open(isSecureEnabled: Bool): UInt64 {
        var secureSeqId: UInt64 = 0
        let errCode = unsafe {
            FfiCameraInputOpenWithIsEnableSecureCamera(this.getID(), isSecureEnabled, inout secureSeqId)
        }
        successOrThrow(errCode)
        return secureSeqId
    }

    /**
     * Close camera.
     *
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     * @relation close(): Promise<void>
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func close(): Unit {
        unsafe {
            let errCode = FfiCameraInputClose(this.getID())
            successOrThrow(errCode)
        }
    }

    /**
     * Registers a listener for CameraInput error events to get the result by registering
     * a callback function. This API uses an asynchronous callback to return the result.
     *
     * Description: Currently, it is not allowed to use off() to unregister the callback
     * within the callback method of on().
     *
     * @param { CameraDevice } camera - Camera device.
     * @param { Callback0Argument } callback - Callback used to get the camera input errors.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     * @relation on(type: 'error', camera: CameraDevice, callback: ErrorCallback): void
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func onError(camera: CameraDevice, callback: Callback0Argument): Unit {
        synchronized(errorMutex) {
            let callbackList = errorList
            if (findCallbackObject(callbackList, callback)) {
                CAMERA_LOG.error("CameraInput on failed: ${paramError("callback object", "different")}")
                return
            }
            let wrapper = {
                value: CErrorCallback =>
                let code = value.errorType
                if (code == SUCCESS_CODE) {
                    callback.invoke(None)
                } else {
                    callback.invoke(BusinessException(code, getErrorMsg(code)))
                }
            }
            let lambdaData = Callback1Param<CErrorCallback, Unit>(wrapper)
            let errCode = unsafe { FfiCameraInputOnError(getID(), lambdaData.getID()) }
            successOrThrow(errCode)
            callbackList.add((callback, lambdaData.getID()))
        }
    }

    /**
     * Unsubscribes from error events.
     *
     * @param { CameraDevice } camera - Camera device.
     * @param { ?Callback0Argument } callback - Callback used to get the camera input errors.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     * @relation off(type: 'error', camera: CameraDevice, callback?: ErrorCallback): void
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func offError(camera: CameraDevice, callback!: ?Callback0Argument = None): Unit {
        synchronized(errorMutex) {
            let callbackList = errorList
            if (callbackList.size == 0) {
                CAMERA_LOG.error("CameraInput Off failed: The event is not registered")
                return
            }
            if (let Some(v) <- callback) {
                callbackList.removeIf(
                    {
                        item => if (refEq(item[0], v)) {
                            let errCode = unsafe { FfiCameraInputOffError(this.getID(), item[1]) }
                            successOrThrow(errCode)
                            true
                        } else {
                            CAMERA_LOG.error("CameraInput Off failed: The callback is not registered")
                            false
                        }
                    })
            } else {
                let errCode = unsafe { FfiCameraInputOffAllError(this.getID()) }
                if (errCode != SUCCESS_CODE) {
                    throw BusinessException(errCode, getErrorMsg(errCode))
                } else {
                    callbackList.clear()
                }
            }
        }
    }
}
