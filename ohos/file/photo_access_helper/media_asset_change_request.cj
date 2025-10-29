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
import ohos.ffi.{RemoteDataLite, releaseFFIData,CArrI64, toArrayCString, CArrUI8, cjArr2CArr}
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.business_exception.BusinessException

/**
 * Defines the interface of media change request.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public interface MediaChangeRequest {}

/**
 * Defines the class of media asset change request.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class MediaAssetChangeRequest <: RemoteDataLite & MediaChangeRequest {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Constructor used to initialize an asset change request.
     *
     * @param { PhotoAsset } asset - Assets to change.
     * @returns { MediaAssetChangeRequest } Returns a MediaAssetChangeRequest instance
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public init(asset: PhotoAsset) {
        super(
            unsafe {
                var errCode = 0i32
                let id = FfiMediaAssetChangeRequestImplConstructor(asset.getID(), inout errCode)
                checkRet(errCode, "init")
                id
            })
    }

    /**
     * Creates an image asset change request.
     *
     * @param { Context } context - Context of the ability instance.
     * @param { String } fileUri - Data source of the image asset, which is specified by a URI in the application sandbox directory.
     * @returns { MediaAssetChangeRequest } - Returns a MediaAssetChangeRequest instance
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900002 - The file corresponding to the URI is not in the app sandbox.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public static func createImageAssetRequest(context: UIAbilityContext, fileUri: String): MediaAssetChangeRequest {
        var id = -1
        unsafe {
            try (uri = LibC.mallocCString(fileUri).asResource()) {
                var errCode = 0i32
                id = FfiMediaAssetChangeRequestImplCreateImageAssetRequest(context.getID(), uri.value, inout errCode)
                checkRet(errCode, "createImageAssetRequest")
            }
        }
        return MediaAssetChangeRequest(id)
    }

    /**
     * Creates a video asset change request.
     *
     * @param { Context } context - Context of the ability instance.
     * @param { String } fileUri - Data source of the video asset, which is specified by a URI in the application sandbox directory.
     * @returns { MediaAssetChangeRequest } - Returns a MediaAssetChangeRequest instance
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900002 - The file corresponding to the URI is not in the app sandbox.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public static func createVideoAssetRequest(context: UIAbilityContext, fileUri: String): MediaAssetChangeRequest {
        var id = -1
        unsafe {
            try (uri = LibC.mallocCString(fileUri).asResource()) {
                var errCode = 0i32
                id = FfiMediaAssetChangeRequestImplCreateVideoAssetRequest(context.getID(), uri.value, inout errCode)
                checkRet(errCode, "createVideoAssetRequest")
            }
        }
        return MediaAssetChangeRequest(id)
    }

    /**
     * Create an asset change request based on the file type and filename extension.
     *
     * @param { Context } context - Context of the ability instance.
     * @param { PhotoType } photoType - Type of the file to create, which can be IMAGE or VIDEO.
     * @param { String } extension - File name extension, for example, 'jpg'.
     * @param { CreateOptions } [options] - Options for creating the image or video asset, for example, {title: 'testPhoto'}.
     * @returns { MediaAssetChangeRequest } - Returns a MediaAssetChangeRequest instance
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public static func createAssetRequest(context: UIAbilityContext, photoType: PhotoType, extension: String,
        options!: CreateOptions = CreateOptions(title: "", subtype: Default)): MediaAssetChangeRequest {
        var id = -1
        unsafe {
            try (
                cextension = LibC.mallocCString(extension).asResource(),
                ctitle = LibC.mallocCString(options.title).asResource()
            ) {
                let subType: Int32 = options.subtype.value
                let ret = FfiMediaAssetChangeRequestImplCreateAssetRequest(context.getID(), photoType.value,
                    cextension.value, ctitle.value, subType)
                checkRet(ret.code, "createAssetRequest")
                id = ret.data
            }
        }
        return MediaAssetChangeRequest(id)
    }

    /**
     * Deletes media assets. This API uses a promise to return the result. The deleted assets are moved to the trash.
     *
     * @param { Context } context - Context of the ability instance.
     * @param { Array<PhotoAsset> } assets - Array of assets to delete.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        permission: "ohos.permission.WRITE_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public static func deleteAssets(context: UIAbilityContext, assets: Array<PhotoAsset>): Unit {
        let idArr = Array<Int64>(assets.size, {i => assets[i].getID()})
        let idCArr = CArrI64(unsafe { cjArr2CArr(idArr) }, idArr.size)
        let errCode = unsafe { FfiMediaAssetChangeRequestImplDeleteAssetsByObject(context.getID(), idCArr) }
        unsafe { LibC.free(idCArr.head) }
        checkRet(errCode, "deleteAssets")
    }

    /**
     * Deletes media assets. This API uses a promise to return the result. The deleted assets are moved to the trash.
     *
     * @param { Context } context - Context of the ability instance.
     * @param { Array<string> } assets - URIs of the media files to delete.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000002 - The uri format is incorrect or does not exist.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        permission: "ohos.permission.WRITE_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public static func deleteAssets(context: UIAbilityContext, assets: Array<String>): Unit {
        let cArr = unsafe { toArrayCString(assets) }
        let errCode = unsafe { FfiMediaAssetChangeRequestImplDeleteAssetsByString(context.getID(), cArr) }
        unsafe { cArr.free() }
        checkRet(errCode, "deleteAssets")
    }

    /**
     * Obtains the asset in this asset change request.
     *
     * @returns { PhotoAsset } Returns the PhotoAsset object in this change request.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getAsset(): PhotoAsset {
        var errCode = 0i32
        let id = unsafe { FfiMediaAssetChangeRequestImplGetAsset(getID(), inout errCode) }
        checkRet(errCode, "getAsset")
        return if (id == 0) {
            throw BusinessException(401, "Parameter error.")
        } else {
            PhotoAsset(id)
        }
    }

    /**
     * Sets the media asset title.
     *
     * @param { String } title - Title to set.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func setTitle(title: String): Unit {
        try (ctitle = unsafe { LibC.mallocCString(title).asResource() }) {
            let errCode = unsafe { FfiMediaAssetChangeRequestImplSetTitle(getID(), ctitle.value) }
            checkRet(errCode, "setTitle")
        }
    }

    /**
     * Obtains the handler used for writing a file to cache.
     *
     * @returns { Int32 } Returns the write cache handler
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessException } 14000011 - System inner fail
     * @throws { BusinessException } 14000016 - Operation Not Support
     */
    @!APILevel[
        22,
        permission: "ohos.permission.WRITE_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getWriteCacheHandler(): Int32 {
        var errCode = 0i32
        let fd = unsafe { FfiMediaAssetChangeRequestImplGetWriteCacheHandler(getID(), inout errCode) }
        checkRet(errCode, "getWriteCacheHandler")
        return fd
    }

    /**
     * Adds a resource using fileUri.
     *
     * @param { ResourceType } resourceType - Type of the resource to add.
     * @param { String } fileUri - Data source of the resource to be added, which is specified by a URI in the application sandbox directory.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900002 - The file corresponding to the URI is not in the app sandbox.
     * @throws { BusinessException } 14000011 - System inner fail
     * @throws { BusinessException } 14000016 - Operation Not Support
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func addResource(resourceType: ResourceType, fileUri: String): Unit {
        try (uri = unsafe { LibC.mallocCString(fileUri).asResource() }) {
            let errCode = unsafe {
                FfiMediaAssetChangeRequestImplAddResourceByString(getID(), resourceType.value, uri.value)
            }
            checkRet(errCode, "addResource")
        }
    }

    /**
     * Adds a resource using ArrayBuffer data.
     *
     * @param { ResourceType } resourceType - Type of the resource to add.
     * @param { Array<Byte> } data - Data of the resource to add.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     * @throws { BusinessException } 14000016 - Operation Not Support
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func addResource(resourceType: ResourceType, data: Array<Byte>): Unit {
        let arr = CArrUI8(unsafe { cjArr2CArr(data) }, data.size)
        let errCode = unsafe { FfiMediaAssetChangeRequestImplAddResourceByBuffer(getID(), resourceType.value, arr) }
        arr.free()
        checkRet(errCode, "addResource")
    }

    /**
     * Saves the photo taken by the camera.
     *
     * @throws { BusinessException } 14000011 - System inner fail
     * @throws { BusinessException } 14000016 - Operation Not Support
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func saveCameraPhoto(): Unit {
        let errCode = unsafe { FfiMediaAssetChangeRequestImplSaveCameraPhoto(getID()) }
        checkRet(errCode, "saveCameraPhoto")
    }

    /**
     * Discards the photo taken by the camera.
     *
     * @throws { BusinessException } 14000011 - Internal system error
     * @throws { BusinessException } 14000016 - Operation Not Support
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func discardCameraPhoto(): Unit {
        let errCode = unsafe { FfiMediaAssetChangeRequestImplDiscardCameraPhoto(getID()) }
        checkRet(errCode, "discardCameraPhoto")
    }

    protected func applyChanges(): Unit {
        let errCode = unsafe { FfiMediaAssetChangeRequestImplApplyChanges(getID()) }
        checkRet(errCode, "applyChanges")
    }
}