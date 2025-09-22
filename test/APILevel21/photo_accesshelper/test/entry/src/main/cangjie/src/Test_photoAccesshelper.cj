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

/**
 * Created on 2024/11/11
 */
package ohos_app_cangjie_entry

internal import ohos.base.*
internal import MediaLibraryKit.*
import std.unittest.testmacro.*
internal import ArkData.*
import ImageKit.ImageSource
import ohos.file.fs.FileIo as  FileFs
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import std.collection.HashMap
import std.collection.map
import std.collection.collectArray
import std.collection.forEach
import ohos.ability_access_ctrl.Permissions
import ohos.hilog.*
import ohos.callback_invoke.*
import ohos.business_exception.*
import CoreFileKit.*

public class MyCallback<T> <: Callback1Argument<T> {
    public let callabck_: (T) -> Unit
    public init(callabck: (T) -> Unit) {
        callabck_ = callabck
    }
    public func invoke(err: ?BusinessException, arg: T): Unit {
        callabck_(arg)
    }
}

@Test
class Test_photoAccesshelper {
    var _photoAccessHelper: ?PhotoAccessHelper = None
    prop photoAccessHelper: PhotoAccessHelper {
        get() {
            match (_photoAccessHelper) {
                case Some(photoAccessHelper) => photoAccessHelper
                case None =>
                    let photoAccessHelper = getPhotoAccessHelper(getAbilityContext())
                    _photoAccessHelper = photoAccessHelper
                    photoAccessHelper
            }
        }
    }

    override func beforeAll(): Unit {
        ["ohos.permission.READ_IMAGEVIDEO", "ohos.permission.WRITE_IMAGEVIDEO"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            getRequiredPermissions([permissionName])
            sleep(Duration.second * 1i64)
            try {
                click(at: Screen
                    .getTheOnlyUiComponentWhoseTextEqualsTo("允许")
                    .centerPoint)
                sleep(Duration.second * 1i64)
            } catch (e: Exception) {}
        }
    }

    override func afterAll(): Unit {
        photoAccessHelper.release()
    }

