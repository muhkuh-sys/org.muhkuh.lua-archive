local archive = require 'archive'
local pl = require'pl.import_into'()

local strSourceFolder = 'test_contents'
local strArchive = 'test.tar.xz'

local strAbsSrc = pl.path.abspath(strSourceFolder)

-- Create a read disk object.
local tReader = archive.ArchiveReadDisk()
tReader:open(strAbsSrc)

-- Create a new archive.
local tArchive = archive.ArchiveWrite()
tArchive:set_format_gnutar()
tArchive:add_filter_xz()
tArchive:open_filename(strArchive)

for tEntry in tReader:iter_header() do
  -- Cut off the archive root.
  local strRelEntry = pl.path.relpath(tEntry:pathname(), strAbsSrc)
  if strRelEntry~='' then
    tEntry:set_pathname(strRelEntry)
    print(tEntry:size(), strRelEntry)
    tArchive:write_header(tEntry)
    -- Copy the data.
    for strData in tReader:iter_data(16384) do
      tArchive:write_data(strData)
    end
    -- Finish the entry.
    tArchive:finish_entry()
  end
  if tReader:can_descend()~=0 then
    tReader:descend()
  end
end

tArchive:close()
tReader:close()
