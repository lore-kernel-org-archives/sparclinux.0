From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 05:27:44 +0000
Subject: Another gcc 3.4 fix
Message-Id: <20040512052744.GA31207@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ok, one more problem while using gcc 3.4.0. It has a "nice" feature called
"unit-at-a-time compilation", basically files are better "optimized" than
before (you can read more about it here:
http://gcc.gnu.org/gcc-3.4/changes.html).

In our case, the end result is some asm volatile statement gets whacked and
the linking then fails:

arch/sparc64/kernel/built-in.o(__ex_table+0x3c4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3cc): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3d4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3dc): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3e4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3ec): more undefined references to `kernel_unaligned_trap_fault' follow

I checked the output of gcc 3.4.0 for unaligned.c and here's what I had:
                 U 
                 U 
                 U 
                 U __bzero
0000000000000140 t compute_effective_address
                 U current_thread_info_reg
                 U data_access_exception
                 U die_if_kernel
                 U do_fpother
                 U do_privact
0000000000000000 t fetch_reg
00000000000000c0 t fetch_reg_addr
                 U __flushw_user
0000000000000d80 T handle_lddfmna
00000000000008a0 T handle_ldf_stq
0000000000000c40 T handle_ld_nf
0000000000000700 T handle_popc
0000000000000f80 T handle_stdfmna
0000000000000260 T kernel_mna_trap_fault
0000000000000360 T kernel_unaligned_trap
                 U kernel_unaligned_trap_fault
                 U __memcpy
                 U panic
0000000000000000 d popc_helper
                 U printk
                 U search_extables_range
                 U VISenter

See how kernel_unaligned_trap_fault is undefined? Obviously it
shouldn't...

I was trying to fix this but couldn't get the whole file to compile at all.
At the same time, I checked the output of gcc 3.3.3 (which is known to
work) and realized another function was missing: unaligned_panic.  

This one was easy, I just added __attribute_used__ to the function
declaration. To my surprise, it also solved the kernel_unaligned_trap_fault
issue, which I don't get: does it mean the first part of 
"if (!ok_for_kernel(insn) || dir = both) {"
in function kernel_unaligned_trap was removed too???

So with the patch attached, here's the correct output:
                 U 
                 U 
                 U 
                 U __bzero
0000000000000140 t compute_effective_address
                 U current_thread_info_reg
                 U data_access_exception
                 U die_if_kernel
                 U do_fpother
                 U do_privact
0000000000000000 t fetch_reg
00000000000000c0 t fetch_reg_addr
                 U __flushw_user
0000000000000dc0 T handle_lddfmna
00000000000008e0 T handle_ldf_stq
0000000000000c80 T handle_ld_nf
0000000000000740 T handle_popc
0000000000000fc0 T handle_stdfmna
0000000000000280 T kernel_mna_trap_fault
0000000000000380 T kernel_unaligned_trap
0000000000000544 t kernel_unaligned_trap_fault
                 U __memcpy
                 U panic
0000000000000000 d popc_helper
                 U printk
                 U search_extables_range
0000000000000260 t unaligned_panic
                 U VISenter

Now the kernel links but I still have some problems with the modules. I'll
take a look tomorrow.

--- arch/sparc64/kernel/unaligned.c.orig	2004-05-11 22:38:33.000000000 -0400
+++ arch/sparc64/kernel/unaligned.c	2004-05-12 00:53:11.000000000 -0400
@@ -175,7 +175,7 @@
 }
 
 /* This is just to make gcc think die_if_kernel does return... */
-static void unaligned_panic(char *str, struct pt_regs *regs)
+static void __attribute_used__ unaligned_panic(char *str, struct pt_regs *regs)
 {
 	die_if_kernel(str, regs);
 }



-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
