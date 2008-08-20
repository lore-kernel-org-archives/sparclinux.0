From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 20 Aug 2008 14:11:45 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0808200951240.2463-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 20 Aug 2008, Meelis Roos wrote:

> Tried 2.6.27-rc3 + yesterdays git that works on my Ultra5, still hangs 
> in USB startup on V100.
> 
> Then I tried the suggestion to instrument ohci_hub_status_data() with 
> printks around spin_lock_irqsave() and return. Tried this with git HEAD 
> and this time ohci_hub_status_data seemed to be not reached at all, so 
> it hangs in USB code in slightly different place than in the original 
> trace.
> 
> By the way, David - Sysrq-T and Sysrq-P do not seem to work in latest 
> git form me for some reason, from serial console. So no new trace.
> 
> Will check the kernel debugging options with working U5 config to look 
> for any suspicios diffences there.
> 
> What should I do next - probably go back to the original revision and 
> instrument ohci_hub_status_data() there?

You should stick with a single well-defined kernel version, like 
2.6.27-rc3.  Start by seeing what happens with ohci_hub_status_data and 
move on from there.

You might also want to instrument usb_hcd_poll_rh_status() in
drivers/usb/core/hcd.c; that routine should call ohci_hub_status_data()
and it should be called by usb_add_hcd().

Alan Stern

