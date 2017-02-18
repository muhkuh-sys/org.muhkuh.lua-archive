require 'archive'


print(string.format("version number: %d", archive.version_number()))
print(string.format("version string: %s", archive.version_string()))
print(string.format("version details: %s", archive.version_details()))
print()
print(string.format("zlib version: %s", archive.zlib_version()))
print(string.format("liblzma version: %s", archive.liblzma_version()))
print(string.format("bzlib version: %s", archive.bzlib_version()))
print(string.format("liblz4 version: %s", archive.liblz4_version()))
