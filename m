From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 05 Aug 2013 17:06:04 +0000
Subject: [PATCH]sparc64: Flush locked TLB entries used to map initmem
Message-Id: <48681375722364@web3g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Check if __init_begin <= (some 4Mb aligned address) < __init_end.
If true then flush corresponding 4Mb TLB page.

Move BSS at the middle of the image to make initmem be last range
of mapped kernel area.

It's not likely case, but sometimes can be useful.

I use flush_tlb_kernel_range which flushes 8K pages sequentially
and only the first flush() has a result. It seems it's not necessary
to introduce new function for one-time boot use...

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/head_64.S     |    4 ++--
 arch/sparc/kernel/vmlinux.lds.S |    3 ++-
 arch/sparc/mm/init_64.c         |   17 +++++++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 26b706a..81dbb74 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -681,8 +681,8 @@ tlb_fixup_done:
 	/* Clear the bss */
 	sethi	%hi(__bss_start), %o0
 	or	%o0, %lo(__bss_start), %o0
-	sethi	%hi(_end), %o1
-	or	%o1, %lo(_end), %o1
+	sethi	%hi(__bss_stop), %o1
+	or	%o1, %lo(__bss_stop), %o1
 	call	__bzero
 	 sub	%o1, %o0, %o1
 
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 0bacceb..be57226 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -64,6 +64,8 @@ SECTIONS
 	/* End of data section */
 	_edata = .;
 
+	BSS_SECTION(0, 0, 0)
+
 	.fixup : {
 		__start___fixup = .;
 		*(.fixup)
@@ -141,7 +143,6 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-	BSS_SECTION(0, 0, 0)
 	_end = . ;
 
 	STABS_DEBUG
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ed82eda..52bfcf8 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2079,6 +2079,21 @@ void __init mem_init(void)
 		cheetah_ecache_flush_init();
 }
 
+/* Flush locked TLB entry (entries) if it is used to map initmem range
+ * only, i.e. __init_begin <= (some 4Mb aligned address) < __init_end.
+ */
+static void flush_initmem_tlb_entries(void)
+{
+	unsigned long begin = round_up((unsigned long)(__init_begin), 1 << 22);
+	unsigned long end = round_up((unsigned long)(__init_end), 1 << 22);
+
+	if (begin >= end)
+		return;
+
+	pr_info("TLB: Flushing initmem range [%016lx, %016lx]\n", begin, end-1);
+	flush_tlb_kernel_range(begin, end);
+}
+
 void free_initmem(void)
 {
 	unsigned long addr, initend;
@@ -2108,6 +2123,8 @@ void free_initmem(void)
 		if (do_free)
 			free_reserved_page(virt_to_page(page));
 	}
+
+	flush_initmem_tlb_entries();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
