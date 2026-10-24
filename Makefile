# Only opt-in .deb packaging lives here; the AOSP build uses Android.bp.
all:
	@echo "Usage: command make deb | deb-dev | deb-static"

-include $(CURDIR)/deb.mk
