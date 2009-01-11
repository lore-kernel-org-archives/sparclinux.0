From: David Miller <davem@davemloft.net>
Date: Sun, 11 Jan 2009 07:44:53 +0000
Subject: Re: sparc32 broke
Message-Id: <20090110.234453.254713982.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sat, 10 Jan 2009 09:56:01 -0500

> David Miller wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Sat, 10 Jan 2009 08:33:21 +0100
> >
> >   
> >> The real fix should look like this:
> >>
> >> #ifdef __arch64__
> >> #define _NSIG_BPW       64
> >> #else
> >> #define _NSIG_BPW       64
> >> #endif
> >>
> >> This is required because this header is exported to userspace
> >> where we do not have access to CONFIG_* symbols.
> >>     
> >
> > I assume you meant to use "32" in the #else branch :-)
>
> This fixed it (with the 32).

Thanks for testing Robert, I've just commited the following:

sparc: Fix asm/signal.h for 32-bit.

Fix a 32-bit sparc regression reported by Robert Reif.

_NSIG_BPW needs to be 32 for 32-bit and 64 for 64-bit

Tested-by: Robert Reif <reif@earthlink.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/signal.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/signal.h
index 41535e7..cba4520 100644
--- a/arch/sparc/include/asm/signal.h
+++ b/arch/sparc/include/asm/signal.h
@@ -84,7 +84,11 @@
 
 #define __OLD_NSIG	32
 #define __NEW_NSIG      64
+#ifdef __arch64__
 #define _NSIG_BPW       64
+#else
+#define _NSIG_BPW       32
+#endif
 #define _NSIG_WORDS     (__NEW_NSIG / _NSIG_BPW)
 
 #define SIGRTMIN       32
-- 
1.6.1.15.g159c88

