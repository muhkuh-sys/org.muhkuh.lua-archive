local archive = require 'archive'
local pl = require'pl.import_into'()

local strArchive = 'test_create_archive_from_files.tar.xz'
local astrArchiveInput = {
  'test_contents/a.lua',
  'test_contents/b.lua'
}

-- Create a read disk object.
local tReader = archive.ArchiveReadDisk()

-- Create a new archive.
local tArchive = archive.ArchiveWrite()
tArchive:set_format_gnutar()
tArchive:add_filter_xz()
tArchive:open_filename(strArchive)

for _, strEntryPath in ipairs(astrArchiveInput) do
  tEntry = tReader:entry_from_file(strEntryPath)
  if tEntry==nil then
    error('Failed to read ' .. strEntryPath)
  end
  print(tEntry:size(), strEntryPath)
  tArchive:write_header(tEntry)

  -- Copy the data.
  local tFile, strError = io.open(strEntryPath, 'rb')
  if tFile==nil then
    error(string.format('Failed to open "%s" for reading: %s', strEntryPath, tostring(strError)))
  end
  -- Copy the data in chunks of 16k. Just in case we meet terabyte files here.
  repeat
    local strData = tFile:read(16384)
    if strData~=nil then
      tArchive:write_data(strData)
    end
  until strData==nil

  -- Finish the entry.
  tArchive:finish_entry()
end

tArchive:close()
tReader:close()
