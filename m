From: David Miller <davem@davemloft.net>
Date: Sat, 22 Jul 2006 09:04:40 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060722.020440.112264570.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jul 2006 13:42:05 -0700 (PDT)

> From: Raymond Burns <rayburns@comcast.net>
> Date: Wed, 19 Jul 2006 13:47:09 -0700 (PDT)
> 
> > Request for IRQ45 (ESP SCSI) SA_STATIC_ALLOC failed using kmalloc
> > 
> > appears benign, guess I'm sensative to the word failed.
> 
> This needs investigation.

The problem is that SA_STATIC_ALLOC aliases another irq flag
value, IRQF_SHARED, which is commonly used.

Let's just use the following fix for now.  We should kill this
thing off eventually.

diff --git a/include/asm-sparc/signal.h b/include/asm-sparc/signal.h
index 0ae5084..d03a21c 100644
--- a/include/asm-sparc/signal.h
+++ b/include/asm-sparc/signal.h
@@ -168,7 +168,7 @@ struct sigstack {
  * statically allocated data.. which is NOT GOOD.
  *
  */
-#define SA_STATIC_ALLOC		0x80
+#define SA_STATIC_ALLOC		0x8000
 #endif
 
 #include <asm-generic/signal.h>
