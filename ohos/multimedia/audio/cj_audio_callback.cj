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

package ohos.multimedia.audio

import std.deriving.{Derive}
import ohos.business_exception.{BusinessException}

@Derive[ToString, Equatable, Hashable]
protected enum AudioCapturerCallbackType {
    AudioCapturerChange
    | AudioInterrupt
    | InputDeviceChange
    | MarkReach
    | PeriodReach
    | ReadData
    | StateChange
    | ...

    func getValue(): Int32 {
        match (this) {
            case AudioCapturerChange => 0i32
            case AudioInterrupt => 1i32
            case InputDeviceChange => 2i32
            case MarkReach => 3i32
            case PeriodReach => 4i32
            case ReadData => 5i32
            case StateChange => 6i32
            case _ => throw BusinessException(6800101, "Invalid parameter.")
        }
    }
}

@Derive[ToString, Equatable, Hashable]
protected enum AudioRoutingManagerCallbackType {
    DeviceChange
    | AvailableDeviceChange
    | PreferredInputDeviceChangeForCapturerInfo
    | PreferrOutputDeviceChangeForRendererInfo
    | ...

    func getValue(): Int32 {
        match (this) {
            case DeviceChange => 0i32
            case AvailableDeviceChange => 1i32
            case PreferredInputDeviceChangeForCapturerInfo => 2i32
            case PreferrOutputDeviceChangeForRendererInfo => 3i32
            case _ => throw BusinessException(6800101, "Invalid parameter.")
        }
    }
}