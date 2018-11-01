From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu, 01 Nov 2018 13:54:00 +0000
Subject: [PATCH v2 2/4] sparc: add __NR_syscalls along with NR_syscalls
Message-Id: <1541080391-3890-3-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org

NR_syscalls macro holds the number of system call exist
in sparc architecture. We have to change the value of NR-
_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_sy-
scalls value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 2 ++
 arch/sparc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 6dfd752..171a6e5 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define NR_syscalls	__NR_syscalls
+
 #ifdef __32bit_syscall_numbers__
 #else
 #define __NR_time		231 /* Linux sparc32                               */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 6e59037..e11d86c 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -428,7 +428,9 @@
 #define __NR_pwritev2		359
 #define __NR_statx		360
 
-#define NR_syscalls		361
+#ifdef __KERNEL__
+#define __NR_syscalls		361
+#endif
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-- 
1.9.1
