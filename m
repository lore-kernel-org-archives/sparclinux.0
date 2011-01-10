From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 22:03:46 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110220346.GA20779@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 10, 2011 at 01:17:05PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 10 Jan 2011 20:32:51 +0100
> 
> > If I comment out the call to resume_pll() then I no longer see garbled output.
> 
> Yeah, that just makes it simply not program the PLL at all.
> 
> I just booted Linus's current tree on my Samsung 216BW and it works
> just fine.  I'll try a few other monitors I have.
> 
> If you have the time can you try these two tests?
> 
> 1) In atyfb_setup_sparc(), comment out the whole block of code protected
>    by:
> 
> 	if (IS_XL(pdev->device)) {
> 		/*
> 		 * Fix PROMs idea of MEM_CNTL settings...
> 		 */
> 
> 2) Force the:
> 
> 	dp = pci_device_to_OF_node(pdev);
> 	if (dp = of_console_device) {
> 
>    test to fail.
> 
> I've always been suspect of all of the special mode and MEM_CNTRL handling
> we have here for Sparc.  If disabling it fixes stuff, I'd happily see this
> code get tossed out completely.

I have tried 1) and 2)
Independent and together.

The result was the same in all cases.

I have also tried with a LG Flatron W2425T Monotor - the same result.

On this box I have never had any graphical application running - so
we should also consider that this is a HW bug on my video card.
I found another SB100 on ebay wich I have placed a bid on - maybe I
am lucky to get it.

	Sam
