require 'archive'

local function list_archive_contents(strArchive)
  local tArc = archive.ArchiveRead()
  tArc:support_filter_all()
  tArc:support_format_all()

  print(string.format('Opening archive "%s"...', strArchive))
  local r = tArc:open_filename(strArchive, 16384)
  if r~=0 then
    error(tArc:error_string())
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
end


list_archive_contents('archive.tar.gz')
list_archive_contents('archive.tar.bz2')
list_archive_contents('archive.tar.xz')
list_archive_contents('archive.zip')
list_archive_contents('archive.7z')
