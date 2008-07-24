From: David Miller <davem@davemloft.net>
Date: Thu, 24 Jul 2008 21:59:01 +0000
Subject: Re: [Bug 11046] New: Kernel bug in mm/bootmem.c on Sparc machines
Message-Id: <20080724.145901.247647559.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080723203836.e0c14568.akpm@linux-foundation.org>
	<20080723.204247.114065226.davem@davemloft.net>
	<873alz55pl.fsf@saeurebad.de>
In-Reply-To: <873alz55pl.fsf@saeurebad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hannes@saeurebad.de
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, lomp0101@gmx.net, linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@saeurebad.de>
Date: Thu, 24 Jul 2008 23:32:06 +0200

> Sorry, Dave, I missed that before: there is still the BUG_ON() in
> can_reserve_bootmem_core(), which should just return 0 instead.
> 
> Other than that, yes, Andrew, this introduces the same behaviour the
> bootmem rewrite.

Thanks, here is an updated version of the patch:

bootmem: Allow zero length reserve and free.

It's either this or all the call sites explicitly check
when such a case is possible and sometimes expected.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 8d9f60e..5e3fab8 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -117,7 +117,8 @@ static int __init can_reserve_bootmem_core(bootmem_data_t *bdata,
 	unsigned long sidx, eidx;
 	unsigned long i;
 
-	BUG_ON(!size);
+	if (!size)
+		return 0;
 
 	/* out of range, don't hold other */
 	if (addr + size < bdata->node_boot_start ||
@@ -153,7 +154,8 @@ static void __init reserve_bootmem_core(bootmem_data_t *bdata,
 	unsigned long sidx, eidx;
 	unsigned long i;
 
-	BUG_ON(!size);
+	if (!size)
+		return;
 
 	/* out of range */
 	if (addr + size < bdata->node_boot_start ||
@@ -187,7 +189,8 @@ static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
 	unsigned long sidx, eidx;
 	unsigned long i;
 
-	BUG_ON(!size);
+	if (!size)
+		return;
 
 	/* out range */
 	if (addr + size < bdata->node_boot_start ||
