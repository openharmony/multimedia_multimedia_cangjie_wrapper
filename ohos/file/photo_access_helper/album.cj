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

/**
 * Defines the abstract interface of albums.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public open class AbsAlbum <: RemoteDataLite{
    protected init(id: Int64) {
        super(id)
    }
    /**
     * Album type
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop albumType: AlbumType {
        get() {
            unsafe {
                let ret = FfiPhotoAlbumGetPhotoAlbumType(getID())
                AlbumType.parse(ret)
            }
        }
    }

    /**
     * Album subtype
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop albumSubtype: AlbumSubtype {
        get() {
            unsafe {
                let ret = FfiPhotoAlbumGetPhotoAlbumSubType(getID())
                AlbumSubtype.parse(ret)
            }
        }
    }

    /**
     * Album name.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public mut prop albumName: String {
        get() {
            unsafe {
                let ret = FfiPhotoAlbumGetAlbumName(getID())
                let result = ret.toString()
                LibC.free(ret)
                result
            }
        }
        set(value) {
            unsafe {
                try (cValue = LibC.mallocCString(value).asResource()) {
                    FfiPhotoAlbumSetAlbumName(getID(), cValue.value)
                }
            }
        }
    }

    /**
     * Album uri.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop albumUri: String {
        get() {
            unsafe {
                let ret = FfiPhotoAlbumGetAlbumUri(getID())
                let result = ret.toString()
                LibC.free(ret)
                result
            }
        }
    }
    
    /**
     * Number of assets in the album
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop count: Int32 {
        get() {
            unsafe { FfiPhotoAlbumGetCount(getID()) }
        }
    }

    /**
     * Cover uri for the album
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop coverUri: String {
        get() {
            unsafe {
                let ret = FfiPhotoAlbumGetCoverUri(getID())
                let result = ret.toString()
                LibC.free(ret)
                result
            }
        }
    }

    /**
     * Fetch assets in an album.
     *
     * @param { FetchOptions } options - Fetch options.
     * @returns { PhotoAssetResult } Returns the fetch result
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        permission: "ohos.READ_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func getAssets(options: FetchOptions): PhotoAssetResult {
        var errCode = 0i32
        unsafe {
            let cOptions = options.toCFetchOptions()
            let id = FfiPhotoAlbumGetAssets(getID(), cOptions, inout errCode)
            cOptions.free()
            checkRet(errCode, "getAssets")
            PhotoAssetResult(id)
        }
    }

    private let impl_: AbsAlbumImpl = AbsAlbumImpl()
}

class AbsAlbumImpl {}

/**
 * Defines the album.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
]
public class Album <: AbsAlbum {
    protected init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Number of image assets in the album
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public prop imageCount: Int32 {
        get() {
            unsafe { FfiPhotoAlbumGetImageCount(getID()) }
        }
    }

    /**
     * Number of video assets in the album
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]  
    public prop videoCount: Int32 {
        get() {
            unsafe { FfiPhotoAlbumGetVideoCount(getID()) }
        }
    }

    /**
     * Modify metadata for the album
     *
     * @throws { BusinessException } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessException } 201 - Permission denied
     * @throws { BusinessException } 13900020 - Invalid argument
     * @throws { BusinessException } 14000011 - System inner fail
     */
    @!APILevel[
        22,
        permission: "ohos.WRITE_IMAGEVIDEO",
        syscap: "SystemCapability.FileManagement.PhotoAccessHelper.Core"
    ]
    public func commitModify(): Unit {
        var errCode = 0i32
        unsafe {
            FfiPhotoAlbumCommitModify(getID(), inout errCode)
            checkRet(errCode, "commitModify")
        }
    }
}
