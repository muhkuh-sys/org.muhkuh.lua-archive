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
		while true do
			local strData = tArc:read_data(16)
			if strData==nil then
				break
			end
			table.insert(tFileData, strData)
		end
		local strFileData = table.concat(tFileData)
		print(string.format("***\n%s\n***", strFileData))
	end
end
