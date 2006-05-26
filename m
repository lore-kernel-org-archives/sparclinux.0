From: David Miller <davem@davemloft.net>
Date: Fri, 26 May 2006 09:52:31 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <20060526.025231.123919023.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Can you guys give this patch a spin?  I think this might
cure it.  Please be sure to add this patch to a kernel
you know produced the symptoms before.

Thanks.

diff --git a/arch/sparc64/lib/U1memcpy.S b/arch/sparc64/lib/U1memcpy.S
index bafd2fc..7293020 100644
--- a/arch/sparc64/lib/U1memcpy.S
+++ b/arch/sparc64/lib/U1memcpy.S
@@ -97,7 +97,7 @@
 	EX_ST(STORE_BLK(%fsrc, %dest));			\
 	add			%dest, 0x40, %dest;	\
 	ba,pt			%xcc, target;		\
-	 nop;
+	 DO_SYNC
 
 #define FINISH_VISCHUNK(dest, f0, f1, left)	\
 	subcc			%left, 8, %left;\
