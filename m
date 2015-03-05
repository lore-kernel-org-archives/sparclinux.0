From: Kees Cook <keescook@chromium.org>
Date: Thu, 05 Mar 2015 01:27:03 +0000
Subject: [PATCH v3 3/8] microblaze: use asm-generic for seccomp.h
Message-Id: <1425518828-16017-4-git-send-email-keescook@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Since microblaze is 32-bit, the COMPAT
seccomp defines are unused and can be dropped. The obsolete sigreturn
for seccomp strict mode is retained as an override. Remaining definitions
are identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/microblaze/include/asm/seccomp.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/seccomp.h b/arch/microblaze/include/asm/seccomp.h
index 0d912758a0d7..204618a2ce84 100644
--- a/arch/microblaze/include/asm/seccomp.h
+++ b/arch/microblaze/include/asm/seccomp.h
@@ -3,14 +3,8 @@
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read		__NR_read
-#define __NR_seccomp_write		__NR_write
-#define __NR_seccomp_exit		__NR_exit
 #define __NR_seccomp_sigreturn		__NR_sigreturn
 
-#define __NR_seccomp_read_32		__NR_read
-#define __NR_seccomp_write_32		__NR_write
-#define __NR_seccomp_exit_32		__NR_exit
-#define __NR_seccomp_sigreturn_32	__NR_sigreturn
+#include <asm-generic/seccomp.h>
 
 #endif	/* _ASM_MICROBLAZE_SECCOMP_H */
-- 
1.9.1

