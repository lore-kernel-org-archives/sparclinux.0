From: David Miller <davem@davemloft.net>
Date: Fri, 26 Jan 2007 11:01:51 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <20070126.030151.92583388.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Vince, I think I figured out what the bug is, can you test the
following patch?  If we set %g5 with the fault address here, we have
to set %g4 too.  This allows to correctly handle a DTLB-PROT trap for
a window spill during trap entry for another top-level fault.  The
non-Niagara DTLB-PROT code does this properly, it's just the sun4v
side that had the bug.

This is why in your logs the address was in the stack, but the fault
code was I-TLB :-)

Thanks a lot!

diff --git a/arch/sparc64/kernel/sun4v_tlb_miss.S b/arch/sparc64/kernel/sun4v_tlb_miss.S
index b731881..9871dbb 100644
--- a/arch/sparc64/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc64/kernel/sun4v_tlb_miss.S
@@ -142,9 +142,9 @@ sun4v_dtlb_prot:
 	rdpr	%tl, %g1
 	cmp	%g1, 1
 	bgu,pn	%xcc, winfix_trampoline
-	 nop
-	ba,pt	%xcc, sparc64_realfault_common
 	 mov	FAULT_CODE_DTLB | FAULT_CODE_WRITE, %g4
+	ba,pt	%xcc, sparc64_realfault_common
+	 nop
 
 	/* Called from trap table:
 	 * %g4:	vaddr
