#############################
# App Name:ASUSBrowser
# Support ndk: arm x86
#############################

LOCAL_PATH := $(my-dir)

my_archs := arm x86
my_src_arch := $(call get-prebuilt-src-arch, $(my_archs))

############################
# app(ASUSBrowser.apk)
include $(CLEAR_VARS)

LOCAL_MODULE := ASUSBrowser
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

# override package
LOCAL_OVERRIDES_PACKAGES := :null

# ODEX
LOCAL_DEX_PREOPT := $(call local_odex_status, $(LOCAL_MODULE))

#### BEGIN: Libs ####
my_src_abi := $(call local_cpu_abi,$(LOCAL_PATH),$(LOCAL_MODULE),$(my_src_arch))

# Support to extract JNI libs from prebuilt AP
LOCAL_PREBUILT_JNI_LIBS := \
    libs/$(my_src_abi)/libtrendmicro_jni.so

ifeq ($(filter none, $(my_src_arch)),)
# libs 32/64 bit
LOCAL_MODULE_TARGET_ARCH := $(my_src_arch)
else
$(warning The native libs of $(LOCAL_MODULE) do not support CPU ABI for $(TARGET_PROJECT))
endif
#### END: Libs ####

include $(BUILD_PREBUILT)
############################

