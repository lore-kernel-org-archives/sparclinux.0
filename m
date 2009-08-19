From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Wed, 19 Aug 2009 02:56:23 +0000
Subject: sparc: sys32.S incorrect compat-layer splice() system call
Message-Id: <20090819025623.GA11677@Krystal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

I just installed a shiny (old) Sparc64 machine, trying to get LTTng to
run on it (2.6.30 kernel), and noticed this problem when extracting the
buffers: lttd (the daemon) causes faults in __copy_from_user() within
splice().

lttd is compiled as a 32-bits process on my system. The kernel is
64-bits kernel.

I think arch/sparc/kernel/sys32.S has an incorrect splice definition:

SIGN2(sys32_splice, sys_splice, %o0, %o1)

The splice() prototype looks like :

       long splice(int fd_in, loff_t *off_in, int fd_out,
                   loff_t *off_out, size_t len, unsigned int flags);

So I think we should have :

SIGN2(sys32_splice, sys_splice, %o0, %o2)

instead, am I correct ?


BTW, I can't figure out why we have %o5 in :

SIGN2(sys32_sync_file_range, compat_sync_file_range, %o0, %o5)

which takes only 4 arguments:

       int sync_file_range(int fd, off64_t offset, off64_t nbytes,
                  unsigned int flags);

maybe it has something to do with the return value ? Anyway it should
not hurt if it is unused.


I provide the patch for splice() below.

With this patch applied, I have been able to gather a trace with LTTng
and view it in LTTV. Next steps for LTTng support on sparc64 are to add
the syscall and trap instrumentation.

Thanks,

Mathieu


sparc: sys32.S incorrect compat-layer splice() system call

I think arch/sparc/kernel/sys32.S has an incorrect splice definition:

SIGN2(sys32_splice, sys_splice, %o0, %o1)

The splice() prototype looks like :

       long splice(int fd_in, loff_t *off_in, int fd_out,
                   loff_t *off_out, size_t len, unsigned int flags);

So I think we should have :

SIGN2(sys32_splice, sys_splice, %o0, %o2)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: "David S. Miller" <davem@caip.rutgers.edu>
CC: Jakub Jelinek <jj@ultra.linux.cz>
---
 arch/sparc/kernel/sys32.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-lttng/arch/sparc/kernel/sys32.S
=================================--- linux-2.6-lttng.orig/arch/sparc/kernel/sys32.S	2009-08-18 21:21:20.000000000 -0400
+++ linux-2.6-lttng/arch/sparc/kernel/sys32.S	2009-08-18 21:56:47.000000000 -0400
@@ -134,7 +134,7 @@ SIGN1(sys32_getpeername, sys_getpeername
 SIGN1(sys32_getsockname, sys_getsockname, %o0)
 SIGN2(sys32_ioprio_get, sys_ioprio_get, %o0, %o1)
 SIGN3(sys32_ioprio_set, sys_ioprio_set, %o0, %o1, %o2)
-SIGN2(sys32_splice, sys_splice, %o0, %o1)
+SIGN2(sys32_splice, sys_splice, %o0, %o2)
 SIGN2(sys32_sync_file_range, compat_sync_file_range, %o0, %o5)
 SIGN2(sys32_tee, sys_tee, %o0, %o1)
 SIGN1(sys32_vmsplice, compat_sys_vmsplice, %o0)

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
