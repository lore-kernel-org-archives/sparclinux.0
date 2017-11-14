From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 14 Nov 2017 14:03:42 +0000
Subject: [PATCH 1/2] sparc32,leon: Build with -mcpu=leon3 for SPARC_LEON
Message-Id: <1510668223-18484-2-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, software@gaisler.com

Apart from using LEON3 instruction timing it allows for usage of the
CASA instruction.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 8496a07..673ee73 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -24,14 +24,20 @@ LDFLAGS        := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
 
+ifeq ($(CONFIG_SPARC_LEON),y)
+SPARC_MCPU=leon3
+else
+SPARC_MCPU=v8
+endif
+
 # We are adding -Wa,-Av8 to KBUILD_CFLAGS to deal with a specs bug in some
 # versions of gcc.  Some gcc versions won't pass -Av8 to binutils when you
 # give -mcpu=v8.  This silently worked with older bintutils versions but
 # does not any more.
-KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_CFLAGS  += -m32 -mcpu=$(SPARC_MCPU) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 KBUILD_CFLAGS  += -Wa,-Av8
 
-KBUILD_AFLAGS  += -m32 -Wa,-Av8
+KBUILD_AFLAGS  += -m32 -mcpu=$(SPARC_MCPU) -Wa,-Av8
 
 else
 #####
-- 
2.8.0

