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

#
# dexdump, similar in purpose to objdump.
#
LOCAL_PATH:= $(call my-dir)

dexdump_src_files := DexDump.cpp
dexdump_c_includes := dalvik

dexdump_static_libraries_sdk := \
    libdex \
    libbase

dexdump_static_libraries := \
    $(dexdump_static_libraries_sdk) \
    libutils \
    liblog

##
##
## Build the device command line tool dexdump
##
##
ifneq ($(SDK_ONLY),true)  # SDK_only doesn't need device version

include $(CLEAR_VARS)
LOCAL_MODULE := dexdump
LOCAL_SRC_FILES := $(dexdump_src_files)
LOCAL_C_INCLUDES := $(dexdump_c_includes)
LOCAL_SHARED_LIBRARIES := libz liblog libutils
LOCAL_STATIC_LIBRARIES := $(dexdump_static_libraries_sdk)
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE_TAGS := optional
LOCAL_LDLIBS +=
LOCAL_32_BIT_ONLY := true
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
include $(BUILD_EXECUTABLE)

endif # !SDK_ONLY


##
##
## Build the host command line tool dexdump
##
##
include $(CLEAR_VARS)
LOCAL_MODULE := dexdump
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(dexdump_src_files)
LOCAL_C_INCLUDES := $(dexdump_c_includes)
LOCAL_STATIC_LIBRARIES := $(dexdump_static_libraries)
ifneq ($(strip $(USE_MINGW)),)
LOCAL_STATIC_LIBRARIES += libz
else
LOCAL_LDLIBS += -lpthread -lz
endif
# TODO: Move dexdump from libdex to libart and lose the 32-bit limitation.
LOCAL_32_BIT_ONLY := true
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
include $(BUILD_HOST_EXECUTABLE)
