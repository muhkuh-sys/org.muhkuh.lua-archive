#include "wrapper.h"


int version_number(void)
{
	return archive_version_number();
}



const char* version_string(void)
{
	return archive_version_string();
}



const char* version_details(void)
{
	return archive_version_details();
}



const char* zlib_version(void)
{
	return archive_zlib_version();
}



const char* liblzma_version(void)
{
	return archive_liblzma_version();
}



const char* bzlib_version(void)
{
	return archive_bzlib_version();
}



const char* liblz4_version(void)
{
	return archive_liblz4_version();
}



/*--------------------------------------------------------------------------*/


ArchiveEntry::ArchiveEntry(void)
 : m_ptArchiveEntry(NULL)
{
	m_ptArchiveEntry = archive_entry_new();
}



ArchiveEntry::ArchiveEntry(struct archive_entry *ptArchiveEntry)
 : m_ptArchiveEntry(NULL)
{
	m_ptArchiveEntry = archive_entry_clone(ptArchiveEntry);
}



ArchiveEntry::~ArchiveEntry(void)
{
	printf("~archive_entry\n");
	if( m_ptArchiveEntry!=NULL )
	{
		archive_entry_free(m_ptArchiveEntry);
		m_ptArchiveEntry = NULL;
	}
}



time_t ArchiveEntry::atime(void)
{
	return archive_entry_atime(m_ptArchiveEntry);
}



long ArchiveEntry::atime_nsec(void)
{
	return archive_entry_atime_nsec(m_ptArchiveEntry);
}



int ArchiveEntry::atime_is_set(void)
{
	return archive_entry_atime_is_set(m_ptArchiveEntry);
}



time_t ArchiveEntry::birthtime(void)
{
	return archive_entry_birthtime(m_ptArchiveEntry);
}



long ArchiveEntry::birthtime_nsec(void)
{
	return archive_entry_birthtime_nsec(m_ptArchiveEntry);
}



int ArchiveEntry::birthtime_is_set(void)
{
	return archive_entry_birthtime_is_set(m_ptArchiveEntry);
}



time_t ArchiveEntry::ctime(void)
{
	return archive_entry_ctime(m_ptArchiveEntry);
}



long ArchiveEntry::ctime_nsec(void)
{
	return archive_entry_ctime_nsec(m_ptArchiveEntry);
}



int ArchiveEntry::ctime_is_set(void)
{
	return archive_entry_ctime_is_set(m_ptArchiveEntry);
}



dev_t ArchiveEntry::dev(void)
{
	return archive_entry_dev(m_ptArchiveEntry);
}



int ArchiveEntry::dev_is_set(void)
{
	return archive_entry_dev_is_set(m_ptArchiveEntry);
}



dev_t ArchiveEntry::devmajor(void)
{
	return archive_entry_devmajor(m_ptArchiveEntry);
}



dev_t ArchiveEntry::devminor(void)
{
	return archive_entry_devminor(m_ptArchiveEntry);
}



__LA_MODE_T ArchiveEntry::filetype(void)
{
	return archive_entry_filetype(m_ptArchiveEntry);
}



const char* ArchiveEntry::fflags_text(void)
{
	return archive_entry_fflags_text(m_ptArchiveEntry);
}



int64_t ArchiveEntry::gid(void)
{
	return archive_entry_gid(m_ptArchiveEntry);
}



const char* ArchiveEntry::gname(void)
{
	return archive_entry_gname(m_ptArchiveEntry);
}



