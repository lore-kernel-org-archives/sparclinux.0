From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 26 Aug 2007 17:08:58 +0000
Subject: [PATCH] restore_current o0 register clobber
Message-Id: <20070826190858.bc86dea7.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch changes call definitions of the restore_current(void)
to restore_current(int) to force usage of the o0 register. The o0
register is used internally and compiler must not assume
it is preserved during the call.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

Dave, if it is not a real issue please discard the patch.

I did the patch against the 2.6.23-rc3-git6 kernel. 
It does not help with crashes inside prom functions
I observe on the SMP kernel.

Longer explanation.

The "void restore_current(void)" definition does not
give any hint to the compiler that o0 register will be
trashed inside the call. See the following sequence:

    spin_lock_irqsave(&prom_lock, flags);
    if(prom_vers != PROM_V0)
        (*(romvec->pv_fortheval.v2_eval))(fstring);
    else
        ret = -1;
    restore_current();
    spin_unlock_irqrestore(&prom_lock, flags);

If the prom_vers is PROM_V0 the compiler
may assume that prom_lock address is still
in the o0 register which is not because the
restore_current() has overwritten it.

The added parameter forces the gcc to
load value into the o0 register before the
restore_current() call thus force reloading it
before the next call.

It does not matter in a simpler case:

    spin_lock_irqsave(&prom_lock, flags);
    (*(romvec->prom_call))(args);
    restore_current();
    spin_unlock_irqrestore(&prom_lock, flags);

because the o0 was used by the prom_call so it has to
be reloaded before the spin_unlock and no side effect
happens.

I don't know if it has something to do with the crash
in the atomic_add_unless() which I observe sometimes
on SMP kernel (SS20) around the floppy driver load
(just before or just after the text about FDC driver).
I can confirm it after few days of testing because it
happens randomly.

diff -urp linux-2.6.23/arch/sparc/kernel/prom.c linux-sparc/arch/sparc/kernel/prom.c
--- linux-2.6.23/arch/sparc/kernel/prom.c	2007-08-26 07:23:41.120488968 +0200
+++ linux-sparc/arch/sparc/kernel/prom.c	2007-08-26 18:36:48.122933751 +0200
@@ -421,7 +421,7 @@ EXPORT_SYMBOL(of_console_path);
 char *of_console_options;
 EXPORT_SYMBOL(of_console_options);
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 static void __init of_console_init(void)
 {
@@ -482,7 +482,7 @@ static void __init of_console_init(void)
 
 		spin_lock_irqsave(&prom_lock, flags);
 		node = (*romvec->pv_v2devops.v2_inst2pkg)(fd);
-		restore_current();
+		restore_current(0);
 		spin_unlock_irqrestore(&prom_lock, flags);
 
 		if (!node) {
diff -urp linux-2.6.23/arch/sparc/prom/console.c linux-sparc/arch/sparc/prom/console.c
--- linux-2.6.23/arch/sparc/prom/console.c	2007-08-26 07:23:41.232495351 +0200
+++ linux-sparc/arch/sparc/prom/console.c	2007-08-26 18:39:02.486590699 +0200
@@ -15,7 +15,7 @@
 #include <asm/system.h>
 #include <linux/string.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 static char con_name_jmc[] = "/obio/su@"; /* "/obio/su@0,3002f8"; */
 #define CON_SIZE_JMC	(sizeof(con_name_jmc))
@@ -48,7 +48,7 @@ prom_nbgetchar(void)
 		i = -1;
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return i; /* Ugh, we could spin forever on unsupported proms ;( */
 }
@@ -81,7 +81,7 @@ prom_nbputchar(char c)
 		i = -1;
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return i; /* Ugh, we could spin forever on unsupported proms ;( */
 }
diff -urp linux-2.6.23/arch/sparc/prom/devmap.c linux-sparc/arch/sparc/prom/devmap.c
--- linux-2.6.23/arch/sparc/prom/devmap.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-sparc/arch/sparc/prom/devmap.c	2007-08-26 18:37:14.780452876 +0200
@@ -11,7 +11,7 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 /* Just like the routines in palloc.c, these should not be used
  * by the kernel at all.  Bootloader facility mainly.  And again,
@@ -34,7 +34,7 @@ prom_mapio(char *vhint, int ios, unsigne
 	else
 	ret = (*(romvec->pv_v2devops.v2_dumb_mmap))(vhint, ios, paddr,
 						    num_bytes);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return ret;
 }
@@ -48,7 +48,7 @@ prom_unmapio(char *vaddr, unsigned int n
 	if(num_bytes = 0x0) return;
 	spin_lock_irqsave(&prom_lock, flags);
 	(*(romvec->pv_v2devops.v2_dumb_munmap))(vaddr, num_bytes);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return;
 }
diff -urp linux-2.6.23/arch/sparc/prom/devops.c linux-sparc/arch/sparc/prom/devops.c
--- linux-2.6.23/arch/sparc/prom/devops.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-sparc/arch/sparc/prom/devops.c	2007-08-26 18:37:40.085894951 +0200
@@ -10,7 +10,7 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 /* Open the device described by the string 'dstr'.  Returns the handle
  * to that device used for subsequent operations on that device.
@@ -35,7 +35,7 @@ prom_devopen(char *dstr)
 		handle = -1;
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return handle;
@@ -58,7 +58,7 @@ prom_devclose(int dhandle)
 	default:
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return 0;
 }
@@ -82,7 +82,7 @@ prom_seek(int dhandle, unsigned int seek
 	default:
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return;
diff -urp linux-2.6.23/arch/sparc/prom/misc.c linux-sparc/arch/sparc/prom/misc.c
--- linux-2.6.23/arch/sparc/prom/misc.c	2007-08-26 07:23:41.236495579 +0200
+++ linux-sparc/arch/sparc/prom/misc.c	2007-08-26 18:39:19.123538785 +0200
@@ -13,7 +13,7 @@
 #include <asm/auxio.h>
 #include <asm/system.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 DEFINE_SPINLOCK(prom_lock);
 
@@ -25,7 +25,7 @@ prom_reboot(char *bcommand)
 	spin_lock_irqsave(&prom_lock, flags);
 	(*(romvec->pv_reboot))(bcommand);
 	/* Never get here. */
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 }
 
