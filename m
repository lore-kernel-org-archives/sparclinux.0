From: Mark Salter <msalter@redhat.com>
Date: Fri, 05 Jun 2015 14:16:40 +0000
Subject: Re: [RFT v2 43/48] genirq, arch: Kill the first parameter 'irq' of irq_flow_handler_t
Message-Id: <1433513800.24429.56.camel@deneb.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	 <1433391238-19471-44-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-44-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Aurelien Jacquiot <a-jacquiot@ti.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Andreas Larsson <andreas@gaisler.com>, Joe Perches <joe@perches.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, 2015-06-04 at 12:13 +0800, Jiang Liu wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> ---
>  arch/alpha/kernel/irq.c             |    2 +-
>  arch/avr32/mach-at32ap/extint.c     |    2 +-
>  arch/avr32/mach-at32ap/pio.c        |    2 +-
>  arch/c6x/platforms/megamod-pic.c    |    2 +-
>  arch/sparc/kernel/leon_kernel.c     |    2 +-
>  arch/sparc/kernel/leon_pci_grpci1.c |    2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c |    2 +-
>  arch/tile/kernel/pci_gx.c           |    4 ++--
>  arch/unicore32/kernel/irq.c         |    2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)

For c6x:

Acked-by: Mark Salter <msalter@redhat.com>


