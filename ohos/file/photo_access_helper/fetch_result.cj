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

package ohos.file.photo_access_helper

import ohos.labels.APILevel
import ohos.ffi.{RemoteDataLite, releaseFFIData}

/**
 * Provides APIs to manage the file retrieval result.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public open class FetchResult <: RemoteDataLite {
    internal init(id: Int64) {
        super(id)
    }

    /**
     * Obtains the total number of objects in the fetch result.
     * @returns { Int32 } Total number of objects.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true
    ]
    public func getCount(): Int32 {
        var errCode = 0i32
        unsafe {
            let count = FfiFetchResultGetCount(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getCount")
            return count
        }
    }

    /**
     * Checks whether the result set points to the last row.
     * You need to check whether the object is the last one before calling getNextObject.
     * @returns { Bool } Whether the object is the last one in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true
    ]
    public func isAfterLast(): Bool {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultIsAfterLast(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] isAfterLast")
            return ret
        }
    }

    /**
     * Release the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true
    ]
    public func close(): Unit {
        unsafe { FfiFetchResultClose(myDataId) }
        releaseFFIData(myDataId)
    }

    private let impl_: FetchResultImpl = FetchResultImpl()
}

class FetchResultImpl {}

/**
 * Provides APIs to manage the file retrieval album result.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class AlbumResult <: FetchResult {
    protected init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtains the first object in the fetch result.
     * @returns { Album } Returns the first Album object in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getFirstObject(): Album {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetFirstObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getFirstObject")
            return Album(ret.id)
        }
    }

    /**
     * Obtains the next object in the fetch result.
     * Before using this API, you must use isAfterLast() to check whether the current position is the end of the result set.
     * in the fetch result. This method only works when the current position is not the last row.
     * @returns { Album } Returns the next Album object in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getNextObject(): Album {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetNextObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getNextObject")
            return Album(ret.id)
        }
    }

    /**
     * Obtains the last object asset in the fetch result.
     * @returns { Album } Returns the last Album object
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getLastObject(): Album {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetLastObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getLastObject")
            return Album(ret.id)
        }
    }

    /**
     * Obtains the object with the specified index in the result set.
     * @param { Int32 } index - Index of the file asset to obtain. The value starts from 0.
     * @returns { Album } Returns the Album object at the specified index.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getObjectByPosition(index: Int32): Album {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetObjectAtPosition(getID(), index, inout errCode)
            checkRet(errCode, "[FetchResult] getObjectByPosition")
            return Album(ret.id)
        }
    }

    /**
     * Obtains all objects in the fetch result.
     * @returns { Array<Album> } Returns an array containing all Album objects in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getAllObjects(): Array<Album> {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetAllObjects(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getAllObjects")
            let size = ret.size
            let head = ret.head
            let resullt = Array<Album>(size, {i => Album(head.read(i).id)})
            ret.free()
            return resullt
        }
    }
}

/**
 * Defines information about the images or videos selected.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class PhotoAssetResult <: FetchResult {
    protected init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtains the first object in the fetch result.
     * @returns { PhotoAsset } Returns the first PhotoAsset object in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getFirstObject(): PhotoAsset {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetFirstObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getFirstObject")
            return PhotoAsset(ret.id)
        }
    }

    /**
     * Obtains the next object in the fetch result.
     * Before using this API, you must use isAfterLast() to check whether the current position is the end of the result set.
     * in the fetch result. This method only works when the current position is not the last row.
     * @returns { PhotoAsset } Returns the next PhotoAsset object in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getNextObject(): PhotoAsset {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetNextObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getNextObject")
            return PhotoAsset(ret.id)
        }
    }

    /**
     * Obtains the last object asset in the fetch result.
     * @returns { PhotoAsset } Returns the last PhotoAsset object
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getLastObject(): PhotoAsset {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetLastObject(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getLastObject")
            return PhotoAsset(ret.id)
        }
    }

    /**
     * Obtains the object with the specified index in the result set.
     * @param { Int32 } index - Index of the file asset to obtain. The value starts from 0.
     * @returns { PhotoAsset } Returns the PhotoAsset object at the specified index.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getObjectByPosition(index: Int32): PhotoAsset {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetObjectAtPosition(getID(), index, inout errCode)
            checkRet(errCode, "[FetchResult] getObjectByPosition")
            return PhotoAsset(ret.id)
        }
    }

    /**
     * Obtains all objects in the fetch result.
     * @returns { Array<PhotoAsset> } Returns an array containing all PhotoAsset objects in the fetch result.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core",
        throwexception: true,
        workerthread: true
    ]
    public func getAllObjects(): Array<PhotoAsset> {
        var errCode = 0i32
        unsafe {
            let ret = FfiFetchResultGetAllObjects(getID(), inout errCode)
            checkRet(errCode, "[FetchResult] getAllObjects")
            let size = ret.size
            let head = ret.head
            let resullt = Array<PhotoAsset>(size, {i => PhotoAsset(head.read(i).id)})
            ret.free()
            return resullt
        }
    }
}
