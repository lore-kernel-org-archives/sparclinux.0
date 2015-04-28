From: Chris Metcalf <cmetcalf@ezchip.com>
Date: Tue, 28 Apr 2015 14:41:47 +0000
Subject: [PATCH] tile: properly use node_isset() on a nodemask_t
Message-Id: <1430232107-15041-1-git-send-email-cmetcalf@ezchip.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
In-Reply-To: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Geert Uytterhoeven <geert@linux-m68k.org> Rusty Russell" <rusty@rustcorp.com.au>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux <sparclinux@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Matthew Wilcox <willy@linux.intel.com>

The code accidentally used cpu_isset() previously in one place
(though properly node_isset() elsewhere).

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/tile/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/tile/kernel/setup.c b/arch/tile/kernel/setup.c
index 6873f006f7d0..d366675e4bf8 100644
--- a/arch/tile/kernel/setup.c
+++ b/arch/tile/kernel/setup.c
@@ -774,7 +774,7 @@ static void __init zone_sizes_init(void)
 		 * though, there'll be no lowmem, so we just alloc_bootmem
 		 * the memmap.  There will be no percpu memory either.
 		 */
-		if (i != 0 && cpumask_test_cpu(i, &isolnodes)) {
+		if (i != 0 && node_isset(i, isolnodes)) {
 			node_memmap_pfn[i]  				alloc_bootmem_pfn(0, memmap_size, 0);
 			BUG_ON(node_percpu[i] != 0);
-- 
2.1.2

