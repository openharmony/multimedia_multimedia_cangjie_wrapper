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

import ohos.labels.*
import ohos.ffi.*
import ohos.business_exception.*
import ohos.callback_invoke.*
import ohos.bundle.bundle_manager.{BundleManager, BundleInfo, BundleFlag}
import ohos.hilog.*
import std.sync.*
import std.collection.*
import ohos.app.ability.ui_ability.*
import ohos.resource_manager.ResourceManager
import ohos.data.data_share_predicates.*

const INVALID_ARGUMENT_ERROR: Int32 = 13900020
/**
 * Returns an instance of PhotoAccessHelper
 *
 * @param { Context } context - The context that initiates the request.
 * @returns { PhotoAccessHelper } Returns the PhotoAccessHelper instance.
 * @throws { BusinessException } 13900020 - Invalid argument
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public func getPhotoAccessHelper(context: UIAbilityContext): PhotoAccessHelper {
    unsafe {
        let ret = FfiPhotoAccessHelperGetPhotoAccessHelper(context.getID())
        if (ret == -1) {
            checkRet(INVALID_ARGUMENT_ERROR, "getPhotoAccessHelper")
        }
        PhotoAccessHelper(ret, context)
    }
}

/**
 * Helper functions to access photos and albums.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class PhotoAccessHelper <: RemoteDataLite {
    private var callbackList = ArrayList<(CallbackObject, String, Int64)>()
    private let onOffMutex = Mutex()
    private let context: UIAbilityContext

    protected init(id: Int64, gcontext: UIAbilityContext) {
        super(id)
        context = gcontext
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Release PhotoAccessHelper instance
     *
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func release(): Unit {
        var errCode = 0i32
        unsafe {
            FfiPhotoAccessHelperRelease(getID(), inout errCode)
            checkRet(errCode, "release")
        }
        releaseFFIData(myDataId)
    }

    /**
     * Fetch photo assets
     *
     * @param { FetchOptions } options - Options for fetching the image and video assets.
     * @returns { Promise<FetchResult<PhotoAsset>> } Returns the fetch result.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        permission: "ohos.READ_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getAssets(options: FetchOptions): PhotoAssetResult {
        var errCode = 0i32
        unsafe {
            let cOptions = options.toCFetchOptions()
            let ret = FfiPhotoAccessHelperGetAssets(getID(), cOptions, inout errCode)
            cOptions.free()
            checkRet(errCode, "getAssets")
            PhotoAssetResult(ret)
        }
    }

    /**
     * Fetch a group of burst assets
     *
     * @param { String } burstKey - UUID of a set of burst photos (BURST_KEY of PhotoKeys). The value is a string of 36 characters.
     * @param { FetchOptions } options - Options for fetching the burst photos.
     * @returns { Promise<FetchResult<PhotoAsset>> } Returns the fetch result.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 14000011 - Internal system error
     */
    @!APILevel[
        since: "22",
        permission: "ohos.READ_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getBurstAssets(burstKey: String, options: FetchOptions): PhotoAssetResult {
        unsafe {
            var errCode = 0i32
            try (cBurstKey = LibC.mallocCString(burstKey).asResource()) {
                let cOptions = options.toCFetchOptions()
                let ret = FfiPhotoAccessHelperGetBurstAssets(getID(), cBurstKey.value, cOptions, inout errCode)
                cOptions.free()
                checkRet(errCode, "getBurstAssets")
                return PhotoAssetResult(ret)
            }
            throw BusinessException(16000050, "Internal error.")
        }
    }

    /**
     * Obtains albums based on the specified options and album type.
     * Before the operation, ensure that the albums to obtain exist.
     *
     * @param { AlbumType } albumType - Type of the album.
     * @param { AlbumSubtype } subtype - Album subtype.
     * @param { FetchOptions } [options] - Options for fetching the albums.
     * @returns { Promise<FetchResult<Album>> } - Returns the fetch result
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        permission: "ohos.READ_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getAlbums(albumType: AlbumType, subtype: AlbumSubtype,
        options!: FetchOptions = FetchOptions(["uri", "album_name"], DataSharePredicates())): AlbumResult {
        var errCode = 0i32
        unsafe {
            let cOptions = options.toCFetchOptions()
            let ret = FfiPhotoAccessHelperGetAlbums(getID(), albumType.value, subtype.value, cOptions, inout errCode)
            cOptions.free()
            checkRet(errCode, "getAlbums")
            AlbumResult(ret)
        }
    }

    /**
     * Registers listening for the specified URI. This API uses a callback to return the result.
     *
     * @param { String } uri - URI of the photo asset, URI of the album, or DefaultChangeUri.
     * @param { boolean } forChildUris - Whether to perform fuzzy listening.
     * If uri is the URI of an album, the value true means to listen for the changes of the files in the album;
     * the value false means to listen for the changes of the album only.
     * If uri is the URI of a photoAsset, there is no difference between true and false for forChildUris.
     * If uri is DefaultChangeUri, forChildUris must be set to true. If forChildUris is false,
     * the URI cannot be found and no message can be received.
     * @param { Callback<ChangeData> } callback - Callback used to return the ChangeData.
     * Multiple callback listeners can be registered for a URI.
     * You can use unRegisterChange to unregister all listeners for the URI or a specified callback listener.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900012 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func registerChange(uri: String, forChildUris: Bool, callback: Callback1Argument<ChangeData>): Unit {
        synchronized(onOffMutex) {
            for (item in callbackList) {
                if (refEq(callback, item[0])) {
                    PHOTO_ACCESS_HELPER_LOG.info("registerChange failed: The same function has registered.")
                    return
                }
            }
            unsafe {
                try (cUri = LibC.mallocCString(uri).asResource()) {
                    let wrapper = {
                        value: CChangeData =>
                        let changeData = value.toChangeData()
                        callback.invoke(None, changeData)
                    }
                    let lambdaData = Callback1Param<CChangeData, Unit>(wrapper)
                    var errCode = 0i32
                    FfiPhotoAccessHelperRegisterChange(getID(), cUri.value, forChildUris, lambdaData.getID(),
                        inout errCode)
                    checkRet(errCode, "registerChange")
                    callbackList.add((callback, uri, lambdaData.getID()))
                }
            }
        }
    }

    /**
     * Unregisters listening for the specified URI. Multiple callbacks can be registered for a URI for listening.
     * You can use this API to unregister the listening of the specified callbacks or all callbacks.
     *
     * @param { String } uri - URI of the photo asset, URI of the album, or DefaultChangeUri.
     * @param { Callback<ChangeData> } [callback] - The callback function to unregister.
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 13900012 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func unRegisterChange(uri: String, callback!: ?Callback1Argument<ChangeData> = None): Unit {
        synchronized(onOffMutex) {
            let flag: Bool = match (callback) {
                case Some(v) => true
                case None => false
            }
            var errCode = 0i32
            unsafe {
                try (cUri = LibC.mallocCString(uri).asResource()) {
                    if (flag) {
                        for (idx in 0..callbackList.size) {
                            let item = callbackList[idx]
                            if (refEq(callback.getOrThrow(), item[0]) && item[1] == uri) {
                                FfiPhotoAccessHelperUnRegisterChange(getID(), cUri.value, item[2], inout errCode)
                                checkRet(errCode, "unRegisterChange")
                                callbackList.remove(at: idx)
                                return
                            }
                        }
                    } else {
                        FfiPhotoAccessHelperUnRegisterChange(getID(), cUri.value, -1, inout errCode)
                        checkRet(errCode, "unRegisterChange")
                        callbackList.removeIf({item => item[1] == uri})
                    }
                }
            }
        }
    }

    func getSelfBundleInfo(): FfiBundleInfo {
        let bundleFlags = BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY | // for appName
            BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE | // for appName
                BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO| // for appId
                BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION // for appInfo
        let bundleInfo = BundleManager.getBundleInfoForSelf(bundleFlags)
        let bundleName = bundleInfo.name
        let appId = bundleInfo.signatureInfo.appId
        let labelId = bundleInfo.appInfo.labelId
        let stgContext = getStageContext(context)
        let resourceMgrObject = ResourceManager.getResourceManager(stgContext)
        let appName = resourceMgrObject.getString(UInt32(labelId))

        FfiBundleInfo(bundleName, appName, appId)
    }

    /**
     * Create a save dialog to save photos
     *
     * @param { Array<string> } srcFileUris - List of the file uris to be saved
     * @param { Array<PhotoCreationConfig> } photoCreationConfigs - List of the photo asset creation configs
     * @returns { Promise<Array<string>> } - Returns the media library file uri list to application which has been authorized
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - Internal system error
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func showAssetsCreationDialog(srcFileUris: Array<String>, photoCreationConfigs: Array<PhotoCreationConfig>,
        callback: Callback1Argument<Array<String>>): Unit {
        unsafe {
            let cSrcFileUris = toArrayCString(srcFileUris)
            try {
                let cPhotoCreationConfigs = CPhotoCreationConfigs(photoCreationConfigs)
                let wrapper = {
                    value: RetDataCArrString =>
                    let data = value.data.toStringArray()
                    callback.invoke(None, data)
                }
                let lambdaData = Callback1Param<RetDataCArrString, Unit>(wrapper)
                var errCode = 0i32
                let cBundleInfo = getSelfBundleInfo()
                FfiPhotoAccessHelperShowAssetsCreationDialog(getID(), cSrcFileUris, cPhotoCreationConfigs,
                    lambdaData.getID(), cBundleInfo, inout errCode)
                cPhotoCreationConfigs.free()
                cBundleInfo.free()
                checkRet(errCode, "showAssetsCreationDialog")
            } finally {
                cSrcFileUris.free()
            }
        }
    }

    /**
     * Applies media changes.
     *
     * @param { MediaChangeRequest } mediaChangeRequest - Request for asset changes or album changes.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        since: "22",
        permission: "ohos.WRITE_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func applyChanges(mediaChangeRequest: MediaChangeRequest): Unit {
        match (mediaChangeRequest) {
            case v: MediaAlbumChangeRequest => v.applyChanges()
            case v: MediaAssetChangeRequest => v.applyChanges()
            case _ => throw BusinessException(401, "Parameter error.")
        }
    }
}
