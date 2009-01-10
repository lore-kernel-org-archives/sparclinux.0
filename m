From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jan 2009 06:22:04 +0000
Subject: Re: sparc32 broke
Message-Id: <20090109.222204.61442525.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 09 Jan 2009 23:19:19 -0500

> I bisected it down to: ece93487c31607558f4b91f378fcee4b43956dbc
> sparc: unify signal.h

Sam, the first thing I notice is that _NSIG_BPW changed.

It's supposed to be 32 for sparc32 and 64 for sparc64.
But now it's unconditionally 64 in the unified header.
This also makes _NSIG_WORDS et al. wrong.

Robert, does this fix the bug for you?

sparc: Fix asm/signal.h for 32-bit.

Fix a 32-bit sparc regression reported by Robert Reif.

_NSIG_BPW needs to be 32 for 32-bit and 64 for 64-bit

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/signal.h
index 41535e7..047fbd0 100644
--- a/arch/sparc/include/asm/signal.h
+++ b/arch/sparc/include/asm/signal.h
@@ -84,7 +84,7 @@
 
 #define __OLD_NSIG	32
 #define __NEW_NSIG      64
-#define _NSIG_BPW       64
+#define _NSIG_BPW       CONFIG_BITS
 #define _NSIG_WORDS     (__NEW_NSIG / _NSIG_BPW)
 
 #define SIGRTMIN       32
