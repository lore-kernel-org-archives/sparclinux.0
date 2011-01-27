From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 27 Jan 2011 11:08:21 +0000
Subject: Re: [PATCH] SPARC/LEON: power down instruction different of	different
Message-Id: <4D415225.8070000@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059842-22837-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059842-22837-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>On Wed, Jan 26, 2011 at 05:37:22PM +0100, Daniel Hellstrom wrote:
>  
>
>>The way a LEON is powered down is implemented differently depending
>>on CHIP type. The AMBA Plug&Play system ID tells revision of GRLIB
>>and CHIP.
>>
>>This is for example needed by the GR-LEON4-ITX board and the UT699.
>>
>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>    
>>
>
>It is not obvious for me how leon_pmc interact with the existing pmc.c
>implmentation. I guess the latter fails during probe and is thus ignored.
>
>Some comments below - mostly general or nitpick.
>
>	Sam
>  
>
Ok, I will resend this patch.

Daniel

>  
>
>>+
>>+	/* Find System ID: GRLIB build ID and optional CHIP ID */
>>+	pp = of_find_property(rootnp, "systemid", &len);
>>+	if (pp)
>>+		amba_system_id = *(unsigned long *)pp->value;
>>+
>>+	/*Find IRQMP IRQ Controller Registers base address otherwise bail out.*/
>>    
>>
>
>If you are going to resubmit then fix this comment (add a space)
>
>  
>
>>+ * Copyright (C) 2011 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
>>+ */
>>+
>>+#include <linux/pm.h>
>>+#include <linux/init.h>
>>+#include <asm/leon.h>
>>+#include <asm/leon_amba.h>
>>    
>>
>
>For this number of includes it does not matter.
>But in general we use the inverse christmas tree way.
>Longer lines first. Lines with identical length sorted alphabetically.
>And an empty line between the include groups.
>
>  
>
>>+/*
>>+ * CPU idle callback function for systems that need some extra handling
>>+ * See .../arch/sparc/kernel/process.c
>>+ */
>>+void pmc_leon_idle_fixup(void)
>>+{
>>+	/* Prepare an address to a non-cachable region. APB is always
>>+	 * none-cachable. One instruction is executed after the Sleep
>>+	 * instruction, we make sure to read the bus and throw away the
>>+	 * value by accessing a non-cachable area, also we make sure the
>>+	 * MMU does not get a TLB miss here by using the MMU BYPASS ASI.
>>+	 */
>>+	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
>>+	__asm__ __volatile__ (
>>+		"mov	%%g0, %%asr19\n"
>>+		"lda	[%0] %1, %%g0\n"
>>+		:
>>+		: "r"(address), "i"(ASI_LEON_BYPASS));
>>+}
>>    
>>
>
>Good to see the rasons commented!
>
>  
>
>>+
>>+/* This driver is not critical to the boot process, don't care
>>+ * if initialized late.
>>+ */
>>+__initcall(leon_pmc_install);
>>    
>>
>
>We do not use __initcall() in new code.
>Use the appropriate initcall from init.h.
>
>A patch to fix up rest of sparc is welcome :-)
>
>
>	Sam
>
>
>  
>

