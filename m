From: "David S. Miller" <davem@redhat.com>
Date: Sat, 07 Feb 2004 03:36:54 +0000
Subject: Re: AIO syscall patch, and problem
Message-Id: <20040206193654.653143eb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1075876893.5035.60.camel@ori.thedillows.org>
In-Reply-To: <1075876893.5035.60.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04 Feb 2004 02:02:30 -0500
David Dillow <dave@thedillows.org> wrote:

> The attached patch fixes a mis-numbering of the AIO syscalls under sparc
> and sparc64.

The syscall tables were right, the header was wrong.  This patch below
is the correct fix.  I don't know how the AIO tests passed for you
with your posted patch, maybe nothing depends upon io_destroy() and
subsequently numbered AIO syscalls doing anything :-)

I'll look at the copy_*_user() issue now.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/06 19:32:56-08:00 davem@nuts.davemloft.net 
#   [SPARC]: Fix AIO syscall numbering.
# 
# include/asm-sparc64/unistd.h
#   2004/02/06 19:30:08-08:00 davem@nuts.davemloft.net +7 -7
#   [SPARC]: Fix AIO syscall numbering.
# 
# include/asm-sparc/unistd.h
#   2004/02/06 19:30:08-08:00 davem@nuts.davemloft.net +7 -7
#   [SPARC]: Fix AIO syscall numbering.
# 
diff -Nru a/include/asm-sparc/unistd.h b/include/asm-sparc/unistd.h
--- a/include/asm-sparc/unistd.h	Fri Feb  6 19:33:12 2004
+++ b/include/asm-sparc/unistd.h	Fri Feb  6 19:33:12 2004
@@ -285,14 +285,14 @@
 #define __NR_timer_create	266
 /* #define __NR_vserver		267 Reserved for VSERVER */
 #define __NR_io_setup		268
-#define __NR_io_destroy		268
-#define __NR_io_submit		269
-#define __NR_io_cancel		270
-#define __NR_io_getevents	271
-/* WARNING: You MAY NOT add syscall numbers larger than 271, since
+#define __NR_io_destroy		269
+#define __NR_io_submit		270
+#define __NR_io_cancel		271
+#define __NR_io_getevents	272
+/* WARNING: You MAY NOT add syscall numbers larger than 272, since
  *          all of the syscall tables in the Sparc kernel are
- *          sized to have 272 entries (starting at zero).  Therefore
- *          find a free slot in the 0-271 range.
+ *          sized to have 273 entries (starting at zero).  Therefore
+ *          find a free slot in the 0-272 range.
  */
 
 #define _syscall0(type,name) \
diff -Nru a/include/asm-sparc64/unistd.h b/include/asm-sparc64/unistd.h
--- a/include/asm-sparc64/unistd.h	Fri Feb  6 19:33:12 2004
+++ b/include/asm-sparc64/unistd.h	Fri Feb  6 19:33:12 2004
@@ -287,14 +287,14 @@
 #define __NR_timer_create	266
 /* #define __NR_vserver		267 Reserved for VSERVER */
 #define __NR_io_setup		268
-#define __NR_io_destroy		268
-#define __NR_io_submit		269
-#define __NR_io_cancel		270
-#define __NR_io_getevents	271
-/* WARNING: You MAY NOT add syscall numbers larger than 271, since
+#define __NR_io_destroy		269
+#define __NR_io_submit		270
+#define __NR_io_cancel		271
+#define __NR_io_getevents	272
+/* WARNING: You MAY NOT add syscall numbers larger than 272, since
  *          all of the syscall tables in the Sparc kernel are
- *          sized to have 272 entries (starting at zero).  Therefore
- *          find a free slot in the 0-271 range.
+ *          sized to have 273 entries (starting at zero).  Therefore
+ *          find a free slot in the 0-272 range.
  */
 
 #define _syscall0(type,name) \
