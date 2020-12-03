-- This test takes a demo test from the libarchive homepage, compresses it with
-- GZIP and encodes the result in BASE64.
-- It uses the "open_memory" function to create the compressed data in memory
-- and not in a file.
local archive = require 'archive'

local strData = [[
Libarchive is highly modular. It was designed from the beginning to make it relatively easy to add new archive formats and compression algorithms. Note, however, that each program that uses libarchive chooses which formats it wants to use, so support in libarchive does not guarantee support in any particular program. Of course, the bsdtar and bsdcpio programs included in the libarchive distribution do enable all libarchive formats by default.
]]

-- Create a new archive.
local tArchive = archive.ArchiveWrite()
-- Output only the data from the filters.
tArchive:set_format_raw()
-- Filter the input data with GZIP and then BASE64.
tArchive:add_filter_gzip()
tArchive:add_filter_b64encode()
-- Provide a buffer which is large enough for the compressed data.
-- NOTE: 2 * the size of the input data is way to much.
tArchive:open_memory(string.len(strData)*2)

-- Now create a new archive entry - even if we do not have a real archive here.
-- It is necessary to set the filetype of the entry to "regular file", or no
-- data will arrive on the output side.
local tEntry = archive.ArchiveEntry()
tEntry:set_filetype(archive.AE_IFREG)
-- First write the header, then the data, the finish the entry.
tArchive:write_header(tEntry)
tArchive:write_data(strData)
tArchive:finish_entry()
-- Write only one entry, as this is no real archive.
tArchive:close()

-- Get the compressed and encoded data.
local strCompressed = tArchive:get_memory()
print(strCompressed)
