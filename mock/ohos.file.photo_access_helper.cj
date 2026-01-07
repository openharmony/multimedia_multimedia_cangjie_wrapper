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

package ohos.file.photo_access_helper

import ohos.app.ability.ui_ability.*
import ohos.callback_invoke.*
import ohos.data.data_share_predicates.*
import ohos.labels.*
import ohos.multimedia.image.*
import std.collection.*

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public open class AbsAlbum {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop albumType: AlbumType {
        
        get() {
            return AlbumType.User
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop albumSubtype: AlbumSubtype {
        
        get() {
            return AlbumSubtype.UserGeneric
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public mut prop albumName: String {
        
        get() {
            return String()
        }
        
        set(_) {}
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop albumUri: String {
        
        get() {
            return String()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop count: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop coverUri: String {
        
        get() {
            return String()
        }
    }

    @!APILevel[since: "22", permission: "ohos.permission.READ_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getAssets(options: FetchOptions): PhotoAssetResult {
        return PhotoAssetResult()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class Album <: AbsAlbum {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop imageCount: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop videoCount: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func commitModify(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public open class FetchResult {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func getCount(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func isAfterLast(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func close(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class AlbumResult <: FetchResult {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getFirstObject(): Album {
        return Album()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getNextObject(): Album {
        return Album()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getLastObject(): Album {
        return Album()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getObjectByPosition(index: Int32): Album {
        return Album()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getAllObjects(): Array<Album> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class PhotoAssetResult <: FetchResult {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getFirstObject(): PhotoAsset {
        return PhotoAsset()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getNextObject(): PhotoAsset {
        return PhotoAsset()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getLastObject(): PhotoAsset {
        return PhotoAsset()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getObjectByPosition(index: Int32): PhotoAsset {
        return PhotoAsset()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getAllObjects(): Array<PhotoAsset> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class MediaAlbumChangeRequest <: MediaChangeRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public init(album: Album) {
        super()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func getAlbum(): Album {
        return Album()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func setAlbumName(name: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func addAssets(assets: Array<PhotoAsset>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func removeAssets(assets: Array<PhotoAsset>): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public interface MediaChangeRequest {}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class MediaAssetChangeRequest <: MediaChangeRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public init(asset: PhotoAsset) {
        super()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public static func createImageAssetRequest(context: UIAbilityContext, fileUri: String): MediaAssetChangeRequest {
        return MediaAssetChangeRequest(PhotoAsset())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public static func createVideoAssetRequest(context: UIAbilityContext, fileUri: String): MediaAssetChangeRequest {
        return MediaAssetChangeRequest(PhotoAsset())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public static func createAssetRequest(context: UIAbilityContext, photoType: PhotoType, extension: String,
        options!: CreateOptions = CreateOptions(title: "", subtype: Default)): MediaAssetChangeRequest {
        return MediaAssetChangeRequest(PhotoAsset())
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public static func deleteAssets(context: UIAbilityContext, assets: Array<PhotoAsset>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public static func deleteAssets(context: UIAbilityContext, assets: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func getAsset(): PhotoAsset {
        return PhotoAsset()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func setTitle(title: String): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getWriteCacheHandler(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func addResource(resourceType: ResourceType, fileUri: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func addResource(resourceType: ResourceType, data: Array<Byte>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func saveCameraPhoto(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func discardCameraPhoto(): Unit {
        return ()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
public func getPhotoAccessHelper(context: UIAbilityContext): PhotoAccessHelper {
    return PhotoAccessHelper()
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class PhotoAccessHelper {
    @!APILevel[since: "22", permission: "ohos.permission.READ_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getAssets(options: FetchOptions): PhotoAssetResult {
        return PhotoAssetResult()
    }

    @!APILevel[since: "22", permission: "ohos.permission.READ_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getBurstAssets(burstKey: String, options: FetchOptions): PhotoAssetResult {
        return PhotoAssetResult()
    }

    @!APILevel[since: "22", permission: "ohos.permission.READ_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getAlbums(albumType: AlbumType, subtype: AlbumSubtype,
        options!: FetchOptions = FetchOptions(["uri", "album_name"], DataSharePredicates())): AlbumResult {
        return AlbumResult()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func registerChange(uri: String, forChildUris: Bool, callback: Callback1Argument<ChangeData>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func unregisterChange(uri: String, callback!: ?Callback1Argument<ChangeData> = None): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func showAssetsCreationDialog(srcFileUris: Array<String>, photoCreationConfigs: Array<PhotoCreationConfig>,
        callback: Callback1Argument<Array<String>>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func release(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func applyChanges(mediaChangeRequest: MediaChangeRequest): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum AlbumSubtype {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    UserGeneric
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Favorite
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Video
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Image
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    AnyAlbum
    | ...
}

extend AlbumSubtype <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend AlbumSubtype <: Equatable<AlbumSubtype> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: AlbumSubtype): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: AlbumSubtype): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum AlbumType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    User
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    System
    | ...
}

extend AlbumType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend AlbumType <: Equatable<AlbumType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: AlbumType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: AlbumType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class FetchOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var fetchColumns: Array<String>

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var predicates: DataSharePredicates

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public init(fetchColumns: Array<String>, predicates: DataSharePredicates) {
        super()
        this.fetchColumns = Array()
        this.predicates = DataSharePredicates()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum PhotoSubtype {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Default
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    MovingPhoto
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Burst
    | ...
}

extend PhotoSubtype <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend PhotoSubtype <: Equatable<PhotoSubtype> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: PhotoSubtype): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: PhotoSubtype): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum DeliveryMode {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    FastMode
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    HighQualityMode
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    BalanceMode
    | ...
}

extend DeliveryMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend DeliveryMode <: Equatable<DeliveryMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: DeliveryMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: DeliveryMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum PhotoViewMimeTypes {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    ImageType
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    VideoType
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    ImageVideoType
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    MovingPhotoImageType
    | ...
}

extend PhotoViewMimeTypes <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend PhotoViewMimeTypes <: Equatable<PhotoViewMimeTypes> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: PhotoViewMimeTypes): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: PhotoViewMimeTypes): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum RecommendationType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    QrOrBarCode
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    QrCode
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    BarCode
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    IdCard
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    ProfilePicture
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Passport
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    BankCard
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DriverLicense
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DrivingLicense
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    FeaturedSinglePortrait
    | ...
}

extend RecommendationType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend RecommendationType <: Equatable<RecommendationType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: RecommendationType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: RecommendationType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum DynamicRangeType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Sdr
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Hdr
    | ...
}

extend DynamicRangeType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend DynamicRangeType <: Equatable<DynamicRangeType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: DynamicRangeType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: DynamicRangeType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum ResourceType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    ImageResource
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    VideoResource
    | ...
}

extend ResourceType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend ResourceType <: Equatable<ResourceType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: ResourceType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: ResourceType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class PhotoCreationConfig {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var fileNameExtension: String

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var photoType: PhotoType

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var title: String

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var subtype: PhotoSubtype

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public init(fileNameExtension: String, photoType: PhotoType, title!: String = "", subtype!: PhotoSubtype = Default) {
        super()
        this.fileNameExtension = String()
        this.photoType = PhotoType.Image
        this.title = String()
        this.subtype = PhotoSubtype.Default
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum NotifyType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    NotifyAdd
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    NotifyUpdate
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    NotifyRemove
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    NotifyAlbumAddAsset
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    NotifyAlbumRemoveAsset
    | ...
}

extend NotifyType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend NotifyType <: Equatable<NotifyType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: NotifyType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: NotifyType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class ChangeData {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var notifyType: NotifyType

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var uris: Array<String>

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var extraUris: Array<String>
    
    public init() {
        super()
        this.notifyType = NotifyType.NotifyAdd
        this.uris = Array()
        this.extraUris = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class CreateOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var title: String = ""

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var subtype: PhotoSubtype

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public init(title!: String = "", subtype!: PhotoSubtype = Default) {
        super()
        this.title = String()
        this.subtype = PhotoSubtype.Default
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class RequestOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public var deliveryMode: DeliveryMode
    
    public init() {
        super()
        this.deliveryMode = DeliveryMode.FastMode
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum PhotoKeys <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Uri
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    PhotoType
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DisplayName
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Size
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DateAdded
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DateModified
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Duration
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Width
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Height
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DateTaken
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Orientation
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Favorite
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Title
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DateAddedMs
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DateModifiedMs
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    PhotoSubtype
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DynamicRangeType
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    CoverPosition
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    BurstKey
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    LcdSize
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    ThumbnailSize
    | ...

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend PhotoKeys <: Equatable<PhotoKeys> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: PhotoKeys): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: PhotoKeys): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum DefaultChangeUri <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DefaultPhotoUri
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    DefaultAlbumUri
    | ...

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend DefaultChangeUri <: Equatable<DefaultChangeUri> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: DefaultChangeUri): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: DefaultChangeUri): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum AlbumKeys <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Uri
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    AlbumName
    | ...

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend AlbumKeys <: Equatable<AlbumKeys> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: AlbumKeys): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: AlbumKeys): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum PhotoType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Image
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    Video
    | ...
}

extend PhotoType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public func toString(): String {
        return String()
    }
}

extend PhotoType <: Equatable<PhotoType> {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func ==(other: PhotoType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public operator func !=(other: PhotoType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public enum MemberType {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"] Int64Value(Int64)
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"] StringValue(String)
    | @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"] BoolValue(Bool)
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
public class PhotoAsset {
    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop uri: String {
        
        get() {
            return String()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop photoType: PhotoType {
        
        get() {
            return PhotoType.Image
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"]
    public prop displayName: String {
        
        get() {
            return String()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func get(member: String): MemberType {
        return MemberType.Int64Value(0)
    }

    @!APILevel[since: "22", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true]
    public func set(member: String, value: String): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.WRITE_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func commitModify(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.READ_IMAGEVIDEO", syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core", throwexception: true, workerthread: true]
    public func getThumbnail(size!: ?Size = Size(256, 256)): PixelMap {
        return PixelMap()
    }
    
    public init() {
        super()
    }
}