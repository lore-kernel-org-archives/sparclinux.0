From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 20 Feb 2020 07:11:39 +0000
Subject: [PATCH 1/2] vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Message-Id: <20200220071140.14080-1-masahiroy@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, clang-built-linux@googlegroups.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org

The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected.

It is because <linux/compiler_types.h> is parsed before vclock_gettime.c
since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
struct attributes").

Since then, <linux/compiler_types.h> is included really early by
using the '-include' option. So, you cannot negate the decision of
<linux/compiler_types.h> in this way.

You can confirm it by checking the pre-processed code, like this:

  $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i

There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.

It it about two years since 28128c61e08e. Nobody has reported a
problem (or, nobody has even noticed the fact that this code is not
working).

It is ugly and unreliable to attempt to undefine a CONFIG option from
C files, and anyway the inlining heuristic is up to the compiler.

Just remove the broken code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/vdso32/vclock_gettime.c     | 4 ----
 arch/x86/entry/vdso/vdso32/vclock_gettime.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/sparc/vdso/vdso32/vclock_gettime.c b/arch/sparc/vdso/vdso32/vclock_gettime.c
index 026abb3b826c..d7f99e6745ea 100644
--- a/arch/sparc/vdso/vdso32/vclock_gettime.c
+++ b/arch/sparc/vdso/vdso32/vclock_gettime.c
@@ -4,10 +4,6 @@
 
 #define	BUILD_VDSO32
 
-#ifndef	CONFIG_CC_OPTIMIZE_FOR_SIZE
-#undef	CONFIG_OPTIMIZE_INLINING
-#endif
-
 #ifdef	CONFIG_SPARC64
 
 /*
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..3c26488db94d 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -1,10 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define BUILD_VDSO32
 
-#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-#undef CONFIG_OPTIMIZE_INLINING
-#endif
-
 #ifdef CONFIG_X86_64
 
 /*
-- 
2.17.1
