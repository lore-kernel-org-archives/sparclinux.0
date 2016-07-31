From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 31 Jul 2016 23:52:39 +0000
Subject: [PATCH 2/2] sparc: fix fault detection in copy_in_user
Message-Id: <alpine.LRH.2.02.1607311951040.7784@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

When a fault happens in the function ___copy_in_user, it returns 1. Then,
we call a function copy_in_user_fixup that determines how much data were
left uncopied and it returns this value.

The function copy_in_user_fixup reads the faulting address from
current_thread_info()->fault_address and checks if it falls into the
destination or source range. If it falls into one of these ranges, it is
assumed that some data were copied and the residue is returned.

However, the address read from current_thread_info()->fault_address is not
exact. On UltraSparc processors, the address is obtained from the
TLB_TAG_ACCESS register. Lower 13 bits of the register contain the context
ID, not the faulting address. The address is rounded down to a page
boundary in the TLB fault handler.

This address rounding can cause incorrect calculation in
copy_in_user_fixup because it is not known if the address belongs to the
destination range or source range.

For example, we call copy_in_user(0x1ff0, 0x2800, 0x100) and a fault
happens when reading the first byte at 0x2800. The fault address is
rounded down to a page boundary - the result is 0x2000. The function
copy_in_user_fixup finds out that the address 0x2000 is within the
destination range - thus the function incorrectly assumes that 0x10 bytes
were already copied. In fact, no bytes were copied.

This patch fixes the bug by discriminating read and write faults in
___copy_in_user. We return 1 if a read instruction failed and 2 if a write
instruction failed. The return value is passed to copy_to_user_fixup.
copy_to_user_fixup compares the faulting address against the source range
or destination range depending on this value.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 arch/sparc/include/asm/uaccess_64.h |    4 ++--
 arch/sparc/kernel/head_64.S         |    6 +++++-
 arch/sparc/lib/copy_in_user.S       |   26 +++++++++++++++++---------
 arch/sparc/lib/user_fixup.c         |    6 +++---
 4 files changed, 27 insertions(+), 15 deletions(-)

Index: linux-4.4.16/arch/sparc/kernel/head_64.S
=================================--- linux-4.4.16.orig/arch/sparc/kernel/head_64.S	2016-07-30 00:26:55.000000000 +0200
+++ linux-4.4.16/arch/sparc/kernel/head_64.S	2016-07-30 00:28:15.000000000 +0200
@@ -922,7 +922,6 @@ prom_tba:	.xword	0
 tlb_type:	.word	0	/* Must NOT end up in BSS */
 	.section	".fixup",#alloc,#execinstr
 
-	.globl	__ret_efault, __retl_efault, __ret_one, __retl_one
 ENTRY(__ret_efault)
 	ret
 	 restore %g0, -EFAULT, %o0
@@ -963,6 +962,11 @@ ENTRY(__retl_one_asi_fp)
 	 mov	1, %o0
 ENDPROC(__retl_one_asi_fp)
 
+ENTRY(__retl_two)
+	retl
+	 mov	2, %o0
+ENDPROC(__retl_two)
+
 ENTRY(__retl_o1)
 	retl
 	 mov	%o1, %o0
Index: linux-4.4.16/arch/sparc/lib/copy_in_user.S
=================================--- linux-4.4.16.orig/arch/sparc/lib/copy_in_user.S	2016-07-30 00:25:55.000000000 +0200
+++ linux-4.4.16/arch/sparc/lib/copy_in_user.S	2016-07-30 00:30:13.000000000 +0200
@@ -8,7 +8,7 @@
 
 #define XCC xcc
 
-#define EX(x,y)			\
+#define EX_LD(x,y)		\
 98:	x,y;			\
 	.section __ex_table,"a";\
 	.align 4;		\
@@ -16,6 +16,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_ST(x,y)		\
+98:	x,y;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_two;	\
+	.text;			\
+	.align 4;
+
 	.register	%g2,#scratch
 	.register	%g3,#scratch
 
@@ -44,8 +52,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=s
 	andn		%o2, 0x7, %o4
 	and		%o2, 0x7, %o2
 1:	subcc		%o4, 0x8, %o4