const char* ArchiveEntry::gname_utf8(void)
{
	return archive_entry_gname_utf8(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::gname_w(void)
{
	return archive_entry_gname_w(m_ptArchiveEntry);
}



const char* ArchiveEntry::hardlink(void)
{
	return archive_entry_hardlink(m_ptArchiveEntry);
}



const char* ArchiveEntry::hardlink_utf8(void)
{
	return archive_entry_hardlink_utf8(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::hardlink_w(void)
{
	return archive_entry_hardlink_w(m_ptArchiveEntry);
}



int64_t ArchiveEntry::ino(void)
{
	return archive_entry_ino(m_ptArchiveEntry);
}



int64_t ArchiveEntry::ino64(void)
{
	return archive_entry_ino64(m_ptArchiveEntry);
}



int ArchiveEntry::ino_is_set(void)
{
	return archive_entry_ino_is_set(m_ptArchiveEntry);
}



__LA_MODE_T ArchiveEntry::mode(void)
{
	return archive_entry_mode(m_ptArchiveEntry);
}



time_t ArchiveEntry::mtime(void)
{
	return archive_entry_mtime(m_ptArchiveEntry);
}



long ArchiveEntry::mtime_nsec(void)
{
	return archive_entry_mtime_nsec(m_ptArchiveEntry);
}



int ArchiveEntry::mtime_is_set(void)
{
	return archive_entry_mtime_is_set(m_ptArchiveEntry);
}



unsigned int ArchiveEntry::nlink(void)
{
	return archive_entry_nlink(m_ptArchiveEntry);
}



const char* ArchiveEntry::pathname(void)
{
	return archive_entry_pathname(m_ptArchiveEntry);
}



const char* ArchiveEntry::pathname_utf8(void)
{
	return archive_entry_pathname_utf8(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::pathname_w(void)
{
	return archive_entry_pathname_w(m_ptArchiveEntry);
}



__LA_MODE_T ArchiveEntry::perm(void)
{
	return archive_entry_perm(m_ptArchiveEntry);
}



dev_t ArchiveEntry::rdev(void)
{
	return archive_entry_rdev(m_ptArchiveEntry);
}



dev_t ArchiveEntry::rdevmajor(void)
{
	return archive_entry_rdevmajor(m_ptArchiveEntry);
}



dev_t ArchiveEntry::rdevminor(void)
{
	return archive_entry_rdevminor(m_ptArchiveEntry);
}



const char* ArchiveEntry::sourcepath(void)
{
	return archive_entry_sourcepath(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::sourcepath_w(void)
{
	return archive_entry_sourcepath_w(m_ptArchiveEntry);
}



int64_t ArchiveEntry::size(void)
{
	return archive_entry_size(m_ptArchiveEntry);
}



int ArchiveEntry::size_is_set(void)
{
	return archive_entry_size_is_set(m_ptArchiveEntry);
}



const char* ArchiveEntry::strmode(void)
{
	return archive_entry_strmode(m_ptArchiveEntry);
}



const char* ArchiveEntry::symlink(void)
{
	return archive_entry_symlink(m_ptArchiveEntry);
}



const char* ArchiveEntry::symlink_utf8(void)
{
	return archive_entry_symlink_utf8(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::symlink_w(void)
{
	return archive_entry_symlink_w(m_ptArchiveEntry);
}



int64_t ArchiveEntry::uid(void)
{
	return archive_entry_uid(m_ptArchiveEntry);
}



const char* ArchiveEntry::uname(void)
{
	return archive_entry_uname(m_ptArchiveEntry);
}



const char* ArchiveEntry::uname_utf8(void)
{
	return archive_entry_uname_utf8(m_ptArchiveEntry);
}



const wchar_t* ArchiveEntry::uname_w(void)
{
	return archive_entry_uname_w(m_ptArchiveEntry);
}



int ArchiveEntry::is_data_encrypted(void)
{
	return archive_entry_is_data_encrypted(m_ptArchiveEntry);
}



int ArchiveEntry::is_metadata_encrypted(void)
{
	return archive_entry_is_metadata_encrypted(m_ptArchiveEntry);
}



int ArchiveEntry::is_encrypted(void)
{
	return archive_entry_is_encrypted(m_ptArchiveEntry);
}




/*--------------------------------------------------------------------------*/


Archive::Archive(void)
 : m_ptArchive(NULL)
{
	/* Allocate a new archive structure. */
	m_ptArchive = archive_read_new();
}



Archive::~Archive(void)
{
	int iResult;


	printf("~archive\n");

	if( m_ptArchive!=NULL )
	{
		iResult = archive_read_free(m_ptArchive);
		if( iResult!=ARCHIVE_OK )
		{
			printf("Failed to free the archive structure!\n");
		}
		m_ptArchive = NULL;
	}
}



int Archive::read_support_filter_all(void)
{
	return archive_read_support_filter_all(m_ptArchive);
}



int Archive::read_support_format_all(void)
{
	return archive_read_support_format_all(m_ptArchive);
}



int Archive::read_open_filename(const char *_filename, size_t _block_size)
{
	return archive_read_open_filename(m_ptArchive, _filename, _block_size);
}



ArchiveEntry *Archive::read_next_header(void)
{
	int iResult;
	struct archive_entry* ptArchiveEntryStruct;
	ArchiveEntry *ptArchiveEntryClass;


	ptArchiveEntryClass = NULL;

	iResult = archive_read_next_header(m_ptArchive, &ptArchiveEntryStruct);
	if( iResult==ARCHIVE_OK )
	{
		ptArchiveEntryClass = new ArchiveEntry(ptArchiveEntryStruct);
	}

	return ptArchiveEntryClass;
}



int Archive::read_data_skip(void)
{
	return archive_read_data_skip(m_ptArchive);
}



