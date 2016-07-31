From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 31 Jul 2016 23:50:57 +0000
Subject: [PATCH 1/2] sparc: fix incorrect value returned by copy_from_user_fixup
Message-Id: <alpine.LRH.2.02.1607311949210.7784@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

When a fault in ___copy_from_user happens, the function
copy_from_user_fixup is called. It calls the function compute_size that
reads the faulting address from current_thread_info()->fault_address and
determines how many bytes were copied.

There are multiple ___copy_from_user implementations for various
processors. Some of these implementations read multiple values ahead, for
example this piece of code exists in U1copy_from_user.o:
     124:       c1 9a 4e 20     ldda  [ %o1 ] #ASI_BLK_AIUS, %f0
     128:       92 02 60 40     add  %o1, 0x40, %o1
     12c:       82 00 40 03     add  %g1, %g3, %g1
     130:       e1 9a 4e 20     ldda  [ %o1 ] #ASI_BLK_AIUS, %f16
     134:       92 02 60 40     add  %o1, 0x40, %o1
     138:       8e 21 e0 80     sub  %g7, 0x80, %g7
     13c:       c3 9a 4e 20     ldda  [ %o1 ] #ASI_BLK_AIUS, %f32
     140:       92 02 60 40     add  %o1, 0x40, %o1
     144:       97 28 a0 03     sll  %g2, 3, %o3
     148:       96 22 c0 02     sub  %o3, %g2, %o3
     14c:       97 2a f0 04     sllx  %o3, 4, %o3
     150:       96 02 c0 02     add  %o3, %g2, %o3
     154:       85 2a f0 02     sllx  %o3, 2, %g2
     158:       97 41 40 00     rd  %pc, %o3
     15c:       96 02 e0 28     add  %o3, 0x28, %o3
     160:       81 c2 c0 02     jmp  %o3 + %g2
     164:       01 00 00 00     nop

It prefetches 192 bytes into the floating point register file and
additional 64 bytes are fetched at the target of the jump.

If a page fault happens at some of these ldda instructions, the address of
the fauling page will be saved in current_thread_info()->fault_address.
The routine compute_size assumes that bytes up to the faulting address
were already copied. However this assumption may be wrong if the faulting
instruction is not the first ldda instruction.

This patch fixes the bug by subtracting 0x100 from the faulting address
when handling a fault in copy_from_user_fixup. So that when a fault
happens, it is assumed that bytes up to the faulting address minus 0x100
were copied.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc/lib/user_fixup.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-4.4.16/arch/sparc/lib/user_fixup.c
=================================--- linux-4.4.16.orig/arch/sparc/lib/user_fixup.c	2016-07-29 22:16:26.000000000 +0200
+++ linux-4.4.16/arch/sparc/lib/user_fixup.c	2016-07-31 01:37:14.000000000 +0200
@@ -11,6 +11,13 @@
 
 #include <asm/uaccess.h>
 
+/* The copy_from_user routine can read up to 0x100 bytes in advance before
+ * writing them to kernelspace.
+ * So, we must subtract this value from the fault address when copying from
+ * userspace.
+ */
+#define COPY_FROM_USER_PREFETCH		0x100
+
 /* Calculating the exact fault address when using
  * block loads and stores can be very complicated.
  *
@@ -18,9 +25,9 @@
  * of the cases, just fix things up simply here.
  */
 
-static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset)
+static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset, unsigned long prefetch)
 {
-	unsigned long fault_addr = current_thread_info()->fault_address;
+	unsigned long fault_addr = current_thread_info()->fault_address - prefetch;
 	unsigned long end = start + size;
 
 	if (fault_addr < start || fault_addr >= end) {
@@ -36,7 +43,7 @@ unsigned long copy_from_user_fixup(void
 {
 	unsigned long offset;
 
-	size = compute_size((unsigned long) from, size, &offset);
+	size = compute_size((unsigned long) from, size, &offset, COPY_FROM_USER_PREFETCH);
 	if (likely(size))
 		memset(to + offset, 0, size);
 
@@ -48,7 +55,7 @@ unsigned long copy_to_user_fixup(void __
 {
 	unsigned long offset;
 
-	return compute_size((unsigned long) to, size, &offset);
+	return compute_size((unsigned long) to, size, &offset, 0);
 }
 EXPORT_SYMBOL(copy_to_user_fixup);
 
