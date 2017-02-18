require 'archive'


local tArc = archive.ArchiveRead()
tArc:support_filter_all()
tArc:support_format_all()

local r = tArc:open_filename("archive.tar.gz", 16384)
if r~=0 then
	print(tArc:error_string())
else
	print('Archive contents:')

	while true do
		tEntry = tArc:next_header()
		if tEntry==nil then
			break
		end
		print(tEntry:size(), tEntry:pathname())
		tArc:data_skip()
	end
end
