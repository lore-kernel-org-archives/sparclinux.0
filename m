From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:40:54 +0000
Subject: [PATCH 4/6]: sparc64: Block NMIs in critical section of context
Message-Id: <20081126.004054.69988085.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Block NMIs in critical section of context switch.

In these instructions we load the new thread register, switch
the register window, and setup the new frame pointer.

All of these must appear atomic, and things will explode if
we take a PIL NMI interrupt in the middle of this sequence.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/system_64.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/system_64.h b/arch/sparc/include/asm/system_64.h
index 7554ad3..779cf62 100644
--- a/arch/sparc/include/asm/system_64.h
+++ b/arch/sparc/include/asm/system_64.h
@@ -159,6 +159,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) {				\
 	"stb	%%o5, [%%g6 + %5]\n\t"					\
 	"rdpr	%%cwp, %%o5\n\t"					\
 	"stb	%%o5, [%%g6 + %8]\n\t"					\
+	"wrpr	%%g0, 15, %%pil\n\t"					\
 	"mov	%4, %%g6\n\t"						\
 	"ldub	[%4 + %8], %%g1\n\t"					\
 	"wrpr	%%g1, %%cwp\n\t"					\
@@ -169,6 +170,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) {				\
 	"ldx	[%%sp + 2047 + 0x70], %%i6\n\t"				\
 	"ldx	[%%sp + 2047 + 0x78], %%i7\n\t"				\
 	"ldx	[%%g6 + %9], %%g4\n\t"					\
+	"wrpr	%%g0, 14, %%pil\n\t"					\
 	"brz,pt %%o7, switch_to_pc\n\t"					\
 	" mov	%%g7, %0\n\t"						\
 	"sethi	%%hi(ret_from_syscall), %%g1\n\t"			\
-- 
1.5.6.5

