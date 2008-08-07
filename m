From: David Miller <davem@davemloft.net>
Date: Thu, 07 Aug 2008 05:43:01 +0000
Subject: Re: [PATCH] sparc: don't use asm/of_device.h
Message-Id: <20080806.224301.193719553.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080807134417.6a1bc76d.sfr@canb.auug.org.au>
In-Reply-To: <20080807134417.6a1bc76d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 7 Aug 2008 13:44:17 +1000

> Use linux/of_device.h instead.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Did I miss a previous patch?  This one doesn't apply cleanly:

error: patch failed: arch/sparc64/kernel/pci_psycho.c:12
error: arch/sparc64/kernel/pci_psycho.c: patch does not apply
error: patch failed: arch/sparc64/kernel/pci_schizo.c:10
error: arch/sparc64/kernel/pci_schizo.c: patch does not apply
error: patch failed: arch/sparc64/kernel/prom.c:22
error: arch/sparc64/kernel/prom.c: patch does not apply

Looking at the pci_psycho.c case:

@@ -12,12 +12,12 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_device.h>

There is no linux/of.h include in my copy.
