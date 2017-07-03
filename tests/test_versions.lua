require 'archive'


print(string.format("version number: %d", archive.version_number()))
print(string.format("version string: %s", archive.version_string()))
print(string.format("version details: %s", archive.version_details()))
print()

local strZLIB_version = archive.zlib_version() or "none"
local strLIBLZMA_version = archive.liblzma_version() or "none"
local strBZLIB_version = archive.bzlib_version() or "none"
local strLIBLZ4_version = archive.liblz4_version() or "none"

print(string.format("zlib version: %s", strZLIB_version))
print(string.format("liblzma version: %s", strLIBLZMA_version))
print(string.format("bzlib version: %s", strBZLIB_version))
print(string.format("liblz4 version: %s", strLIBLZ4_version))
