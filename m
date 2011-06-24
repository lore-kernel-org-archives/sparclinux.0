From: Will Drewry <wad@chromium.org>
Date: Fri, 24 Jun 2011 00:36:51 +0000
Subject: [PATCH v9 12/13] sparc: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Message-Id: <1308875813-20122-12-git-send-email-wad@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
In-Reply-To: <1308875813-20122-1-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, djm@mindrot.org, segoon@openwall.com, kees.cook@canonical.com, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, fweisbec@gmail.com, tglx@linutronix.de, scarybeasts@gmail.com, Will Drewry <wad@chromium.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/sparc/Kconfig               |    2 ++
 arch/sparc/include/asm/seccomp.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 253986b..d4d0ec4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -26,6 +26,7 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_SECCOMP_FILTER
 	select GENERIC_IRQ_SHOW
 	select USE_GENERIC_SMP_HELPERS if SMP
 
@@ -42,6 +43,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select HAVE_MEMBLOCK
+	select HAVE_SECCOMP_FILTER
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index adca1bc..a1dac08 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -6,10 +6,12 @@
 #define __NR_seccomp_write __NR_write
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
+#define __NR_seccomp_execve __NR_execve
 
 #define __NR_seccomp_read_32 __NR_read
 #define __NR_seccomp_write_32 __NR_write
 #define __NR_seccomp_exit_32 __NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
+#define __NR_seccomp_execve_32 __NR_execve
 
 #endif /* _ASM_SECCOMP_H */
-- 
1.7.0.4

