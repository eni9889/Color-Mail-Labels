ifeq ($(shell [ -f ./framework/makefiles/common.mk ] && echo 1 || echo 0),0)
all clean package install::
	git submodule update --init
	./framework/git-submodule-recur.sh init
	$(MAKE) $(MAKEFLAGS) MAKELEVEL=0 $@
else
GO_EASY_ON_ME=1

TWEAK_NAME = maillbl
maillbl_OBJC_FILES = Tweak.m
maillbl_FRAMEWORKS = UIKit QuartzCore Foundation CoreGraphics

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

endif
