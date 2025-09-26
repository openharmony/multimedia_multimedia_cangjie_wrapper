# OS媒体软件仓颉封装

## 简介

在OpenHarmnoy平台上，OS媒体软件仓颉封装为开发者提供了使用仓颉语言进行应用开发时所需的媒体相关的能力。媒体子系统为开发者提供一套简单且易于理解的接口，使得开发者能够方便地接入系统并使用系统的媒体资源。OS媒体软件仓颉接口包含了图片，相机，相册，视频相关媒体业务。当前开放的OS媒体软件仓颉接口仅支持standard设备。

## 系统架构

**图 1** OS媒体软件仓颉架构图

![OS媒体软件仓颉架构图](figures/multimedia_cangjie_wrapper_architecture.png)

如架构图所示：

接口层：

- 相机管理接口：提供相机操作接口，支持预览、拍照、录像，控制闪光灯和曝光事件，对焦和调焦和视频防抖。
- 图片处理接口：支持获取图片信息以及常见图片格式的编解码。
- 媒体服务接口：为应用提供获取视频缩略图的功能。
- 相册管理接口：支持获取相册及其包含的图片，获取相册属性，修改相册以及监听相册变更。

框架层：

- 相机管理封装：仓颉相机管理的实现封装，提供预览，拍照和录像，控制闪光灯和曝光事件，对焦和调焦和视频防抖的能力。
- 图片处理封装：仓颉图片处理的实现封装，提供获取图片信息以及图片编解码的能力。
- 媒体服务封装：仓颉媒体服务的实现封装，提供获取视频缩略图的能力。
- 相册管理封装：仓颉相册管理的实现封装，提供获取相册及其包含的图片，获取相册属性，修改相册以及监听相册变更的能力。

架构图中的依赖部件引入说明：

- Camera组件：负责提供相机基础功能，相机管理封装依赖其提供相机基础功能。
- Image组件：负责提供图片处理基础功能，图片处理封装依赖其提供图片处理基础功能。
- 媒体组件：负责提供媒体基础功能，媒体服务封装依赖其提供媒体服务相关功能。
- MediaLibrary组件：负责提供相册基础功能，相册管理封装依赖其提供操作相册的相关功能。
- hiviewdfx_cangjie_wrapper：负责提供日志接口，用于在关键路径处打印日志。
- graphic_cangjie_wrapper：负责提供颜色管理类型定义，用于相机和图片模块相关接口的参数、返回类型。
- global_cangjie_wrapper：负责提供资源管理接口，用于获取图片资源的接口参数类型。
- distributeddatamgr_cangjie_wrapper：负责提供数据共享谓词定义，用于相册模块获取相册接口的配置参数。
- bundlemanager_cangjie_wrapper：负责提供包管理接口，用户相册模块接口实现中获取包信息。
- ability_cangjie_wrapper：负责提供元能力上下文接口，用于各模块相关接口的参数、返回类型。
- cangjie_ark_interop：负责提供仓颉注解类定义，用于对API进行标注，以及提供抛向用户的BusinessException异常类定义。

## 目录

仓目录结构如下：

```
foundation/multimedia/multimedia_cangjie_wrapper
├── figures                         # 存放README中的架构图
├── kit                             # 仓颉媒体kit化接口
│   ├── CameraKit
│   ├── ImageKit
│   ├── MediaKit
│   └── MediaLibraryKit
├── ohos                            # 仓颉媒体接口实现
│   ├── file
│   │   └── photo_access_helper     # 创建、访问、修改相册相关接口
│   └── multimedia
│       ├── camera                  # 预览、拍照和录像相关接口
│       ├── image                   # 图片编解码相关接口
│       └── media                   # 获取视频缩略图相关接口
└── test                            # 仓颉测试用例
    ├── camera                      # camera测试用例
    ├── image                       # image测试用例
    ├── media                       # media测试用例
    └── photo_accesshelper          # photo_accesshelper测试用例
```

## 使用说明

当前OS媒体软件仓颉接口提供了以下功能：

- 相机管理：
  - 预览、拍照和录像。
  - 控制闪光灯和曝光事件。
  - 对焦和调焦。
  - 视频防抖。

- 图片处理：
  - 获取图片信息。
  - 图片编解码。

- 媒体服务：
  - 获取视频缩略图。

- 相册管理：
  - 获取相册及其包含的图片。
  - 获取相册属性。
  - 修改相册。
  - 监听相册变更。

相机管理相关API请参见[相机管理](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/CameraKit/cj-apis-multimedia-camera.md)，相关指导请参见[相机开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/media/camera/cj-camera-preparation.md)。

图片处理相关API请参见[图片处理](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ImageKit/cj-apis-image.md)，相关指导请参见[图片开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/media/image/cj-image-overview.md)。

媒体服务相关API请参见[媒体服务](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/MediaKit/cj-apis-multimedia_media.md)，相关指导请参见[媒体开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/media/media/cj-media-kit-intro.md)。

相册管理相关API请参见[相册管理模块](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/MediaLibraryKit/cj-apis-multimedia-photo_accesshelper.md)，相关指导请参见[相册开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/media/medialibrary/cj-photoAccessHelper-systemAlbum-guidelines.md)。

## 约束

部分音视频格式的硬件编码、解码功能依赖设备的支持。

与ArkTS提供的API能力相比：

- 相机管理暂不支持以下功能：
  - 安全相机。

- 图片处理暂不支持以下功能：
  - 多图对象。
  - 图像元数据。

- 媒体服务暂不支持以下功能：
  - 音视频播放。
  - 音视频录制。
  - 视频转码。
  - 获取音视频元数据。
  - 屏幕录制。

- 暂不支持音频服务、音视频编解码服务、音视频播控服务、数字版权保护服务、铃声服务和统一扫码服务。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

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
