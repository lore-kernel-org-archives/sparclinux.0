From: David Miller <davem@davemloft.net>
Date: Thu, 24 Jul 2008 03:42:47 +0000
Subject: Re: [Bug 11046] New: Kernel bug in mm/bootmem.c on Sparc machines
Message-Id: <20080723.204247.114065226.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080706132049.4019e09f.akpm@linux-foundation.org>
	<20080723.202533.114601491.davem@davemloft.net>
	<20080723203836.e0c14568.akpm@linux-foundation.org>
In-Reply-To: <20080723203836.e0c14568.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, lomp0101@gmx.net, linux-kernel@vger.kernel.org, hannes@saeurebad.de

From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 23 Jul 2008 20:38:36 -0700

> So if we're going to change it in 2.6.26, we'll need a separate patch.

Here is the 2.6.26 version:

bootmem: Allow zero length reserve and free.

It's either this or all the call sites explicitly check
when such a case is possible and sometimes expected.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 8d9f60e..e540f7a 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -153,7 +153,8 @@ static void __init reserve_bootmem_core(bootmem_data_t *bdata,
 	unsigned long sidx, eidx;
 	unsigned long i;
 
-	BUG_ON(!size);
+	if (!size)
+		return;
 
 	/* out of range */
 	if (addr + size < bdata->node_boot_start ||
@@ -187,7 +188,8 @@ static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
 	unsigned long sidx, eidx;
 	unsigned long i;
 
-	BUG_ON(!size);
+	if (!size)
+		return;
 
 	/* out range */
 	if (addr + size < bdata->node_boot_start ||
