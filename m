From: David Dillow <dave@thedillows.org>
Date: Wed, 04 Feb 2004 07:02:30 +0000
Subject: AIO syscall patch, and problem
Message-Id: <1075876893.5035.60.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The attached patch fixes a mis-numbering of the AIO syscalls under sparc
and sparc64. I would have simply moved them all down, but then
io_getevents would be at 272, and the big WARNING comment says we cannot
use numbers larger than 271, so there you are. I used the oldstat
syscall, since it was commented out.

With this patch, and with appropriate glue added to libio from
kernel.org, I can get it to pass most of the test cases included with
the library on my Ultra1.

However, there is one test case that is still failing on the sparc64 box
-- test 5.t, which mmaps() a file opened O_RDWR with PROT_READ,
MAP_SHARED and then submits the address returned to an aio read() call.

The test case expects this to return -EFAULT, and on x86, it does. On my
machine, it returns -EHOSTDOWN.

I've tracked this down to file_read_actor() in mm/filemap.c:

/* Do it the slow way */
kaddr = kmap(page);
left = __copy_to_user(desc->buf, kaddr + offset, size);
kunmap(page);

if (left) {
	size -= left;
	desc->error = -EFAULT;
}

The problem is __copy_to_user() is being called with a size of 512, but
is returning 576. size then underflows in the conditional, and
aio_complete() eventually gets called with this as its return code,
hence, -EHOSTDOWN.

I briefly looked at __copy_to_user(), but I quickly ran away screaming.
Someone smarted than I will need to go from here.

Dave

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1548  -> 1.1549 
#	include/asm-sparc/unistd.h	1.27    -> 1.28   
#	include/asm-sparc64/unistd.h	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/04	dave@thedillows.org	1.1549
# Remove duplicate syscall number for AIO io_destroy() call. Cannot just
# renumber to 272, per WARNING comment just after the list.
# --------------------------------------------
#
diff -Nru a/include/asm-sparc/unistd.h b/include/asm-sparc/unistd.h
--- a/include/asm-sparc/unistd.h	Wed Feb  4 01:11:51 2004
+++ b/include/asm-sparc/unistd.h	Wed Feb  4 01:11:51 2004
@@ -285,7 +285,7 @@
 #define __NR_timer_create	266
 /* #define __NR_vserver		267 Reserved for VSERVER */
 #define __NR_io_setup		268
-#define __NR_io_destroy		268
+#define __NR_io_destroy		232
 #define __NR_io_submit		269
 #define __NR_io_cancel		270
 #define __NR_io_getevents	271
diff -Nru a/include/asm-sparc64/unistd.h b/include/asm-sparc64/unistd.h
--- a/include/asm-sparc64/unistd.h	Wed Feb  4 01:11:51 2004
+++ b/include/asm-sparc64/unistd.h	Wed Feb  4 01:11:51 2004
@@ -287,7 +287,7 @@
 #define __NR_timer_create	266
 /* #define __NR_vserver		267 Reserved for VSERVER */
 #define __NR_io_setup		268
-#define __NR_io_destroy		268
+#define __NR_io_destroy		232
 #define __NR_io_submit		269
 #define __NR_io_cancel		270
 #define __NR_io_getevents	271




