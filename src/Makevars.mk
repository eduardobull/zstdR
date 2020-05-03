ZSTD_VERSION=1.4.4

ZSTD_SRC_DIR:=$(shell pwd)/third_party/zstd-${ZSTD_VERSION}
ZSTD_BUILD_DIR:=$(shell mktemp -d -t zstd_build_XXXXXX)
