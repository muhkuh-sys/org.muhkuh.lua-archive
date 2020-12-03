-- This test takes a GZIP compressed chunk of data, which is encoded as BASE64.
-- It decodes the BASE64 to binary and decompresses the result with GZIP.
local archive = require 'archive'

-- This is a short text from the libarchive homepage, compressed with GZIP and
-- encoded in base64.
-- Write the lines to a.txt and decode it in the shell with...
--   cat a.txt | base64 -d | gzip -d
local strPackedData = [[
H4sIANXXyF8AA01RUW7FIAz73ylygKr3mDRtZ0ghhWhAqhBe1dsvbKrWvyjYjm0+eEMNmV8E3CFz
yuWCKnEU1BXeDU7sEKlzahRhV6lgmWCjxK1xS2ACFb+dbaBU0FzJFQj7NZ8wRmh0wn1jF61oHbBF
CFIPpd5ZGmBJomy59hU+xWiBLCe9SBc/h+Z6IcOhkhTr32Z06lD+3YcsMldnZofed3gGaD64F2cs
0AX6OA5RA25PfhQnNzFIA9UpRE8gtgsOVOMwi7mdrPC1e4yhU/m3lh7Nn2c6H8PBckPdSgtlRC/R
5Sb2eZu7KW/DZhVRgBpuhbyU8kTdmbbLP2THUWx9+wHeJGK6vwEAAA==
]]

-- Add the base64 header or the uu/base64 modul does not know what this is.
local strPackedBase64Data = 'begin-base64 644 -\n' .. strPackedData .. '\n===='

-- Create a new archive.
local tArchive = archive.ArchiveRead()
-- Add the filters required for our task. We need...
--  * uu to decode base64
--  * gzip to decompress
tArchive:support_filter_uu()
tArchive:support_filter_gzip()
-- Add the required format.
tArchive:support_format_raw()
-- Set format and filters to disable the auto detection.
tArchive:set_format(archive.ARCHIVE_FORMAT_RAW)
tArchive:append_filter(archive.ARCHIVE_FILTER_UU)
tArchive:append_filter(archive.ARCHIVE_FILTER_GZIP)
-- Open the compressed data in strPackedData.
local tResult = tArchive:open_memory(strPackedBase64Data)
if tResult~=0 then
  print(tArchive:error_string())
else
  -- Get the first header. This should be the decoded an decompressed data.
  local tEntry = tArchive:next_header()
  if tEntry==nil then
    error('no content found.')
  else
    -- Read the data in chunks of 16k and collect it in a table.
    local tFileData = {}
    for strData in tArchive:iter_data(16384) do
      table.insert(tFileData, strData)
    end
    local strFileData = table.concat(tFileData)
    -- Just print the data.
    print(string.format("***\n%s\n***", strFileData))

    -- Expect only one entry.
    tEntry = tArchive:next_header()
    if tEntry~=nil then
      error('Unexpected data found.')
    end
  end
end
