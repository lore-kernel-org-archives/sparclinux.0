From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 21:17:05 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110.131705.137844598.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 20:32:51 +0100

> If I comment out the call to resume_pll() then I no longer see garbled output.

Yeah, that just makes it simply not program the PLL at all.

I just booted Linus's current tree on my Samsung 216BW and it works
just fine.  I'll try a few other monitors I have.

If you have the time can you try these two tests?

1) In atyfb_setup_sparc(), comment out the whole block of code protected
   by:

	if (IS_XL(pdev->device)) {
		/*
		 * Fix PROMs idea of MEM_CNTL settings...
		 */

2) Force the:

	dp = pci_device_to_OF_node(pdev);
	if (dp = of_console_device) {

   test to fail.

I've always been suspect of all of the special mode and MEM_CNTRL handling
we have here for Sparc.  If disabling it fixes stuff, I'd happily see this
code get tossed out completely.

Thanks!
