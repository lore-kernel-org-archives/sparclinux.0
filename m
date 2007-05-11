From: David Miller <davem@davemloft.net>
Date: Fri, 11 May 2007 21:28:57 +0000
Subject: Re: 2.6.21+git warnings and error
Message-Id: <20070511.142857.85685073.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705111920580.26093@math>
In-Reply-To: <Pine.SOC.4.64.0705111920580.26093@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 11 May 2007 19:22:59 +0300 (EEST)

> WARNING: arch/sparc64/kernel/built-in.o - Section mismatch: reference to .init.text:pci_resource_adjust from .text between 'pcibios_resource_to_bus' (at offset 0xc2ac) and 'pcibios_bus_to_resource'
> WARNING: arch/sparc64/kernel/built-in.o - Section mismatch: reference to .init.text:pci_resource_adjust from .text between 'pcibios_bus_to_resource' (at offset 0xc318) and 'pcibios_setup'
> WARNING: arch/sparc64/kernel/built-in.o - Section mismatch: reference to .init.text:pci_resource_adjust from .text between 'pci_of_scan_bus' (at offset 0xcde8) and 'pci_scan_one_pbm'
> WARNING: arch/sparc64/kernel/built-in.o - Section mismatch: reference to .init.text:pci_resource_adjust from .text between 'pci_of_scan_bus' (at offset 0xced0) and 'pci_scan_one_pbm'
> WARNING: arch/sparc64/kernel/built-in.o - Section mismatch: reference to .init.text:pci_resource_adjust from .text between 'pci_of_scan_bus' (at offset 0xcf30) and 'pci_scan_one_pbm'

This one is easy, just remove that "__init" tag from pci_resource_adjust()
in arch/sparc64/kernel/pci.c, I'll commit that change.

> WARNING: mm/built-in.o - Section mismatch: reference to .init.text:set_up_list3s from .text between 'kmem_cache_create' (at offset 0x21db0) and 'quicklist_total_size'
> WARNING: mm/built-in.o - Section mismatch: reference to .init.text:set_up_list3s from .text between 'kmem_cache_create' (at offset 0x21eec) and 'quicklist_total_size'

This is a well known false-positive that Sam R. is working out
on lkml.

> ERROR: "proc_clear_tty" [arch/sparc64/solaris/solaris.ko] undefined!
> make[1]: *** [__modpost] Error 1

Some day I should either just delete the solaris compat stuff,
it lacks so much functionality it cannot possibly be useful
to anyone, or prevent it from being built modular becuase it
references a ton of stuff that has no buisness being exported
to modules.

Anyways, for now I'll fix it like this:

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index fe62c21..bc84995 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3880,6 +3880,7 @@ void proc_clear_tty(struct task_struct *p)
 	p->signal->tty = NULL;
 	spin_unlock_irq(&p->sighand->siglock);
 }
+EXPORT_SYMBOL(proc_clear_tty);
 
 static void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty)
 {
