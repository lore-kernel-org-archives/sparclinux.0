From: David Howells <dhowells@redhat.com>
Date: Fri, 11 May 2012 10:43:12 +0000
Subject: [PATCH 1/8] KEYS: Use the compat keyctl() syscall wrapper on Sparc64 for Sparc32 compat
Message-Id: <20120511104312.6307.79320.stgit@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use the 32-bit compat keyctl() syscall wrapper on Sparc64 for Sparc32 binary
compatibility.

Without this, keyctl(KEYCTL_INSTANTIATE_IOV) is liable to malfunction as it
uses an iovec array read from userspace - though the kernel should survive this
as it checks pointers and sizes anyway.

I think all the other keyctl() function should just work, provided (a) the top
32-bits of each 64-bit argument register are cleared prior to invoking the
syscall routine, and the 32-bit address space is right at the 0-end of the
64-bit address space.  Most of the arguments are 32-bit anyway, and so for
those clearing is not required.

Signed-off-by: David Howells <dhowells@redhat.com
cc: "David S. Miller" <davem@davemloft.net>
cc: sparclinux@vger.kernel.org
cc: stable@vger.kernel.org
---

 arch/sparc/Kconfig             |    3 +++
 arch/sparc/kernel/systbls_64.S |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6c0683d..76c7ccf 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -584,6 +584,9 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
+config KEYS_COMPAT
+	def_bool y if COMPAT && KEYS
+
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index db86b1a..3a58e0d 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -74,7 +74,7 @@ sys_call_table32:
 	.word sys_timer_delete, compat_sys_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
 	.word compat_sys_mq_timedsend, compat_sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
-/*280*/	.word sys32_tee, sys_add_key, sys_request_key, sys_keyctl, compat_sys_openat
+/*280*/	.word sys32_tee, sys_add_key, sys_request_key, compat_sys_keyctl, compat_sys_openat
 	.word sys_mkdirat, sys_mknodat, sys_fchownat, compat_sys_futimesat, compat_sys_fstatat64
 /*290*/	.word sys_unlinkat, sys_renameat, sys_linkat, sys_symlinkat, sys_readlinkat
 	.word sys_fchmodat, sys_faccessat, compat_sys_pselect6, compat_sys_ppoll, sys_unshare

