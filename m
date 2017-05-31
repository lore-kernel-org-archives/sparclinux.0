From: David Miller <davem@davemloft.net>
Date: Wed, 31 May 2017 21:10:08 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170531.171008.528800003662477033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wbx@openadk.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


A fix for this is in Linus's tree and was submitted to -stable last
night:

==========
commit deba804c90642c8ed0f15ac1083663976d578f54
Author: Orlando Arias <oarias@knights.ucf.edu>
Date:   Tue May 16 15:34:00 2017 -0400

    sparc: Fix -Wstringop-overflow warning
    
    Greetings,
    
    GCC 7 introduced the -Wstringop-overflow flag to detect buffer overflows
    in calls to string handling functions [1][2]. Due to the way
    ``empty_zero_page'' is declared in arch/sparc/include/setup.h, this
    causes a warning to trigger at compile time in the function mem_init(),
    which is subsequently converted to an error. The ensuing patch fixes
    this issue and aligns the declaration of empty_zero_page to that of
    other architectures. Thank you.
    
    Cheers,
    Orlando.
    
    [1] https://gcc.gnu.org/ml/gcc-patches/2016-10/msg02308.html
    [2] https://gcc.gnu.org/gcc-7/changes.html
    
    Signed-off-by: Orlando Arias <oarias@knights.ucf.edu>
    
    --------------------------------------------------------------------------------
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index ce6f569..cf19072 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -91,9 +91,9 @@ extern unsigned long pfn_base;
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page;
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 
-#define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
+#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
 /*
  * In general all page table modifications should use the V8 atomic
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 478bf6bb..3fae200 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -16,7 +16,7 @@ extern char reboot_command[];
  */
 extern unsigned char boot_cpu_id;
 
-extern unsigned long empty_zero_page;
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 
 extern int serial_console;
 static inline int con_is_present(void)
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index c6afe98..3bd0d51 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -290,7 +290,7 @@ void __init mem_init(void)
 
 
 	/* Saves us work later. */
-	memset((void *)&empty_zero_page, 0, PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
 	i += 1;
