local archive = require 'archive'
local lfs = require 'lfs'

-- Remember the current working directory.
local strCurrentWorkingDirectory = lfs.currentdir()
-- Create a new subfolder "test_extract".
lfs.mkdir('test_extract')
-- Change to the new folder.
lfs.chdir('test_extract')


local tArc = archive.ArchiveRead()
tArc:support_filter_all()
tArc:support_format_all()

local iFlags = archive.ARCHIVE_EXTRACT_NO_OVERWRITE + archive.ARCHIVE_EXTRACT_SECURE_NODOTDOT + archive.ARCHIVE_EXTRACT_SECURE_NOABSOLUTEPATHS

local r = tArc:open_filename("../archive.tar.gz", 16384)
if r~=0 then
	print(tArc:error_string())
else
	for tEntry in tArc:iter_header() do
		print(string.format("Extractingt %s...", tEntry:pathname()))
		tArc:extract(tEntry, iFlags)
	end
end


-- Go back to the old working directory.
lfs.chdir(strCurrentWorkingDirectory)
