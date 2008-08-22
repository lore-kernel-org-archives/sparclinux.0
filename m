From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 11:32:39 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808221432230.15748@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> It's a long shot, but does this patch fix the problem?

Unfortunately not.
 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 8990196..51065b7 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -809,6 +809,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  		 * re-enables it.
>  		 */
>  		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);
> +		(void) ohci_readl (ohci, &regs->intrdisable);
>  		usb_hcd_poll_rh_status(hcd);
>  	}

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
