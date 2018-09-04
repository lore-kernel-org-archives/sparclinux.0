From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 04 Sep 2018 04:53:25 +0000
Subject: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
Message-Id: <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org

NR_syscalls macro holds the number of system call exist in SPARC
architecture. This macro is currently the part of uapi/asm/unistd.h
file. We have to change the value of NR_syscalls, if we add or
delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
NR_syscalls value.

1. Update NR_syscalls in uapi/asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we either
   add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from uapi/asm/unistd.h to asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 2 ++
 arch/sparc/include/uapi/asm/unistd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index f120b6b..c8849b7 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define NR_syscalls __NR_syscalls
+
 #ifndef __32bit_syscall_numbers__
 #ifndef __arch64__
 #define __32bit_syscall_numbers__
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index ccf4bea..e2407b4 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -422,6 +422,6 @@
 #define __NR_pwritev2		359
 #define __NR_statx		360
 
-#define NR_syscalls		361
+#define __NR_syscalls		361
 
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1
