# 
# Copyright (C) 2010 ARM Limited. All rights reserved.
# 
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCAL_PATH := $(call my-dir)

# HAL module implemenation, not prelinked and stored in
# hw/<OVERLAY_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)
LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_RELATIVE_PATH := hw

ifeq ($(TARGET_BOARD_PLATFORM),)
LOCAL_MODULE := gralloc.default
else
LOCAL_MODULE := gralloc.$(TARGET_BOARD_PLATFORM)
endif
LOCAL_MODULE_TAGS := optional

# Mali-200/300/400MP
SHARED_MEM_LIBS := libion libhardware
LOCAL_SHARED_LIBRARIES := liblog libcutils libGLESv1_CM $(SHARED_MEM_LIBS)

LOCAL_C_INCLUDES := system/core/include/ ../../../$(TARGET_KERNEL_SOURCE)/include 

LOCAL_CFLAGS := -DLOG_TAG=\"gralloc\" -DGRALLOC_32_BITS -DSTANDARD_LINUX_SCREEN -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)

LOCAL_SRC_FILES := \
	gralloc_module.cpp \
	gralloc_module_ion.cpp \
	alloc_device.cpp \
	alloc_ion.cpp \
	framebuffer_device.cpp

#LOCAL_CFLAGS+= -DMALI_VSYNC_EVENT_REPORT_ENABLE
include $(BUILD_SHARED_LIBRARY)