-	EX(ldxa [%o1] %asi, %o5)
-	EX(stxa %o5, [%o0] %asi)
+	EX_LD(ldxa [%o1] %asi, %o5)
+	EX_ST(stxa %o5, [%o0] %asi)
 	add		%o1, 0x8, %o1
 	bgu,pt		%XCC, 1b
 	 add		%o0, 0x8, %o0
@@ -53,8 +61,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=s
 	be,pt		%XCC, 1f
 	 nop
 	sub		%o2, 0x4, %o2
-	EX(lduwa [%o1] %asi, %o5)
-	EX(stwa %o5, [%o0] %asi)
+	EX_LD(lduwa [%o1] %asi, %o5)
+	EX_ST(stwa %o5, [%o0] %asi)
 	add		%o1, 0x4, %o1
 	add		%o0, 0x4, %o0
 1:	cmp		%o2, 0
@@ -70,8 +78,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=s
 
 82:
 	subcc		%o2, 4, %o2
-	EX(lduwa [%o1] %asi, %g1)
-	EX(stwa %g1, [%o0] %asi)
+	EX_LD(lduwa [%o1] %asi, %g1)
+	EX_ST(stwa %g1, [%o0] %asi)
 	add		%o1, 4, %o1
 	bgu,pt		%XCC, 82b
 	 add		%o0, 4, %o0
@@ -82,8 +90,8 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=s
 	.align	32
 90:
 	subcc		%o2, 1, %o2
-	EX(lduba [%o1] %asi, %g1)
-	EX(stba %g1, [%o0] %asi)
+	EX_LD(lduba [%o1] %asi, %g1)
+	EX_ST(stba %g1, [%o0] %asi)
 	add		%o1, 1, %o1
 	bgu,pt		%XCC, 90b
 	 add		%o0, 1, %o0
Index: linux-4.4.16/arch/sparc/include/asm/uaccess_64.h
=================================--- linux-4.4.16.orig/arch/sparc/include/asm/uaccess_64.h	2016-07-30 00:34:21.000000000 +0200
+++ linux-4.4.16/arch/sparc/include/asm/uaccess_64.h	2016-07-30 00:34:37.000000000 +0200
@@ -279,14 +279,14 @@ unsigned long __must_check ___copy_in_us
 					   const void __user *from,
 					   unsigned long size);
 unsigned long copy_in_user_fixup(void __user *to, void __user *from,
-				 unsigned long size);
+				 unsigned long size, int fault_type);
 static inline unsigned long __must_check
 copy_in_user(void __user *to, void __user *from, unsigned long size)
 {
 	unsigned long ret = ___copy_in_user(to, from, size);
 
 	if (unlikely(ret))
-		ret = copy_in_user_fixup(to, from, size);
+		ret = copy_in_user_fixup(to, from, size, ret);
 	return ret;
 }
 #define __copy_in_user copy_in_user
Index: linux-4.4.16/arch/sparc/lib/user_fixup.c
=================================--- linux-4.4.16.orig/arch/sparc/lib/user_fixup.c	2016-07-30 00:32:00.000000000 +0200
+++ linux-4.4.16/arch/sparc/lib/user_fixup.c	2016-07-30 00:34:47.000000000 +0200
@@ -59,18 +59,18 @@ unsigned long copy_to_user_fixup(void __
 }
 EXPORT_SYMBOL(copy_to_user_fixup);
 
-unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned long size)
+unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned long size, int fault_type)
 {
 	unsigned long fault_addr = current_thread_info()->fault_address;
 	unsigned long start = (unsigned long) to;
 	unsigned long end = start + size;
 
-	if (fault_addr >= start && fault_addr < end)
+	if (fault_type = 2 && fault_addr >= start && fault_addr < end)
 		return end - fault_addr;
 
 	start = (unsigned long) from;
 	end = start + size;
-	if (fault_addr >= start && fault_addr < end)
+	if (fault_type = 1 && fault_addr >= start && fault_addr < end)
 		return end - fault_addr;
 
 	return size;
