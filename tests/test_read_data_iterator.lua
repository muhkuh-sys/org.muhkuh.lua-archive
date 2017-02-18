require 'archive'


local tArc = archive.ArchiveRead()
tArc:support_filter_all()
tArc:support_format_all()

local r = tArc:open_filename("archive.tar.gz", 16384)
if r~=0 then
	print(tArc:error_string())
else
	print('Archive contents:')

	for tEntry in tArc:iter_header() do
		print(tEntry:size(), tEntry:pathname())

		local tFileData = {}
		for strData in tArc:iter_data(16) do
			table.insert(tFileData, strData)
		end
		local strFileData = table.concat(tFileData)
		print(string.format("***\n%s\n***", strFileData))
	end

end
