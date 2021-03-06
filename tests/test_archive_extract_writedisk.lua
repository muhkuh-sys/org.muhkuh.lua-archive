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

local tWriter = archive.ArchiveWriteDisk()
tWriter:set_options(archive.ARCHIVE_EXTRACT_NO_OVERWRITE + archive.ARCHIVE_EXTRACT_SECURE_NODOTDOT + archive.ARCHIVE_EXTRACT_SECURE_NOABSOLUTEPATHS)
tWriter:set_standard_lookup()

local r = tArc:open_filename("../archive.tar.gz", 16384)
if r~=0 then
	print(tArc:error_string())
else
	for tEntry in tArc:iter_header() do
		print(string.format("Extractingt %s...", tEntry:pathname()))

		tWriter:write_header(tEntry)

		-- Copy the data in chunks of 16 bytes.
		-- NOTE: The value 16 in the read_data call was chosen to test reading and writing multiple chunks with the small demo archives.
		--       This is much too small for production code as the performance goes down.
		--       Increase it to 16383 (16kByte) in production code.
		while true do
			local strData = tArc:read_data(16) -- Use 16384 for production code.
			if strData==nil then
				break
			end
			tWriter:write_data(strData)
		end
		tWriter:finish_entry()
	end
end

tWriter:close()

-- Go back to the old working directory.
lfs.chdir(strCurrentWorkingDirectory)
