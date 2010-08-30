From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Date: Mon, 30 Aug 2010 15:58:52 +0000
Subject: RE: [PATCH 8/9] x86: of: irq additions to make drivers/of/* build on x86
Message-Id: <c7823e09-3ce8-434f-98f4-6a84a996c942@SG2EHSMHS001.ehs.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian><20100829235100.6dcedcb8@debxo>
	<20100830000614.0d571f10@debxo>
In-Reply-To: <20100830000614.0d571f10@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org



> -----Original Message-----
> From: Andres Salomon [mailto:dilinger@queued.net]
> Sent: Sunday, August 29, 2010 9:06 PM
> To: devicetree-discuss@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org; x86@kernel.org; tglx@linutronix.de;
mingo@redhat.com; hpa@zytor.com;
> cjb@laptop.org; Mitch Bradley; pgf@laptop.org;
linux-kernel@vger.kernel.org; davem@davemloft.net;
> grant.likely@secretlab.ca; Stephen Neuendorffer
> Subject: [PATCH 8/9] x86: of: irq additions to make drivers/of/* build
on x86
> 
> 
> This functionality overlaps with patches previously submitted
> by Stephen Neuendorffer.  I don't care whose eventually get applied,
> so long as drivers/of/* becomes buildable on x86.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Agreed..
Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

> ---
>  arch/x86/include/asm/irq.h |    5 +++++
>  arch/x86/kernel/irq.c      |    8 ++++++++
>  include/linux/of_irq.h     |    1 +
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
> index 5458380..0a656b9 100644
> --- a/arch/x86/include/asm/irq.h
> +++ b/arch/x86/include/asm/irq.h
> @@ -10,6 +10,11 @@
>  #include <asm/apicdef.h>
>  #include <asm/irq_vectors.h>
> 
> +#define NO_IRQ 0
> +
> +/* Even though we don't support this, supply it to appease OF */
> +static inline void irq_dispose_mapping(unsigned int virq) { }
> +
>  static inline int irq_canonicalize(int irq)
>  {
>  	return ((irq = 2) ? 9 : irq);
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 91fd0c7..d53f639 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -7,6 +7,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/smp.h>
>  #include <linux/ftrace.h>
> +#include <linux/of.h>
> 
>  #include <asm/apic.h>
>  #include <asm/io_apic.h>
> @@ -275,6 +276,13 @@ void smp_x86_platform_ipi(struct pt_regs *regs)
> 
>  EXPORT_SYMBOL_GPL(vector_used_by_percpu_irq);
> 
> +unsigned int irq_create_of_mapping(struct device_node *controller,
> +		const u32 *intspec, unsigned int intsize)
> +{
> +	return intspec[0] + 1;
> +}
> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  /* A cpu has been removed from cpu_online_mask.  Reset irq
affinities. */
>  void fixup_irqs(void)
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 5929781..05ad27b 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -5,6 +5,7 @@
>  struct of_irq;
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/irq.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> 
> --
> 1.5.6.5
> 


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


