From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Wed, 20 May 2015 10:16:46 +0000
Subject: Re: [RFC v1 20/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Message-Id: <20150520101646.GB12898@samfundet.no>
List-Id: <sparclinux.vger.kernel.org>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-21-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-21-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andreas Larsson <andreas@gaisler.com>, Joe Perches <joe@perches.com>, Christoph Lameter <cl@linux.com>

Around Wed 20 May 2015 18:00:08 +0800 or thereabout, Jiang Liu wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/alpha/kernel/irq.c             |    2 +-
>  arch/avr32/mach-at32ap/extint.c     |    2 +-
>  arch/avr32/mach-at32ap/pio.c        |    2 +-

For the AVR32 related bits

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

>  arch/blackfin/kernel/ipipe.c        |    4 ++--
>  arch/c6x/platforms/megamod-pic.c    |    3 ++-
>  arch/sparc/kernel/leon_kernel.c     |    2 +-
>  arch/sparc/kernel/leon_pci_grpci1.c |    2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c |    2 +-
>  arch/tile/kernel/pci_gx.c           |    4 ++--
>  arch/unicore32/kernel/irq.c         |    3 ++-
>  arch/x86/kernel/irq_64.c            |    2 +-
>  arch/x86/lguest/boot.c              |    2 +-
>  12 files changed, 16 insertions(+), 14 deletions(-)

<snipp diff>

-- 
HcE
