PROJECT_NAME := nina-fw-homekit

EXTRA_COMPONENT_DIRS := $(PWD)/arduino
EXTRA_COMPONENT_DIRS += $(PWD)/arduino/libraries/
EXTRA_COMPONENT_DIRS += $(PWD)/arduino/libraries/Homekit

CPPFLAGS += -DARDUINO

ifeq ($(RELEASE),1)
CFLAGS += -DNDEBUG -DCONFIG_FREERTOS_ASSERT_DISABLE -Os -DLOG_LOCAL_LEVEL=0
CPPFLAGS += -DNDEBUG -Os
endif

ifeq ($(UNO_WIFI_REV2),1)
CFLAGS += -DUNO_WIFI_REV2
CPPFLAGS += -DUNO_WIFI_REV2
endif

ifeq ($(NANO_RP2040_CONNECT),1)
CFLAGS += -DNANO_RP2040_CONNECT
CPPFLAGS += -DNANO_RP2040_CONNECT
endif

include $(IDF_PATH)/make/project.mk

firmware: all
	python combine.py

.PHONY: firmware
