From: Will Drewry <wad@chromium.org>
Date: Wed, 01 Jun 2011 03:10:44 +0000
Subject: [PATCH v3 12/13] sparc: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Message-Id: <1306897845-9393-12-git-send-email-wad@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
In-Reply-To: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kees.cook@canonical.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, Will Drewry <wad@chromium.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/sparc/Kconfig               |    2 ++
 arch/sparc/include/asm/seccomp.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e560d10..5249760 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,6 +25,7 @@ config SPARC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_SECCOMP_FILTER
 
 config SPARC32
 	def_bool !64BIT
@@ -39,6 +40,7 @@ config SPARC64
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