    /**
     * 测试：photoAccessHelper.getAssets 正常功能
     * 预置条件1：图库中存在不少于3张照片
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_FetchResult_PhotoAsset() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let count = fetchResult.getCount()
            @Expect(count >= 3)

            let firstPhotoAsset = fetchResult.getFirstObject()
            let firstPhotoAssetUri = firstPhotoAsset.uri
            let firstPhotoAssetPhotoType = firstPhotoAsset
                .photoType
                .toString()
            let firstPhotoAssetDisplayName = firstPhotoAsset.displayName
            @Expect(firstPhotoAssetUri.contains(firstPhotoAssetDisplayName))
            @Expect(PhotoType.Image != PhotoType.Video)

            let isAfterLast = fetchResult.isAfterLast()
            @Expect(!isAfterLast)
            let nextPhotoAsset = fetchResult.getNextObject()
            let lastPhotoAsset = fetchResult.getLastObject()
            let positionPhotoAsset = fetchResult.getObjectByPosition(1)
            @Expect(nextPhotoAsset.displayName == positionPhotoAsset.displayName)
            let photoAssetArray = fetchResult.getAllObjects()
            @Expect(photoAssetArray.size == Int64(count))
            fetchResult.close()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 PhotoAsset 正常功能
     * 预置条件2：图库中存在照片
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_PhotoAsset() {
        try {
            let predicates = DataSharePredicates()
            loggerInfo("DataSharePredicates init success!")
            let fetchColumns = [
                PhotoKeys.Title.toString(),
                PhotoKeys.Size.toString(),
                PhotoKeys.DateAdded.toString(),
                PhotoKeys.DateModified.toString(),
                PhotoKeys.Duration.toString(),
                PhotoKeys.Height.toString(),
                PhotoKeys.Width.toString(),
                PhotoKeys.DateTaken.toString(),
                PhotoKeys.Orientation.toString(),
                PhotoKeys.Favorite.toString(),
                PhotoKeys.DateAddedMs.toString(),
                PhotoKeys.DateModifiedMs.toString(),
                PhotoKeys.DynamicRangeType.toString(),
                PhotoKeys.CoverPosition.toString(),
                PhotoKeys.BurstKey.toString(),
                PhotoKeys.LcdSize.toString(),
                PhotoKeys.ThmSize.toString(),
                PhotoKeys.Uri.toString(),
                PhotoKeys.PhotoType.toString(),
                PhotoKeys.DisplayName.toString(),
                PhotoKeys.PhotoSubtype.toString()
            ]
            let fetchOptions: FetchOptions = FetchOptions(fetchColumns, predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let count = fetchResult.getCount()
            @Expect(count > 0)
            let firstPhotoAsset = fetchResult.getFirstObject()
            let photoAssetUri = firstPhotoAsset.get("uri")
            let photoAssetMediaType = firstPhotoAsset.get('media_type')
            let photoAssetSubtype = firstPhotoAsset.get('subtype')
            let photoAssetDisplayName = firstPhotoAsset.get('display_name')
            let photoAssetDateAdd = firstPhotoAsset.get('date_added')
            let photoAssetDateModified = firstPhotoAsset.get('date_modified')
            let photoAssetDuration = firstPhotoAsset.get('duration')
            let photoAssetWidth = firstPhotoAsset.get('width')
            let photoAssetHeight = firstPhotoAsset.get('height')
            let photoAssetDateTaken = firstPhotoAsset.get('date_taken')
            let photoAssetOrientation = firstPhotoAsset.get('orientation')
            let photoAssetIsfavorite = firstPhotoAsset.get('is_favorite')
            let photoAssetDateAddedMs = firstPhotoAsset.get('date_added_ms')
            let photoAssetDateModifiedMs = firstPhotoAsset.get('date_modified_ms')
            let photoAssetDynamicRangeType = firstPhotoAsset.get('dynamic_range_type')
            let photoAssetCover_position = firstPhotoAsset.get('cover_position')
            let photoAssetBurst_key = firstPhotoAsset.get('burst_key')
            let photoAssetLcdSize = firstPhotoAsset.get('lcd_size')
            let photoAssetThmSize = firstPhotoAsset.get('thumb_size')

            let newTitle = "123456789"
            firstPhotoAsset.set("title", newTitle)
            firstPhotoAsset.commitModify()
            let tt = match (firstPhotoAsset.get("title")) {
                case StringValue(v) => v
                case _ => throw IllegalArgumentException(
                    "This data is not String type. Please use to obtain the value.")
            }
            @Expect(tt == newTitle)
            let pixm = firstPhotoAsset.getThumbnail()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 getBurstAssets 正常功能
     * 预置条件3：图库中存在连拍照片
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_GetBurstAssets() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions(['burst_key'], predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let photoAssetArray = fetchResult.getAllObjects()
            for (asset in photoAssetArray) {
                let burstKey = match (asset.get("burst_key")) {
                    case StringValue(v) => v
                    case _ => throw IllegalArgumentException(
                        "This data is not String type. Please use to obtain the value.")
                }
                if (burstKey.size > 0) { // 连拍照片才有这个字段
                    let burstResult: PhotoAssetResult = photoAccessHelper.getBurstAssets(burstKey, fetchOptions)
                    let count = burstResult.getCount()
                    @Expect(count > 0)
                }
            }
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 AlbumResult 正常功能
     * 预置条件4：存在一个名为test4的相册，并且其中包含两张照片
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_FetchResult_Album() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: AlbumResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric,
                options: fetchOptions)
            let count = fetchResult.getCount()
            @Expect(count >= 1)
            let firstAlbum = fetchResult.getFirstObject()
            let photoCount = firstAlbum.count
            @Expect(photoCount >= 2)
            let coverUri = firstAlbum.coverUri
            let albumName = firstAlbum.albumName
            let albumUri = firstAlbum.albumUri
            let albumType = firstAlbum.albumType.toString()
            @Expect(firstAlbum.albumType == AlbumType.User)
            let albumSubtype = firstAlbum.albumSubtype.toString()
            @Expect(firstAlbum.albumSubtype == AlbumSubtype.UserGeneric)
            let imageCount = firstAlbum.imageCount
            let videoCount = firstAlbum.videoCount
            @Expect(imageCount >= 0)
            @Expect(videoCount >= 0)
            fetchResult.close()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 SYSTEM Album 正常功能
     * 预置条件5：存在收藏夹，并且其中包含照片；图库中存在视频和照片
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_SYSTEM_Album() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult1: AlbumResult = photoAccessHelper.getAlbums(AlbumType.System, AlbumSubtype.AnyAlbum,
                options: fetchOptions)
            @Expect(fetchResult1.getCount() >= 4) // 系统相册有4个
            fetchResult1.close()

            let fetchResult2: AlbumResult = photoAccessHelper.getAlbums(AlbumType.System, AlbumSubtype.Favorite,
                options: fetchOptions)
            @Expect(fetchResult2.getCount() >= 1) // 收藏夹有1个
            fetchResult2.close()

            let fetchResult3: AlbumResult = photoAccessHelper.getAlbums(AlbumType.System, AlbumSubtype.Video,
                options: fetchOptions)
            @Expect(fetchResult3.getCount() >= 1) // 视频相册有1个
            let firstAlbum3 = fetchResult3.getFirstObject()
            @Expect(firstAlbum3.albumType == AlbumType.System)
            @Expect(firstAlbum3.albumSubtype == AlbumSubtype.Video)
            fetchResult3.close()

            let fetchResult4: AlbumResult = photoAccessHelper.getAlbums(AlbumType.System, AlbumSubtype.Image,
                options: fetchOptions)
            @Expect(fetchResult4.getCount() >= 1) // 图库相册有1个
            let firstAlbum4 = fetchResult4.getFirstObject()
            @Expect(firstAlbum4.albumSubtype == AlbumSubtype.Image)
            fetchResult4.close()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 Album 正常功能
     * 预置条件6：存在一个名为test1的相册
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_Album() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult: AlbumResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric,
            options: fetchOptions)
        let albumCount = fetchResult.getCount()
        @Expect(albumCount >= 1)
        let firstAlbum = fetchResult.getFirstObject()
        let photoCount = firstAlbum.count
        let predicates1 = DataSharePredicates()
        let fetchOptions1: FetchOptions = FetchOptions([], predicates1)
        let fetchResult1: PhotoAssetResult = firstAlbum.getAssets(fetchOptions1)
        let count = fetchResult1.getCount()
        let arrObject = fetchResult1.getAllObjects()
        fetchResult.close()
    }

    /**
     * 测试 Album 修改功能
     * 预置条件7：存在一个名为test2的相册
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_AlbumModify() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: AlbumResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.AnyAlbum,
                options: fetchOptions)
            let albumCount = fetchResult.getCount()
            loggerInfo("fetchResult getAlbumCount success: ${albumCount}")
            if (albumCount > 0) {
                let albums = fetchResult.getAllObjects()
                for (album in albums) {
                    if (album.albumName == "test2") {
                        album.albumName = "test10087"
                        album.commitModify()
                    }
                }
            }
            fetchResult.close()

            let fetchResult1: AlbumResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.AnyAlbum,
                options: fetchOptions)
            let albumCount1 = fetchResult1.getCount()
            loggerInfo("fetchResult getAlbumCount success: ${albumCount}")
            if (albumCount1 > 0) {
                let albums1 = fetchResult1.getAllObjects()
                for (album in albums1) {
                    if (album.albumName == "test10087") {
                        album.albumName = "test2"
                        album.commitModify()
                    }
                }
            }
            fetchResult1.close()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 SYSTEM Album 修改功能
     * 预置条件8：无
     * 期望结果：修改系统相册名称会报错 14000011 System inner fail
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_SYSTEM_AlbumModify() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: AlbumResult = photoAccessHelper.getAlbums(AlbumType.System, AlbumSubtype.AnyAlbum,
                options: fetchOptions)
            let albumCount = fetchResult.getCount()
            @Expect(albumCount >= 4)
            let firstAlbum = fetchResult.getFirstObject()
            firstAlbum.albumName = "test98765"
            firstAlbum.commitModify()
            fetchResult.close()
        } catch (e: Exception) {
            @Expect(true)
        }
    }

    /**
     * 测试 registerChange 注册回调功能
     * 预置条件9：图库中存在照片和视频
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_registerChange() {
        try {
            let predicates = DataSharePredicates()
            loggerInfo("DataSharePredicates init success!")
            let fetchOptions: FetchOptions = FetchOptions(['title'], predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let count = fetchResult.getCount()
            @Expect(count >= 1)
            let firstPhotoAsset = fetchResult.getFirstObject()

            let callback1 = MyCallback<ChangeData>(
                {
                    arg: ChangeData => loggerInfo(
                        "onCallback1. ChangeData: type = ${arg.notifyType.toString()}, uris.size: ${arg.uris.size}, extraUris.size = ${arg.extraUris.size}")
                })
            let callback2 = MyCallback<ChangeData>(
                {
                    arg: ChangeData => loggerInfo(
                        "onCallback2. ChangeData: type = ${arg.notifyType.toString()}, uris.size: ${arg.uris.size}, extraUris.size = ${arg.extraUris.size}")
                })

            photoAccessHelper.registerChange(firstPhotoAsset.uri, false, callback1)
            photoAccessHelper.registerChange(firstPhotoAsset.uri, false, callback2)
            let title = match (firstPhotoAsset.get('title')) {
                case StringValue(v) => v
                case _ => throw IllegalArgumentException(
                    "This data is not String type. Please use to obtain the value.")
            }
            // 触发回调
            firstPhotoAsset.set("title", "987654321")
            firstPhotoAsset.commitModify()
            firstPhotoAsset.set("title", title)
            firstPhotoAsset.commitModify()
            photoAccessHelper.unRegisterChange(firstPhotoAsset.uri, callback: callback2)
            photoAccessHelper.unRegisterChange(firstPhotoAsset.uri)
            @Expect(NotifyType.NotifyAdd != NotifyType.NotifyRemove)
            @Expect(NotifyType.NotifyAlbumAddAsset != NotifyType.NotifyAlbumRemoveAsset)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 测试 showAssetsCreationDialog 功能
     * 预置条件10：无，该用例会拉起弹框，需手动点击允许或禁止
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_showAssetsCreationDialog() {
        let callback3 = MyCallback<Array<String>>(
            {
                arg: Array<String> =>
                loggerInfo("oncallback3: Array.size: ${arg.size}")
                for (str in arg) {
                    loggerInfo("oncallback3: uri: ${str}")
                }
            }
        )
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let LastPhotoAsset = fetchResult.getLastObject()
            let srcFileUris: Array<String> = [LastPhotoAsset.uri];
            let photoCreationConfigs: Array<PhotoCreationConfig> = [
                PhotoCreationConfig(
                    'jpg',
                    PhotoType.Image,
                    title: "test56",
                    subtype: PhotoSubtype.Default
                )
            ]
            photoAccessHelper.showAssetsCreationDialog(srcFileUris, photoCreationConfigs, callback3)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    /**
     * 请求第一个相册，改名
     * 预置条件13：存在相册test1
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_album_change_request_album() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric, options: fetchOptions)
        let albumCount = fetchResult.getCount()
        loggerInfo("fetchResult getAlbumCount success: ${albumCount}")
        if (albumCount > 0) {
            let albums = fetchResult.getAllObjects()
            for (album in albums) {
                if (album.albumName == "test1") {
                    let albumChangeRequest = MediaAlbumChangeRequest(album)
                    var changeRequestAlbum = albumChangeRequest.getAlbum()
                    @Expect(changeRequestAlbum.albumName, "test1")
                    let newAlbumName = "test10086"
                    albumChangeRequest.setAlbumName(newAlbumName)
                    photoAccessHelper.applyChanges(albumChangeRequest)
                    @Expect(changeRequestAlbum.albumName, "test10086")
                }
            }
        }

        // 还原
        let fetchResult1 = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric, options: fetchOptions)
        let albumCount1 = fetchResult1.getCount()
        loggerInfo("fetchResult getAlbumCount success: ${albumCount}")
        if (albumCount1 > 0) {
            let albums1 = fetchResult1.getAllObjects()
            for (album in albums1) {
                if (album.albumName == "test10086") {
                    let albumChangeRequest = MediaAlbumChangeRequest(album)
                    var changeRequestAlbum = albumChangeRequest.getAlbum()
                    @Expect(changeRequestAlbum.albumName, "test10086")
                    let newAlbumName = "test1"
                    albumChangeRequest.setAlbumName(newAlbumName)
                    photoAccessHelper.applyChanges(albumChangeRequest)
                    @Expect(changeRequestAlbum.albumName, "test1")
                }
            }
        }
    }

    /**
     * 往第一个用户相册中添加图片
     * 预置条件14：存在相册，第一张照片标题为123456789.jpg
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_album_change_request_addAsset() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult = photoAccessHelper.getAssets(fetchOptions)
        let asset = fetchResult.getFirstObject()
        @Expect(asset.displayName, "123456789.jpg")
        let albumFetchResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric)
        let album = albumFetchResult.getFirstObject()
        let albumChangeRequest = MediaAlbumChangeRequest(album)
        albumChangeRequest.addAssets([asset, asset])
        photoAccessHelper.applyChanges(albumChangeRequest)
    }

    /**
     * 删除用户相册得到某张图片
     * 预置条件15：存在用户相册，且其中的第一张照片名称为123456789.jpg
     */
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_album_change_request_removeAsset() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let albumFetchResult = photoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric)
        let album = albumFetchResult.getFirstObject()
        let fetchResult = album.getAssets(fetchOptions)
        let asset = fetchResult.getFirstObject()
        let albumChangeRequest = MediaAlbumChangeRequest(album)
        albumChangeRequest.removeAssets([asset])
        photoAccessHelper.applyChanges(albumChangeRequest)
    }

    // 获取图片，改名
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_asset_change_request_constructor(): Unit {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult = photoAccessHelper.getAssets(fetchOptions)
        let photoAsset = fetchResult.getFirstObject()
        let assetChangeRequest = MediaAssetChangeRequest(photoAsset)
        let asset = assetChangeRequest.getAsset()
        let oldName = asset.displayName
        let newTitle = "newTitle_" + oldName
        assetChangeRequest.setTitle(newTitle)
        assetChangeRequest.saveCameraPhoto()
        assetChangeRequest.discardCameraPhoto()
        photoAccessHelper.applyChanges(assetChangeRequest)
        @Expect(asset.displayName, newTitle + ".jpg")
    }

    // 根据路径创建图片
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_createImageAssetRequest() {
        try {
            let pathDir = getAbilityContext().filesDir
            let fileName = "test1"
            let filePath = pathDir + "/${fileName}.jpg"
            FileIo.createRandomAccessFile(filePath, mode: OpenMode.CREATE)
            let fileUri = getUriFromPath(filePath) // "file://com.example.myapplication/data/storage/el2/base/haps/entry/files/test.jpg"
            let assetChangeRequest = MediaAssetChangeRequest.createImageAssetRequest(getAbilityContext(), fileUri)
            photoAccessHelper.applyChanges(assetChangeRequest)
            try {
                assetChangeRequest.addResource(ImageResource, fileUri)
            } catch (e: Exception) {}
        } catch (e: BusinessException) {
            loggerInfo("createImageAssetRequest error:  ${e}")
            @Expect(false)
        }
    }

    // 根据路径创建MP4
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_createVideoAssetRequest() {
        try {
            let pathDir = getAbilityContext().filesDir
            let fileName = "test2"
            let filePath = pathDir + "/${fileName}.mp4"
            FileIo.createRandomAccessFile(filePath, mode: OpenMode.CREATE)
            let fileUri = getUriFromPath(filePath) // "file://com.example.myapplication/data/storage/el2/base/haps/entry/files/test.mp4"
            let assetChangeRequest = MediaAssetChangeRequest.createVideoAssetRequest(getAbilityContext(), fileUri)
            photoAccessHelper.applyChanges(assetChangeRequest)
            try {
                let fd = assetChangeRequest.getWriteCacheHandler()
                FileFs.close(fd)
            } catch (e: Exception) {}
        } catch (e: BusinessException) {
            loggerInfo("createVideoAssetRequest error:  ${e}")
            @Expect(false)
        }
    }

    // 根据路径创建图片
    // 预置条件: 在/data/app/el2/100/base/com.example.myapplication/haps/entry/files/下有test.jpg文件
    @TestCase
    @Tag[APILevel21, TestLevel0]
    @Skip
    func test_asset_change_request_createAssetRequest_uri() {
        let photoType = PhotoType.Image
        let extension = "jpg"
        let options = CreateOptions(title: "testPhoto")
        let assetChangeRequest = MediaAssetChangeRequest.createAssetRequest(getAbilityContext(), photoType, extension,
            options: options)
        let fileUri = "/data/storage/el2/base/haps/entry/files/test.jpg"
        assetChangeRequest.addResource(ImageResource, fileUri)
        photoAccessHelper.applyChanges(assetChangeRequest)
    }

    // 根据数组创建图片
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_createAssetRequest_buffer() {
        let photoType = PhotoType.Image
        let extension = "jpg"
        let assetChangeRequest = MediaAssetChangeRequest.createAssetRequest(getAbilityContext(), photoType, extension)
        let buffer = Array<Byte>(2048, repeat: 0)
        assetChangeRequest.addResource(ImageResource, buffer)
        photoAccessHelper.applyChanges(assetChangeRequest)
    }

    // 删除图片，有确认窗口
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_deleteAssets_asset() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult = photoAccessHelper.getAssets(fetchOptions)
        let photoAssetList = fetchResult.getAllObjects()
        MediaAssetChangeRequest.deleteAssets(getAbilityContext(), photoAssetList)
    }

    // 删除图片，有确认窗口
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_deleteAssets_uri() {
        let predicates = DataSharePredicates()
        let fetchOptions: FetchOptions = FetchOptions([], predicates)
        let fetchResult = photoAccessHelper.getAssets(fetchOptions)
        let asset = fetchResult.getFirstObject()
        MediaAssetChangeRequest.deleteAssets(getAbilityContext(),
            "file://media/Photo/46/IMG_1731494171_034/IMG_20241113_183431.jpg")
    }

    // 创建mp4
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_asset_change_request_getWriteCacheHandler() {
        try {
            let assetChangeRequest = MediaAssetChangeRequest.createAssetRequest(getAbilityContext(), PhotoType.Video, "mp4")
            let fd = assetChangeRequest.getWriteCacheHandler()
            FileFs.close(fd)
            photoAccessHelper.applyChanges(assetChangeRequest)
            try {
                let fd = assetChangeRequest.getWriteCacheHandler()
                FileFs.close(fd)
            } catch (e: Exception) {}
        } catch (e: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_AlbumSubtype(): Unit {
        let arr1: Array<AlbumSubtype> = [UserGeneric, Favorite, Video, Image, AlbumSubtype.AnyAlbum]
        let arr2: Array<AlbumSubtype> = [UserGeneric, Favorite, Video, Image, AlbumSubtype.AnyAlbum]
        let strArr: Array<String> = [
            "AlbumSubtype.UserGeneric",
            "AlbumSubtype.Favorite",
            "AlbumSubtype.Video",
            "AlbumSubtype.Image",
            "AlbumSubtype.AnyAlbum"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i], arr2[i])
            @Expect(arr1[i].toString(), strArr[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size], true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_AlbumType(): Unit {
        let arr1: Array<AlbumType> = [User, System]
        let arr2: Array<AlbumType> = [User, System]
        let strArr: Array<String> = [
            "AlbumType.User",
            "AlbumType.System"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i], arr2[i])
            @Expect(arr1[i].toString(), strArr[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size], true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_RecommendationType(): Unit {
        let arr1: Array<RecommendationType> = [QrOrBarCode, QrCode, BarCode, IdCard, ProfilePicture, PassPort, BankCard,
            DriverLicense, DrivingLicense, FeaturedSinglePortrait]
        let arr2: Array<RecommendationType> = [QrOrBarCode, QrCode, BarCode, IdCard, ProfilePicture, PassPort, BankCard,
            DriverLicense, DrivingLicense, FeaturedSinglePortrait]
        let strArr: Array<String> = [
            "RecommendationType.QrOrBarCode",
            "RecommendationType.QrCode",
            "RecommendationType.BarCode",
            "RecommendationType.IdCard",
            "RecommendationType.ProfilePicture",
            "RecommendationType.PassPort",
            "RecommendationType.BankCard",
            "RecommendationType.DriverLicense",
            "RecommendationType.DrivingLicense",
            "RecommendationType.FeaturedSinglePortrait"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i], arr2[i])
            @Expect(arr1[i].toString(), strArr[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size], true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_NotifyType(): Unit {
        let arr1: Array<NotifyType> = [NotifyAdd, NotifyUpdate, NotifyRemove, NotifyAlbumAddAsset,
            NotifyAlbumRemoveAsset]
        let arr2: Array<NotifyType> = [NotifyAdd, NotifyUpdate, NotifyRemove, NotifyAlbumAddAsset,
            NotifyAlbumRemoveAsset]
        let strArr: Array<String> = [
            "NotifyType.NotifyAdd",
            "NotifyType.NotifyUpdate",
            "NotifyType.NotifyRemove",
            "NotifyType.NotifyAlbumAddAsset",
            "NotifyType.NotifyAlbumRemoveAsset"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i], arr2[i])
            @Expect(arr1[i].toString(), strArr[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size], true)
        }
    }
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_PhotoKeys(): Unit {
        let arr1: Array<PhotoKeys> = [
            PhotoKeys.Uri,
            PhotoKeys.PhotoType,
            PhotoKeys.DisplayName,
            PhotoKeys.Size,
            PhotoKeys.DateAdded,
            PhotoKeys.DateModified,
            PhotoKeys.Duration,
            PhotoKeys.Width,
            PhotoKeys.Height,
            PhotoKeys.DateTaken,
            PhotoKeys.Orientation,
            PhotoKeys.Favorite,
            PhotoKeys.Title,
            PhotoKeys.DateAddedMs,
            PhotoKeys.DateModifiedMs,
            PhotoKeys.PhotoSubtype,
            PhotoKeys.DynamicRangeType,
            PhotoKeys.CoverPosition,
            PhotoKeys.BurstKey,
            PhotoKeys.LcdSize,
            PhotoKeys.ThmSize
        ]
        let strArr: Array<String> = [
            "uri",
            "media_type",
            "display_name",
            "size",
            "date_added",
            "date_modified",
            "duration",
            "width",
            "height",
            "date_taken",
            "orientation",
            "is_favorite",
            "title",
            "date_added_ms",
            "date_modified_ms",
            "subtype",
            "dynamic_range_type",
            "cover_position",
            "burst_key",
            "lcd_size",
            "thumb_size"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i], arr1[i])
            @Expect(arr1[i].toString(), strArr[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size], true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_DefaultChangeUri() {
        let arr1: Array<DefaultChangeUri> = [
            DefaultPhotoUri,
            DefaultAlbumUri
        ]
        let strArr: Array<String> = [
            "file://media/Photo",
            "file://media/PhotoAlbum"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == strArr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_enum_AlbumKeys() {
        let arr1: Array<AlbumKeys> = [
            Uri,
            AlbumName
        ]
        let strArr: Array<String> = [
            "uri",
            "album_name"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == strArr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_PhotoType() {
        let arr1: Array<PhotoType> = [
            Image,
            Video
        ]
        let arrStr: Array<String> = [
            "PhotoType.Image",
            "PhotoType.Video"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_PhotoSubtype() {
        let arr1: Array<PhotoSubtype> = [
            Default,
            MovingPhoto,
            Burst
        ]
        let arrStr: Array<String> = [
            "PhotoSubtype.Default",
            "PhotoSubtype.MovingPhoto",
            "PhotoSubtype.Burst"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_DeliveryMode() {
        let arr1: Array<DeliveryMode> = [
            FastMode,
            HighQualityMode,
            BalanceMode
        ]
        let arrStr: Array<String> = [
            "DeliveryMode.FastMode",
            "DeliveryMode.HighQualityMode",
            "DeliveryMode.BalanceMode"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_PhotoViewMIMETypes() {
        let arr1: Array<PhotoViewMIMETypes> = [
            ImageType,
            VideoType,
            ImageVideoType,
            MovingPhotoImageType
        ]
        let arrStr: Array<String> = [
            "PhotoViewMIMETypes.ImageType",
            "PhotoViewMIMETypes.VideoType",
            "PhotoViewMIMETypes.ImageVideoType",
            "PhotoViewMIMETypes.MovingPhotoImageType"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_DynamicRangeType() {
        let arr1: Array<DynamicRangeType> = [
            Sdr,
            Hdr
        ]
        let arrStr: Array<String> = [
            "DynamicRangeType.Sdr",
            "DynamicRangeType.Hdr"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_ResourceType() {
        let arr1: Array<ResourceType> = [
            ImageResource,
            VideoResource
        ]
        let arrStr: Array<String> = [
            "ResourceType.ImageResource",
            "ResourceType.VideoResource"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_class_constructor() {
        try {
            let config = PhotoCreationConfig("jpg", PhotoType.Image, title: "test4", subtype: PhotoSubtype.Default)
            @Expect(config.fileNameExtension == "jpg")
            @Expect(config.title == "test4")
            let opt = CreateOptions(title: "test", subtype: PhotoSubtype.MovingPhoto)
            @Expect(opt.title == "test")
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_fetchResult_getAssets() {
        try {
            let predicates = DataSharePredicates()
            let fetchOptions: FetchOptions = FetchOptions([], predicates)
            let fetchResult: PhotoAssetResult = photoAccessHelper.getAssets(fetchOptions)
            let count = fetchResult.getCount()
            let isAfterLast = fetchResult.isAfterLast
            fetchResult.close()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_photoAccessHelper_getBurstAssets() {
        let myPhotoAccessHelper = getPhotoAccessHelper(getAbilityContext())
        try {
            let fetchOptions: FetchOptions = FetchOptions(['burst_key'], DataSharePredicates())
            let fetchResult: PhotoAssetResult = myPhotoAccessHelper.getBurstAssets('burst_key', fetchOptions)
            myPhotoAccessHelper.release()
        } catch (e: Exception) {
            myPhotoAccessHelper.release()
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_photoAccessHelper_getAlbums() {
        let myPhotoAccessHelper = getPhotoAccessHelper(getAbilityContext())
        try {
            let fetchOptions: FetchOptions = FetchOptions([], DataSharePredicates())
            let fetchResult = myPhotoAccessHelper.getAlbums(AlbumType.User, AlbumSubtype.UserGeneric,
                options: fetchOptions)
            myPhotoAccessHelper.release()
        } catch (e: Exception) {
            myPhotoAccessHelper.release()
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_photoAccessHelper_OnOff() {
        let myPhotoAccessHelper = getPhotoAccessHelper(getAbilityContext())
        try {
            let callback1 = MyCallback<ChangeData>(
                {
                    arg: ChangeData => loggerInfo(
                        "onCallback1. ChangeData: type = ${arg.notifyType.toString()}, uris.size: ${arg.uris.size}, extraUris.size = ${arg.extraUris.size}")
                })
            myPhotoAccessHelper.registerChange("test_uri", false, callback1)
            myPhotoAccessHelper.unRegisterChange("test_uri")
            myPhotoAccessHelper.release()
        } catch (e: Exception) {
            myPhotoAccessHelper.release()
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_showAssetsCreationDialog_param_invalid() {
        let myPhotoAccessHelper = getPhotoAccessHelper(getAbilityContext())
        let callback3 = MyCallback<Array<String>>(
            {
                arg: Array<String> =>
                loggerInfo("oncallback3: Array.size: ${arg.size}")
                for (str in arg) {
                    loggerInfo("oncallback3: uri: ${str}")
                }
            }
        )
        try {
            let photoCreationConfigs: Array<PhotoCreationConfig> = [
                PhotoCreationConfig(
                    'jpg',
                    PhotoType.Image,
                    title: "test56",
                    subtype: PhotoSubtype.Default
                )
            ]
            myPhotoAccessHelper.showAssetsCreationDialog(["test_uri"], photoCreationConfigs, callback3)
        } catch (e: Exception) {
            // param invalid
            @Expect(true)
        }
    }
}
