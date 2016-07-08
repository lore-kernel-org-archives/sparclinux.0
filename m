From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 08 Jul 2016 23:02:46 +0000
Subject: [PATCH] sparc: round fault_address down to a page boundary
Message-Id: <alpine.LRH.2.02.1607081802110.16734@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

There is a bug in kernels 3.19-4.6 on sparc64: when creating pixmaps in
Xserver's memory, pixmaps get corrupted with horizontal black lines. See
for example this screenshot:
http://people.redhat.com/~mpatocka/screenshots/screenshot-20160708_1944.png

The bug is introduced by the patch e5a4b0bb803b ("switch memcpy_to_msg() 
and skb_copy{,_and_csum}_datagram_msg() to primitives"), specifically the 
change from skb_copy_datagram_iovec to skb_copy_datagram_iter.

skb_copy_datagram_iter calls copy_page_to_iter_iovec.
copy_page_to_iter_iovec tries to copy data in the fast path with
kmap_atomic (see the branch "if (!fault_in_pages_writeable(buf, copy))")
and if it fails, it resorts to the slow path using kmap. When I disable
the fast path, the bug goes away - so the bug must be caused by the fast
path.

On sparc64, __copy_to_user_inatomic is defined as copy_to_user.
copy_to_user calls ___copy_to_user and if it fails due to a page fault, it
calls copy_to_user_fixup to determine how much data were left uncopied.
copy_to_user_fixup calls compute_size and it accesses
current_thread_info()->fault_address to determine the location of the last
page fault.

I found out that (on UltraSparcIIi) current_thread_info()->fault_address
doesn't point to the beginning of a page that failed, but it points
somewhere to the middle of the page.

When I added 'printk("copy_to_user_fixup: to %p, size %lx, fault %lx\n",
to, size, current_thread_info()->fault_address);' to copy_to_user_fixup, I
got this result:
[   73.637610] copy_to_user_fixup: to 00000000f6eded48, size 8000, fault f6ee0613
[   73.638097] copy_to_user_fixup: to 00000000f6ee8c08, size 8000, fault f6eea613
[   73.638602] copy_to_user_fixup: to 00000000f6ef2ac8, size 8000, fault f6ef4613
[   73.642629] copy_to_user_fixup: to 00000000f6efc988, size 8000, fault f6efe613
[   73.643371] copy_to_user_fixup: to 00000000f6f06848, size 8000, fault f6f08613
[  179.669055] copy_to_user_fixup: to 00000000007a6880, size 8000, fault 7ac579
[  179.669582] copy_to_user_fixup: to 00000000007b0740, size 8000, fault 7b2579
[  179.670253] copy_to_user_fixup: to 00000000007ba600, size 8000, fault 7bc579
[  179.670906] copy_to_user_fixup: to 00000000007c44c0, size 8000, fault 7c6579
[  179.671555] copy_to_user_fixup: to 00000000007ce380, size 8000, fault 7d0579
[  179.673685] copy_to_user_fixup: to 00000000007d8240, size 8000, fault 7da579
[  179.675480] copy_to_user_fixup: to 00000000007e0998, size 4000, fault 7e2579
[ 1649.311188] copy_to_user_fixup: to 00000000f705fec8, size 8000, fault f70606dd
[ 1649.311865] copy_to_user_fixup: to 00000000f7069d88, size 8000, fault f706a6dd
[ 1649.312457] copy_to_user_fixup: to 00000000f7073c48, size 8000, fault f70746dd
[ 1649.314116] copy_to_user_fixup: to 00000000f707db08, size 8000, fault f707e6dd
[ 1649.314675] copy_to_user_fixup: to 00000000f70879c8, size 8000, fault f70886dd
[ 1649.315239] copy_to_user_fixup: to 00000000f7091888, size 8000, fault f70926dd

Consequently copy_to_user_fixup believes that copying stopped somewhere in
the middle of the faulting page, it returns higher value than it should,
part of data is not copied and that results in the horizontal black lines
observed in Xserver.

This patch fixes the bug by rounding fault_address down to a page boundary.

Note that the patch b8ca9e3a612e ("mm: tighten
fault_in_pages_writeable()") made the screen corruption go away in
4.7-rc1 (because it changes the code so that the fast path is not tried
when writing to 3 or more pages), but the bug that __copy_to_user_inatomic
returns incorrect value is still present.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/arch/sparc/lib/user_fixup.c
=================================--- linux-2.6.orig/arch/sparc/lib/user_fixup.c
+++ linux-2.6/arch/sparc/lib/user_fixup.c
@@ -20,7 +20,7 @@
 
 static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset)
 {
-	unsigned long fault_addr = current_thread_info()->fault_address;
+	unsigned long fault_addr = current_thread_info()->fault_address & -PAGE_SIZE;
 	unsigned long end = start + size;
 
 	if (fault_addr < start || fault_addr >= end) {
