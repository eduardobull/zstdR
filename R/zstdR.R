#' Zstandard, or zstd, compression algorithm
#'
#' @description
#'   Zstandard, or zstd as short version, is a fast lossless compression algorithm
#'   created by Facebook Inc.
#'
#'   This package provides an interface to the Zstandard C implementation.
#'
#' @param object Object to (un)compress.
#'   Will serialize the object on compression if it's not a raw vector.
#'
#' @param level Integer. Compression level.
#' @docType
#'   package
#' @name
#'   zstdR
NULL

#' @rdname zstdR
#' @export
compressZstd <- function(object, level, ...) {
  UseMethod("compressZstd", object)
}

#' @rdname zstdR
#' @export
compressZstd.default <- function(object, level = 3, ...) {
  impl_zstdCompress(serialize(object, connection = NULL), level = level)
}

#' @rdname zstdR
#' @export
compressZstd.raw <- function(object, level = 3, ...) {
  impl_zstdCompress(object, level = level)
}

#' @rdname zstdR
#' @export
uncompressZstd <- function(object, ...) {
  UseMethod("uncompressZstd", object)
}

#' @rdname zstdR
#' @export
uncompressZstd.raw <- function(object, ...) {
  unserialize(impl_zstdUncompress(object))
}
