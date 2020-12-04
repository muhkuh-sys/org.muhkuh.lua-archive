cmake_minimum_required(VERSION 2.8)

PROJECT("external")

#----------------------------------------------------------------------------
#
# Include the projects in the subdirectories.
#
ADD_SUBDIRECTORY(bzip2)
ADD_SUBDIRECTORY(lz4)
ADD_SUBDIRECTORY(lzma)
ADD_SUBDIRECTORY(zstd)

# NOTE: Do not build libarchive with LZO. It's GPL license conflicts with the other packages.

ADD_SUBDIRECTORY(libarchive)


#----------------------------------------------------------------------------
