From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 04 Nov 2004 05:38:27 +0000
Subject: initrd testing [possible solution]
Message-Id: <Pine.LNX.4.61.0411032344240.25808@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[Please CC the responses to me as I am not on the list.]

Hello,

I have made a little research into the infamous initrd problem (short 
story: initrd cannot be mounted with 'cramfs: wrong magic', long story may 
be found in the May 2004 thread starting at [0]). I have used Debian's 
unstable 2.4.27 kernel, which suffers from that problem on my Sparcstation 
10. After inserting some debugging code I was able to figure out, that 
the initrd contents got loaded into the memory by silo and then passed 
into the /dev/ram correctly. After that kernel attempts to mount root on 
it. The relevant calls go like this:

init/do_mounts.c: handle_initrd:
  fs/namespace.c: sys_mount
   fs/namespace.c: do_mount
    fs/namespace.c: do_add_mount
     fs/super.c: do_kern_mount
      fs/super.c: get_sb_bdev
       fs/cramfs/inode.c cramfs_read_super (via fs_type->read_super)
        fs/cramfs/inode.c cramfs_read(sb, 0, sizeof(super)) (via memcpy)

In the last call cramfs_read is called to read in the superblock of the
cramfs filesystem. The source data was ok (i.e. contained the expected
cramfs magic in the beginning) all the way up to this code snippet from
cramfs_read() from fs/cramfs/inode.c:

         data = read_buffers[buffer];
         for (i = 0; i < BLKS_PER_BUF; i++) {
                 struct page *page = pages[i];
                 if (page) {
                         memcpy(data, kmap(page), PAGE_CACHE_SIZE);
                         kunmap(page);
                         page_cache_release(page);
                 } else
                         memset(data, 0, PAGE_CACHE_SIZE);
                 data += PAGE_CACHE_SIZE;
         }

So, memory at address kmap(pages[0]) contained the correct byte sequence 
for the cramfs magic, but the memory at location 'data' after the 
call to memcpy() did not (in fact, it appeared as if the first 4 bytes 
were not copied to the destination)! It turned out that memcpy() calls 
different copying routines depending on the size of the copied block (see 
include/asm-sparc/string.h). It has a special routine for copying the 
memory chunks of size PAGE_SIZE (equal to PAGE_CACHE_SIZE), called 
__copy_1page and defined in arch/sparc/lib/blockops.S. Having narrowed it 
down that much I have tried replacing memcpy() in the code above by 
__memcpy(), thus avoiding the use of __copy_1page and invoking the more 
generic (probably, slower) subroutine (__memcpy in arch/sparc/lib/memcpy.S). 
As a result, the initrd was correctly mounted!

So, my conclusion is that __copy_1page is broken, at least under certain 
(yet undetermined) conditions. If that's really the case, it either 
should be fixed (requires knowledge of assembler, which I lack) or its use 
should be avoided whatsoever. The latter is easy to achieve by modifying 
the memcpy() definition in include/asm-sparc/string.h to call __memcpy 
instead.

[0] http://marc.theaimsgroup.com/?t8448100400006&r=1&w=2

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
