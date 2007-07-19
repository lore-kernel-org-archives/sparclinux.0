From: "root" <root@task.sun.mcst.ru>
Date: Thu, 19 Jul 2007 16:07:22 +0000
Subject: [PATCH 2.4.25] sparc32: fix bug in sparc optimized memset
Message-Id: <20070719160722.GA23687@liza>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sparc optimized memset (arch/sparc/lib/memset.S) does not fill last byte of the memory area,
if area size is less than 8 bytes and start address is not word (4-bytes) aligned,
Recent Linux kernels have same memset.S and affected by this bug too.

Here is code chunk where bug located:
/* %o0 - memory address, %o1 - size, %g3 - value */
8:
     add    %o0, 1, %o0
    subcc    %o1, 1, %o1
    bne,a    8b
     stb %g3, [%o0 - 1]

This code should write byte every loop iteration, but last time delay instruction stb is not 
executed because branch instruction sets "annul" bit.

Patch replaces bne,a by bne instruction.





Error can be reproduced by simple kernel module:

#include <linux/module.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <string.h>

static void do_memset(void **p, int size)
{
        memset(p, 0x00, size);
}

static int __init memset_test_init(void)
{
    char fooc[8];
    int *fooi;
    memset(fooc, 0xba, sizeof(fooc));

    do_memset((void**)(fooc + 3), 1);

    fooi = (int*) fooc;
    printk("%08X %08X\n", fooi[0], fooi[1]);

    return -1;
}

static void __exit memset_test_cleanup(void)
{
    return;
}

module_init(memset_test_init);
module_exit(memset_test_cleanup);

MODULE_LICENSE("GPL");
EXPORT_NO_SYMBOLS;


	


Signed-off-by: Alexander Shmelev <ashmelev@task.sun.mcst.ru>
---
--- linux-2.4.25-orig/arch/sparc/lib/memset.S	2003-11-28 21:26:19.000000000 +0300
+++ linux-2.4.25/arch/sparc/lib/memset.S	2007-07-19 18:56:05.000000000 +0400
@@ -163,7 +163,7 @@
 8:
 	 add	%o0, 1, %o0
 	subcc	%o1, 1, %o1
-	bne,a	8b
+	bne	8b
 	 EX(stb	%g3, [%o0 - 1], add %o1, 1)
 0:
 	retl