@@ -41,7 +41,7 @@ prom_feval(char *fstring)
 		(*(romvec->pv_fortheval.v0_eval))(strlen(fstring), fstring);
 	else
 		(*(romvec->pv_fortheval.v2_eval))(fstring);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 }
 
@@ -63,7 +63,7 @@ prom_cmdline(void)
 	spin_lock_irqsave(&prom_lock, flags);
 	install_obp_ticker();
 	(*(romvec->pv_abort))();
-	restore_current();
+	restore_current(0);
 	install_linux_ticker();
 	spin_unlock_irqrestore(&prom_lock, flags);
 #ifdef CONFIG_SUN_AUXIO
@@ -84,7 +84,7 @@ again:
 	spin_lock_irqsave(&prom_lock, flags);
 	(*(romvec->pv_halt))();
 	/* Never get here. */
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	goto again; /* PROM is out to get me -DaveM */
 }
diff -urp linux-2.6.23/arch/sparc/prom/mp.c linux-sparc/arch/sparc/prom/mp.c
--- linux-2.6.23/arch/sparc/prom/mp.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-sparc/arch/sparc/prom/mp.c	2007-08-26 18:38:00.471056635 +0200
@@ -12,7 +12,7 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 /* Start cpu with prom-tree node 'cpunode' using context described
  * by 'ctable_reg' in context 'ctx' at program counter 'pc'.
@@ -36,7 +36,7 @@ prom_startcpu(int cpunode, struct linux_
 		ret = (*(romvec->v3_cpustart))(cpunode, (int) ctable_reg, ctx, pc);
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return ret;
@@ -62,7 +62,7 @@ prom_stopcpu(int cpunode)
 		ret = (*(romvec->v3_cpustop))(cpunode);
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return ret;
@@ -88,7 +88,7 @@ prom_idlecpu(int cpunode)
 		ret = (*(romvec->v3_cpuidle))(cpunode);
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return ret;
@@ -114,7 +114,7 @@ prom_restartcpu(int cpunode)
 		ret = (*(romvec->v3_cpuresume))(cpunode);
 		break;
 	};
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return ret;
diff -urp linux-2.6.23/arch/sparc/prom/segment.c linux-sparc/arch/sparc/prom/segment.c
--- linux-2.6.23/arch/sparc/prom/segment.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-sparc/arch/sparc/prom/segment.c	2007-08-26 18:38:23.052343469 +0200
@@ -12,7 +12,7 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 /* Set physical segment 'segment' at virtual address 'vaddr' in
  * context 'ctx'.
@@ -23,7 +23,7 @@ prom_putsegment(int ctx, unsigned long v
 	unsigned long flags;
 	spin_lock_irqsave(&prom_lock, flags);
 	(*(romvec->pv_setctxt))(ctx, (char *) vaddr, segment);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return;
 }
diff -urp linux-2.6.23/arch/sparc/prom/tree.c linux-sparc/arch/sparc/prom/tree.c
--- linux-2.6.23/arch/sparc/prom/tree.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-sparc/arch/sparc/prom/tree.c	2007-08-26 18:38:48.297782125 +0200
@@ -16,7 +16,7 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
-extern void restore_current(void);
+extern void restore_current(int);
 
 static char promlib_buf[128];
 
@@ -28,7 +28,7 @@ int __prom_getchild(int node)
 
 	spin_lock_irqsave(&prom_lock, flags);
 	cnode = prom_nodeops->no_child(node);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return cnode;
@@ -59,7 +59,7 @@ int __prom_getsibling(int node)
 
 	spin_lock_irqsave(&prom_lock, flags);
 	cnode = prom_nodeops->no_nextnode(node);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return cnode;
@@ -95,7 +95,7 @@ int prom_getproplen(int node, char *prop
 		
 	spin_lock_irqsave(&prom_lock, flags);
 	ret = prom_nodeops->no_proplen(node, prop);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return ret;
 }
@@ -115,7 +115,7 @@ int prom_getproperty(int node, char *pro
 	/* Ok, things seem all right. */
 	spin_lock_irqsave(&prom_lock, flags);
 	ret = prom_nodeops->no_getprop(node, prop, buffer);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return ret;
 }
@@ -213,7 +213,7 @@ char * __prom_nextprop(int node, char * 
 
 	spin_lock_irqsave(&prom_lock, flags);
 	prop = prom_nodeops->no_nextprop(node, oprop);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 
 	return prop;
@@ -312,7 +312,7 @@ int prom_setprop(int node, char *pname, 
 	if((pname = 0) || (value = 0)) return 0;
 	spin_lock_irqsave(&prom_lock, flags);
 	ret = prom_nodeops->no_setprop(node, pname, value, size);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	return ret;
 }
@@ -324,7 +324,7 @@ int prom_inst2pkg(int inst)
 	
 	spin_lock_irqsave(&prom_lock, flags);
 	node = (*romvec->pv_v2devops.v2_inst2pkg)(inst);
-	restore_current();
+	restore_current(0);
 	spin_unlock_irqrestore(&prom_lock, flags);
 	if (node = -1) return 0;
 	return node;
