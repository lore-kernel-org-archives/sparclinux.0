From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 04:56:27 +0000
Subject: [4/3] fix initrd memcpy
Message-Id: <20041221045627.GC771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The latter hunk of the forwarded patch has already been applied, so
please apply the patch as it appears in the un-forwarded part. I've
taken some liberties in adding the Acked/Signed-off lines in what I
hope is an agreeable way.

On Sun, Nov 14, 2004 at 11:16:40PM -0500, Jurij Smakov wrote:
> As a followup: I have tried fiddling more with the memcpy() routine.
> Insight from Rob Radez and comments in arch/sparc/lib/blockops.S suggest,
> that __copy_1page assumes that the memory regions copied are aligned on a
> double-word boundary. I have checked, that in the cramfs case it wasn't
> true, the destination was not aligned on the double-word boundary. So, I
> have implemented a simple workaround (see patch below), which together
> with Bob Breuer's iommu.c fix [0] made 2.6.8 kernel to boot on my
> machine (SS10 with Ross Hypersparc CPU)! I also confirm, that adding the
> suggested fix to the srmmu.c also [1] breaks sunlance on my machine. With
> that "fix" the line 'eth0: Memory error, status 88c3, addr 3713ba' is
> displayed continuously during boot, when it comes to configuring network
> interfaces. The successful patch for me is:

Acked-by: William Irwin  <wli@holomorphy.com>
Acked-by: Dave Miller  <davem@davemloft.net>
Signed-off-by: Jurij Smakov <jurij@wooyd.org>

Index: sparc32-2.6.10-rc3/include/asm-sparc/string.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/string.h	2004-06-15 22:18:38.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/string.h	2004-12-20 20:53:00.585527010 -0800
@@ -40,6 +40,9 @@
 
 	if(n <= 32) {
 		__builtin_memcpy(to, from, n);
+	} else if (((unsigned int) to & 7) != 0) {
+		/* Destination is not aligned on the double-word boundary */
+		__memcpy(to, from, n);
 	} else {
 		switch(n) {
 		case PAGE_SIZE:
