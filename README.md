# multimedia_cangjie_wrapper

## Introduction

The multimedia_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the multimedia Subsystem. The multimedia subsystem provides a set of simple and easy-to-use APIs for you to access the system and media resources.

This subsystem offers various media services covering audio, videos, and cameras, which provide the following capabilities:

-   Audio playback and recording
-   Video playback and recording
-   Photographing and recording \(with cameras\)

## System Architecture

**Figure 1** Architecture of the multimedia subsystem

![](figures/multimedia_cangjie_wrapper_architecture_en.png)

- **Media**: provides playback and recording APIs for applications, and invokes the Gstreamer, Histreamer, or other engines through cross-process calling or direct calling.
  - For the mini system, the media component invokes Histreamer to support audio playback.
  - For the small system, the media component invokes recorder_lite to support audio/video recording and invokes player_lite by default to support audio/video playback. If the system variable **debug.media_service.histreamer** is set to **1**, the component invokes Histreamer to support audio/video playback. For details.
  - For the standard system, the media component invokes Gstreamer to support audio/video playback and recording.
- **Audio**: supports audio input and output, policy management, and audio focus management.
- **Camera**: provides camera operation APIs for preview, photographing, and video recording.
- **Image**: supports encoding and decoding of common image formats.
- **MediaLibrary**: supports local and distributed media data access management.
- **Histreamer**: a lightweight media engine that supports file/network streaming media input, audio/video decoding and playback, audio/video encoding and recording, and plugin extension.
- **Gstreamer**: an open-source GStreamer engine that supports streaming media, audio and video playback, and recording.

## Directory Structure

The structure of the repository directory is as follows:

```
foundation/multimedia/multimedia_cangjie_wrapper
├── ohos             # Cangjie Multimedia code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

Hardware-based decoding and encoding functions of audio and video data are device-specific.

## Usage Guidelines

You can use the APIs in any of the provided classes based on your development requirements.

-   For details about how to call media APIs to implement the video recording, preview, and playback.
-   For a simple player, use  **Player**  and  **Recorder**  classes to quickly implement the playback and recording features.
-   The  **CameraKit**  class provides a group of effective methods for controlling a camera, which facilitates the camera development.
-   You can create a  **CameraKit**  object and register various callbacks to respond to many events in the multimedia module. Then, create a  **Camera**  object to operate camera resources, for example, to start preview, recording, and stream capturing, and set related parameters.

## Installation

Load the kernel and related drivers before installing the repository. For details, see readme files of kernel and driver subsystems.

## Repositories Involved

[multimedia\_camera\_framework](https://gitee.com/openharmony/multimedia_camera_framework/blob/master/README.md)

[multimedia\_audio\_framework](https://gitee.com/openharmony/multimedia_audio_framework/blob/master/README.md)

[multimedia\_media\_library](https://gitee.com/openharmony/multimedia_media_library/blob/master/README.md)