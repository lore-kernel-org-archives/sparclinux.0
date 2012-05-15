From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:34:00 +0000
Subject: [PATCH 1/3] sparc32: delete muldiv.o from Makefile
Message-Id: <20120515193400.GA17309@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 7d92b3f366c1d4e31c3632926e450667785c027d Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 21:20:44 +0200
Subject: [PATCH 1/3] sparc32: delete muldiv.o from Makefile

The source file is no more..

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

And this broke my build...

 arch/sparc/kernel/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index bfb93c3..c19dd02 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_SPARC32)   += tadpole.o
 obj-y                   += ptrace_$(BITS).o
 obj-y                   += unaligned_$(BITS).o
 obj-y                   += una_asm_$(BITS).o
-obj-$(CONFIG_SPARC32)   += muldiv.o
 obj-y                   += prom_common.o
 obj-y                   += prom_$(BITS).o
 obj-y                   += of_device_common.o
-- 
1.6.0.6

