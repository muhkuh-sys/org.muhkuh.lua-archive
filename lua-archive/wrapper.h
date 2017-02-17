#include "archive.h"
#include "archive_entry.h"

#include <stdint.h>


#ifndef __WRAPPER_H__
#define __WRAPPER_H__


int version_number(void);
const char* version_string(void);
const char* version_details(void);

const char* zlib_version(void);
const char* liblzma_version(void);
const char* bzlib_version(void);
const char* liblz4_version(void);


class ArchiveEntry
{
public:
	ArchiveEntry(void);
	ArchiveEntry(struct archive_entry *ptArchiveEntry);
	~ArchiveEntry(void);


	time_t         atime(void);
	long           atime_nsec(void);
	int            atime_is_set(void);
	time_t         birthtime(void);
	long           birthtime_nsec(void);
	int            birthtime_is_set(void);
	time_t         ctime(void);
	long           ctime_nsec(void);
	int            ctime_is_set(void);
	dev_t          dev(void);
	int            dev_is_set(void);
	dev_t          devmajor(void);
	dev_t          devminor(void);
	__LA_MODE_T    filetype(void);
#if 0
	void           fflags(void,
                            unsigned long * /* set */,
                            unsigned long * /* clear */);
#endif
	const char    *fflags_text(void);
	int64_t        gid(void);
	const char    *gname(void);
	const char    *gname_utf8(void);
	const wchar_t *gname_w(void);
	const char    *hardlink(void);
	const char    *hardlink_utf8(void);
	const wchar_t *hardlink_w(void);
	int64_t        ino(void);
	int64_t        ino64(void);
	int            ino_is_set(void);
	__LA_MODE_T    mode(void);
	time_t         mtime(void);
	long           mtime_nsec(void);
	int            mtime_is_set(void);
	unsigned int   nlink(void);
	const char    *pathname(void);
	const char    *pathname_utf8(void);
	const wchar_t *pathname_w(void);
	__LA_MODE_T    perm(void);
	dev_t          rdev(void);
	dev_t          rdevmajor(void);
	dev_t          rdevminor(void);
	const char    *sourcepath(void);
	const wchar_t *sourcepath_w(void);
	int64_t        size(void);
	int            size_is_set(void);
	const char    *strmode(void);
	const char    *symlink(void);
	const char    *symlink_utf8(void);
	const wchar_t *symlink_w(void);
	int64_t        uid(void);
	const char    *uname(void);
	const char    *uname_utf8(void);
	const wchar_t *uname_w(void);
	int            is_data_encrypted(void);
	int            is_metadata_encrypted(void);
	int            is_encrypted(void);


private:
	struct archive_entry *m_ptArchiveEntry;
};



class Archive
{
public:
	Archive(void);
	~Archive(void);

	int read_support_filter_all(void);
	int read_support_format_all(void);

	int read_open_filename(const char *_filename, size_t _block_size);

	ArchiveEntry *read_next_header(void);

	int read_data_skip(void);


private:
	struct archive *m_ptArchive;
};


#endif  /* __WRAPPER_H__ */
