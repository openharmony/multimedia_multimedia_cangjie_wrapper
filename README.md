# multimedia_cangjie_wrapper

## Introduction

The media subsystem provides developers with a simple and easy-to-understand interface, allowing them to easily access the system and use the system's media resources. The Cangjie interface of the OS media software includes pictures, cameras, albums, and video-related media services. The currently open OS media software Cangjie interface only supports standard devices.

## System Architecture

**Figure 1** OS media software Cangjie architecture diagram

![OS media software Cangjie architecture diagram](figures/multimedia_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

Interface:

- Camera Management Interface: Provide a camera operation interface to support preview, take photos and record videos.
- Image Process Interface: Supports the encoding and decoding of common image formats.
- Media Services Interface: Provide apps with the ability to get video thumbnails.
- Photo Album Management Interface: Supports local and distributed media data creation, access, and modification of albums.

Framework:

- Camera Management Wrapper: Provides Implementation encapsulation of Cangjie Preview, take photos and videos, providing Preview, take photos and videos capabilities.
- Image Process Wrapper: Provides Implementation encapsulation of Cangjie Image codec, providing Image codec capabilities.
- Media Services Wrapper: Provides Implementation encapsulation of Cangjie Get video thumbnails, providing Get video thumbnails capabilities.
- Photo Album Management Wrapper: Provides Implementation encapsulation of Cangjie Create, access, modify albums, providing Create, access, modify albums capabilities.

- Explanation of Dependencies in the Architecture Diagram:

- Camera: Responsible for providing basic camera functions, and providing C-interface to Cangjie for interoperability.
- Image: Responsible for providing basic image functions, and providing the package C interface to Cangjie for interoperability.
- Media: Responsible for providing basic media functions, encapsulating C interfaces for Cangjie for interoperability.
- MediaLibrary: Responsible for providing the basic functions of the album, and providing the package C interface to Cangjie for interoperability.
- hiviewdfx_cangjie_wrapper: Responsible for providing logging interfaces, which are used to print logs at key points in the execution path.
- graphic_cangjie_wrapper: Responsible for providing color management type definitions, which are used for parameters and return types of interfaces related to the camera and image modules.
- global_cangjie_wrapper: Responsible for providing resource management interfaces, which are used for interface parameter types of image resource acquisition.
- distributeddatamgr_cangjie_wrapper: Responsible for providing data sharing predicate definitions, which are used for configuration parameters of album interface acquisition in the album module.
- bundlemanager_cangjie_wrapper: Responsible for providing package management interfaces, which are used to obtain package information in the interface implementation of the album module.
- ability_cangjie_wrapper: Responsible for providing meta-ability context interfaces, which are used for parameters and return types of relevant interfaces in each module.
- cangjie_ark_interop: Responsible for providing Cangjie APILevel class definitions, which are used to annotate APIs, as well as providing the definition of BusinessException class that is thrown to users.

## Directory Structure

The structure of the repository directory is as follows:

```
foundation/multimedia/multimedia_cangjie_wrapper
├── figures                         # architecture pictures
├── kit                             # Cangjie Multimedia Kit interface
│   ├── CameraKit
│   ├── ImageKit
│   ├── MediaKit
│   └── MediaLibraryKit
├── ohos                            # Cangjie Multimedia code
│   ├── file
│   │   └── photo_access_helper     # The interfaces for create, access, and modify albums.
│   └── multimedia
│       ├── camera                  # The Interfaces for previewing, taking photos, and recording videos.
│       ├── image                   # The Interfaces for image encoding and decoding.
│       └── media                   # The Interfaces for retrieving video thumbnails.
└── test                            # Cangjie test cases
    ├── camera                      # camera test cases
    ├── image                       # image test cases
    ├── media                       # media test cases
    └── photo_accesshelper          # photo_accesshelper test cases
```

## Usage Guidelines

The current OS media software Cangjie interface provides the following functions:

- Preview, take photos and videos.
- Get picture information.
- Image codec.
- Get video thumbnails.
- Create, access, modify albums.

See Camera Management APIs[Camera Management](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/CameraKit/cj-apis-multimedia-camera.md). For guidance, please refer to[Camera Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/camera/cj-camera-overview.md).

See Image Process APIs[Image Process](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ImageKit/cj-apis-image.md). For guidance, please refer to[Image Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/image/cj-image-overview.md).

See Media Services APIs[Media Services](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/MediaKit/cj-apis-multimedia_media.md). For guidance, please refer to[Media Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/media/cj-media-kit-intro.md).

See Photo Album Management APIs[Photo Album Management](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/MediaLibraryKit/cj-apis-multimedia-photo_accesshelper.md). For guidance, please refer to[Photo Album Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/medialibrary/cj-photoAccessHelper-systemAlbum-guidelines.md).

## Constraints

Hardware-based decoding and encoding functions of audio and video data are device-specific.

Compared with ArkTS:

- In Camera Management, the following functions are not supported at the moment:
  - Flashlight mode.
  - Settings for picture quality, color space parameters, etc.

- In Image Process, the following functions are not supported at the moment:
  - Multi-graph objects.
  - Image metadata.

- In Media Services, the following functions are not supported at the moment:
  - Audio and video playback.
  - Audio and video recording.
  - Video transcoding.
  - Get audio and video metadata.
  - Screen recording.

- Audio Kit, AVCodec Kit, AVSession Kit, DRM Kit, Ringtone Kit and Scan Kit are not supported temporarily.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[bundlemanager_cangjie_wrapper](https://gitcode.com/openharmony-sig/bundlemanager_bundlemanager_cangjie_wrapper)

[distributeddatamgr_cangjie_wrapper](https://gitcode.com/openharmony-sig/distributeddatamgr_distributeddatamgr_cangjie_wrapper)

[global_cangjie_wrapper](https://gitcode.com/openharmony-sig/global_global_cangjie_wrapper)

[graphic_cangjie_wrapper](https://gitcode.com/openharmony-sig/graphic_graphic_cangjie_wrapper)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_camera_framework](https://gitcode.com/openharmony/multimedia_camera_framework)

[multimedia_image_framework](https://gitcode.com/openharmony/multimedia_image_framework)

[multimedia_media_library](https://gitcode.com/openharmony/multimedia_media_library)

[multimedia_player_framework](https://gitcode.com/openharmony/multimedia_player_framework)
