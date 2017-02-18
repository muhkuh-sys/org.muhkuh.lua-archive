#include "archive.h"
#include "archive_entry.h"

#ifdef __cplusplus
extern "C" {
#endif
#include "lua.h"
#ifdef __cplusplus
}
#endif


#include <stdint.h>



#ifndef SWIGRUNTIME
#include <swigluarun.h>
#endif



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
	int            mode(void);
	time_t         mtime(void);
	long           mtime_nsec(void);
	int            mtime_is_set(void);
	unsigned int   nlink(void);
	const char    *pathname(void);
	const char    *pathname_utf8(void);
	const wchar_t *pathname_w(void);
	int            perm(void);
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


	ArchiveEntry* set_atime(time_t, long);
	ArchiveEntry* unset_atime(void);
	ArchiveEntry* set_birthtime(time_t, long);
	ArchiveEntry* unset_birthtime(void);
	ArchiveEntry* set_ctime(time_t, long);
	ArchiveEntry* unset_ctime(void);
	ArchiveEntry* set_dev(dev_t);
	ArchiveEntry* set_devmajor(dev_t);
	ArchiveEntry* set_devminor(dev_t);
	ArchiveEntry* set_filetype(unsigned int);
#if 0
__LA_DECL void  archive_entry_set_fflags(void,
            unsigned long /* set */, unsigned long /* clear */);
/* Returns pointer to start of first invalid token, or NULL if none. */
/* Note that all recognized tokens are processed, regardless. */
__LA_DECL const char *archive_entry_copy_fflags_text(void,
            const char *);
__LA_DECL const wchar_t *archive_entry_copy_fflags_text_w(void,
            const wchar_t *);
#endif
	ArchiveEntry* set_gid(int64_t);
	ArchiveEntry* set_gname(const char *);
	ArchiveEntry* set_gname_utf8(const char *);
	ArchiveEntry* copy_gname(const char *);
	ArchiveEntry* copy_gname_w(const wchar_t *);
	int update_gname_utf8(const char *);
	ArchiveEntry* set_hardlink(const char *);
	ArchiveEntry* set_hardlink_utf8(const char *);
	ArchiveEntry* copy_hardlink(const char *);
	ArchiveEntry* copy_hardlink_w(const wchar_t *);
	int update_hardlink_utf8(const char *);
	ArchiveEntry* set_ino(int64_t);
	ArchiveEntry* set_ino64(int64_t);
	ArchiveEntry* set_link(const char *);
	ArchiveEntry* set_link_utf8(const char *);
	ArchiveEntry* copy_link(const char *);
	ArchiveEntry* copy_link_w(const wchar_t *);
	int update_link_utf8(const char *);
	ArchiveEntry* set_mode(int);
	ArchiveEntry* set_mtime(time_t, long);
	ArchiveEntry* unset_mtime(void);
	ArchiveEntry* set_nlink(unsigned int);
	ArchiveEntry* set_pathname(const char *);
	ArchiveEntry* set_pathname_utf8(const char *);
	ArchiveEntry* copy_pathname(const char *);
	ArchiveEntry* copy_pathname_w(const wchar_t *);
	int update_pathname_utf8(const char *);
	ArchiveEntry* set_perm(int);
	ArchiveEntry* set_rdev(dev_t);
	ArchiveEntry* set_rdevmajor(dev_t);
	ArchiveEntry* set_rdevminor(dev_t);
	ArchiveEntry* set_size(int64_t);
	ArchiveEntry* unset_size(void);
	ArchiveEntry* copy_sourcepath(const char *);
	ArchiveEntry* copy_sourcepath_w(const wchar_t *);
	ArchiveEntry* set_symlink(const char *);

#ifndef SWIG
	struct archive_entry *_get_raw(void);
#endif

private:
	struct archive_entry *m_ptArchiveEntry;
};



class Archive
{
public:
	Archive(void);
	~Archive(void);

	int errno(void);
	const char* error_string(void);

protected:
	struct archive *m_ptArchive;
};



class ArchiveRead : public Archive
{
public:
	ArchiveRead(void);
	~ArchiveRead(void);

	int support_filter_all(void);
	int support_format_all(void);

	int open_filename(const char *_filename, size_t _block_size);

	ArchiveEntry *next_header(void);
	void iter_header(lua_State *MUHKUH_SWIG_OUTPUT_CUSTOM_OBJECT, swig_type_info *p_ArchiveEntry);

	void read_data(size_t sizChunk, char **ppcBUFFER_OUT, size_t *psizBUFFER_OUT);
	void iter_data(size_t sizChunk, lua_State *MUHKUH_SWIG_OUTPUT_CUSTOM_OBJECT);

	int data_skip(void);

	static int iterator_next_header(lua_State *ptLuaState);
	static int iterator_read_data(lua_State *ptLuaState);
};



class ArchiveWrite : public Archive
{
public:
	ArchiveWrite(void);
	~ArchiveWrite(void);

	int add_filter(int filter_code);
	int add_filter_by_name(const char *name);
	int add_filter_b64encode(void);
	int add_filter_bzip2(void);
	int add_filter_compress(void);
	int add_filter_grzip(void);
	int add_filter_gzip(void);
	int add_filter_lrzip(void);
	int add_filter_lz4(void);
	int add_filter_lzip(void);
	int add_filter_lzma(void);
	int add_filter_lzop(void);
	int add_filter_none(void);
	int add_filter_program(const char *cmd);
	int add_filter_uuencode(void);
	int add_filter_xz(void);

	int set_format(int format_code);
	int set_format_by_name(const char *name);
	int set_format_7zip(void);
	int set_format_ar_bsd(void);
	int set_format_ar_svr4(void);
	int set_format_cpio(void);
	int set_format_cpio_newc(void);
	int set_format_gnutar(void);
	int set_format_iso9660(void);
	int set_format_mtree(void);
	int set_format_mtree_classic(void);
	int set_format_pax(void);
	int set_format_pax_restricted(void);
	int set_format_raw(void);
	int set_format_shar(void);
	int set_format_shar_dump(void);
	int set_format_ustar(void);
	int set_format_v7tar(void);
	int set_format_warc(void);
	int set_format_xar(void);
	int set_format_zip(void);
	int set_format_filter_by_ext(const char *filename);
	int set_format_filter_by_ext_def(const char *filename, const char * def_ext);

	int zip_set_compression_deflate(void);
	int zip_set_compression_store(void);

	int open_filename(const char *_file);
	int open_filename_w(const wchar_t *_file);

	int write_header(ArchiveEntry *ptEntry);
	int write_data(const char *pcBUFFER_IN, size_t sizBUFFER_IN);
	int finish_entry(void);
	int close(void);
};


#endif  /* __WRAPPER_H__ */
