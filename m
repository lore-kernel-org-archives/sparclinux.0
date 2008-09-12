From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:47:52 +0000
Subject: [PATCH 1/16]: sparc64: Add __arch64__ to CHECKFLAGS
Message-Id: <20080912.144752.266830543.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Add __arch64__ to CHECKFLAGS

Otherwise sparse doesn't work.  The 32 vs. 64 header ifdef
used under arch/sparc/include/asm/ is:

#if defined(__sparc__) && defined(__arch64__)

And that doesn't work for sparse unless we give it __arch64__

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index b785a39..c7214ab 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -7,7 +7,7 @@
 # Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
 #
 
-CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -m64
+CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
 
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing 64 bit builds (for this case)
-- 
1.5.6.5.GIT

