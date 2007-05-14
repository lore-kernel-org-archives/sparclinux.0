From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2007 10:54:02 +0000
Subject: Re: [PATCH] fix sparc32 kdebug changes
Message-Id: <20070514.035402.92339773.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46444A9F.6040407@earthlink.net>
In-Reply-To: <46444A9F.6040407@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2007 03:22:34 -0700 (PDT)

> I'll see if I can work out the SMP build breakage.

This gets UP sparc32 building again:

commit 6e46507d0178ad4b33ed3bfcc72dc6e1e8a17790
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon May 14 03:53:47 2007 -0700

    [SPARC32]: asm/system.h needs asm/smp.h
    
    To get hard_smp_processor_id() even on UP builds.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc/system.h b/include/asm-sparc/system.h
index 8b6d9c9..8b4e23b 100644
--- a/include/asm-sparc/system.h
+++ b/include/asm-sparc/system.h
@@ -11,6 +11,7 @@
 #include <asm/psr.h>
 #include <asm/ptrace.h>
 #include <asm/btfixup.h>
+#include <asm/smp.h>
 
 #ifndef __ASSEMBLY__
 
