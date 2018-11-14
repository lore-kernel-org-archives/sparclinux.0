From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 14 Nov 2018 05:38:29 +0000
Subject: [PATCH v3 2/4] sparc: add __NR_syscalls along with NR_syscalls
Message-Id: <1542173191-24981-3-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
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
index 73d2454..5194d86 100644
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
index d37a136..4ae11c4 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -429,7 +429,9 @@
 #define __NR_statx		360
 #define __NR_io_pgetevents	361
 
-#define NR_syscalls		362
+#ifdef __KERNEL__
+#define __NR_syscalls		362
+#endif
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-- 
1.9.1
