From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 15 Nov 2004 04:16:40 +0000
Subject: Re: initrd testing [possible solution]
Message-Id: <Pine.LNX.4.61.0411142254280.16540@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0411032344240.25808@bobcat>
In-Reply-To: <Pine.LNX.4.61.0411032344240.25808@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 4 Nov 2004, Jurij Smakov wrote:
[skipped]
> So, my conclusion is that __copy_1page is broken, at least under certain (yet 
> undetermined) conditions. If that's really the case, it either should be 
> fixed (requires knowledge of assembler, which I lack) or its use should be 
> avoided whatsoever. The latter is easy to achieve by modifying the memcpy() 
> definition in include/asm-sparc/string.h to call __memcpy instead.

As a followup: I have tried fiddling more with the memcpy() routine. 
Insight from Rob Radez and comments in arch/sparc/lib/blockops.S suggest, 
that __copy_1page assumes that the memory regions copied are aligned on a 
double-word boundary. I have checked, that in the cramfs case it wasn't 
true, the destination was not aligned on the double-word boundary. So, I
have implemented a simple workaround (see patch below), which together
with Bob Breuer's iommu.c fix [0] made 2.6.8 kernel to boot on my 
machine (SS10 with Ross Hypersparc CPU)! I also confirm, that adding the 
suggested fix to the srmmu.c also [1] breaks sunlance on my machine. With 
that "fix" the line 'eth0: Memory error, status 88c3, addr 3713ba' is
displayed continuously during boot, when it comes to configuring network
interfaces. The successful patch for me is:

--- build-sparc32.orig/include/asm-sparc/string.h	2004-08-14 01:36:11.000000000 -0400
+++ build-sparc32/include/asm-sparc/string.h	2004-11-14 22:09:49.000000000 -0500
@@ -40,6 +40,9 @@

  	if(n <= 32) {
  		__builtin_memcpy(to, from, n);
+	} else if (((unsigned int) to & 7) != 0) {
+		/* Destination is not aligned on the double-word boundary */
+		__memcpy(to, from, n);
  	} else {
  		switch(n) {
  		case PAGE_SIZE:
--- build-sparc32.orig/arch/sparc/mm/iommu.c	2004-08-14 01:38:08.000000000 -0400
+++ build-sparc32/arch/sparc/mm/iommu.c	2004-11-14 22:10:09.000000000 -0500
@@ -173,6 +173,7 @@
  	}

  	iommu_viking_flush_iotlb(iopte0, npages);
+	flush_cache_all();

  	return busa0;
  }

Note, that this patch is against the unpacked Debian kernel package's 
build-sparc32 tree, so it may be fuzzy w/respect to the pristine kernel.

[0] http://marc.theaimsgroup.com/?l=linux-sparc&m0005632921213&w=2
[1] http://marc.theaimsgroup.com/?l=linux-sparc&m0014079917049&w=2

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
