From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 21:34:44 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140918213444.GT17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Thu Sep 18 2014, 01:08:08PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Thu, 18 Sep 2014 06:09:12 -0400
> 
> > The machine hung after remapping. It could have been my mistake. Please
> > let me investigate.
> 
> I was hoping this would have been the simplest of the patches :-)
> 
> If you get stuck just print some debugging information with
> prom_printf() (the physical address of the KTSB, and the final
> instruction values after patching) then prom_halt() so it doesn't hang
> and you can reset more quickly.
> 
Sorry I was being yanked all over the place today. This boots on T5-2.
Now I'll look at your second version.


diff -u b/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
--- b/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -259,7 +259,7 @@
 	.section	.swapper_tsb_phys_patch, "ax"; \
 	.word		661b; \
 	.previous; \
-	sllx		REG1, 32, REG1; \
+	sllx		REG1, 22, REG1; \
 	or		REG1, REG2, REG1; \
 	srlx		VADDR, PAGE_SHIFT, REG2; \
 	and		REG2, (KERNEL_TSB_NENTRIES - 1), REG2; \
@@ -280,7 +280,7 @@
 	.section	.swapper_4m_tsb_phys_patch, "ax"; \
 	.word		661b; \
 	.previous; \
-	sllx		REG1, 32, REG1; \
+	sllx		REG1, 22, REG1; \
 	or		REG1, REG2, REG1; \
 	and		TAG, (KERNEL_TSB4M_NENTRIES - 1), REG2; \
 	sllx		REG2, 4, REG2; \
