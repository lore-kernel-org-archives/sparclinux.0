From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Mon, 16 Jan 2017 18:12:13 +0000
Subject: [PATCH v2 1/2] sparc64: Zero pages on allocation for mondo and error queues.
Message-Id: <1484590334-15668-2-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Error queues use a non-zero first word to detect if the queues are full.
Using pages that have not been zeroed may result in false positive
overflow events.  These queues are set up once during boot so zeroing
all mondo and error queue pages is safe.

Note that the false positive overflow does not always occur because the
page allocation for these queues is so early in the boot cycle that
higher number CPUs get fresh pages.  It is only when traps are serviced
with lower number CPUs who were given already used pages that this issue
is exposed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/irq_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 34a7930..baed4cd 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -1021,7 +1021,7 @@ static void __init alloc_one_queue(unsigned long *pa_ptr, unsigned long qmask)
 	unsigned long order = get_order(size);
 	unsigned long p;
 
-	p = __get_free_pages(GFP_KERNEL, order);
+	p = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!p) {
 		prom_printf("SUN4V: Error, cannot allocate queue.\n");
 		prom_halt();
-- 
2.1.4

