# multimedia_cangjie_wrapper

## Introduction

The multimedia_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the multimedia Subsystem. The multimedia subsystem provides a set of simple and easy-to-use APIs for you to access the system and media resources.

Media Cangjie includes pictures, cameras, albums, and video-related media businesses.

## System Architecture

**Figure 1** Architecture of the multimedia subsystem

![](figures/multimedia_cangjie_wrapper_architecture_en.png)

## Directory Structure

The structure of the repository directory is as follows:

```
foundation/multimedia/multimedia_cangjie_wrapper
├── ohos             # Cangjie Multimedia code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

Hardware-based decoding and encoding functions of audio and video data are device-specific.The currently open distributed soft bus Cangjie interface only supports standard devices.

## Usage Guidelines

The current OS media software Cangjie interface provides the following functions:

- Preview, take photos and videos.
- Get picture information.
- Image codec.
- Get video thumbnails.
- Create, access, modify albums.

Compared with ArkTS, the following functions are not supported at the moment:

- Multi-graph objects.
- Image metadata.
- Audio and video playback.
- Audio and video recording.
- Video transcoding.
- Get audio and video metadata.
- Screen recording.

See Camera APIs[ohos.multimedia.camera (Camera Management)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/CameraKit/cj-apis-multimedia-camera.md).For guidance, please refer to[Camera Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/camera/cj-camera-overview.md).

See Image APIs[ohos.multimedia.image (Image Processing)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ImageKit/cj-apis-image.md).For guidance, please refer to[Image Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/image/cj-image-overview.md).

See Media APIs[ohos.multimedia.media (Media Service)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/MediaKit/cj-apis-multimedia_media.md).For guidance, please refer to[Media Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/media/media/cj-media-kit-intro.md).

See MediaLibrary APIs[ohos.multimedia.photo_accesshelper (Photo Album Management Module)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/MediaLibraryKit/cj-apis-multimedia-photo_accesshelper.md).

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[multimedia\_camera\_framework](https://gitee.com/openharmony/multimedia_camera_framework/blob/master/README.md)

[multimedia\_image\_framework](https://gitee.com/openharmony/multimedia_image_framework/blob/master/README.md)

[multimedia\_media\_library](https://gitee.com/openharmony/multimedia_media_library/blob/master/README.md)

[multimedia\_player\_framework](https://gitee.com/openharmony/multimedia_player_framework/blob/master/README.md)
