From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Jun 2012 16:58:07 +0000
Subject: [PATCH 2/2] sparc32: Remove superfluous extern declarations for prom_*() functions
Message-Id: <1340211487-24534-2-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1340211487-24534-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1340211487-24534-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

prom_meminit() and prom_ranges_init() are declared in <asm/oplib_32.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
--
Not even compile-tested

 arch/sparc/prom/init_32.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index a8d9342..9ac30c2 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -31,9 +31,6 @@ struct linux_nodeops *prom_nodeops;
  * It gets passed the pointer to the PROM vector.
  */
 
-extern void prom_meminit(void);
-extern void prom_ranges_init(void);
-
 void __init prom_init(struct linux_romvec *rp)
 {
 	romvec = rp;
-- 
1.7.0.4

