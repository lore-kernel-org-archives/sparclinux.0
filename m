From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2007 21:34:55 +0000
Subject: [PATCH 7/7] sparc64: fix section mismatch warning in mdesc.c
Message-Id: <20070720213455.GH25064@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Wrong list address in first try.

----- Forwarded message from Sam Ravnborg <sam@ravnborg.org> -----

Subject: [PATCH 7/7] sparc64: fix section mismatch warning in mdesc.c
Sender: linux-kernel-owner@vger.kernel.org
From: Sam Ravnborg <sam@ravnborg.org>
Date:	Fri, 20 Jul 2007 23:31:30 +0200
User-Agent: Mutt/1.4.2.1i
To: LKML <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>, sparc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
X-Mailing-List:	linux-kernel@vger.kernel.org

Fix following warning:
WARNING: vmlinux.o(.text+0x35264): Section mismatch: reference to .init.text:__alloc_bootmem (between 'mdesc_bootmem_alloc' and 'mdesc_bootmem_free')

Rename mdesc_mem_ops to *_ops so modpost ignores __init references
and declare mdesc_bootmem_alloc __init since it is only used
during __init context.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/mdesc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc64/kernel/mdesc.c b/arch/sparc64/kernel/mdesc.c
index 13a79fe..cce4d0d 100644
--- a/arch/sparc64/kernel/mdesc.c
+++ b/arch/sparc64/kernel/mdesc.c
@@ -83,7 +83,7 @@ static void mdesc_handle_init(struct mdesc_handle *hp,
 	hp->handle_size = handle_size;
 }
 
-static struct mdesc_handle *mdesc_bootmem_alloc(unsigned int mdesc_size)
+static struct mdesc_handle * __init mdesc_bootmem_alloc(unsigned int mdesc_size)
 {
 	struct mdesc_handle *hp;
 	unsigned int handle_size, alloc_size;
@@ -123,7 +123,7 @@ static void mdesc_bootmem_free(struct mdesc_handle *hp)
 	}
 }
 
-static struct mdesc_mem_ops bootmem_mdesc_memops = {
+static struct mdesc_mem_ops bootmem_mdesc_ops = {
 	.alloc = mdesc_bootmem_alloc,
 	.free  = mdesc_bootmem_free,
 };
@@ -860,7 +860,7 @@ void __init sun4v_mdesc_init(void)
 
 	printk("MDESC: Size is %lu bytes.\n", len);
 
-	hp = mdesc_alloc(len, &bootmem_mdesc_memops);
+	hp = mdesc_alloc(len, &bootmem_mdesc_ops);
 	if (hp = NULL) {
 		prom_printf("MDESC: alloc of %lu bytes failed.\n", len);
 		prom_halt();
-- 
1.5.1.rc3.g84b7-dirty

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
