From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 08 Mar 2011 21:09:31 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110308210931.GA27722@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 08, 2011 at 09:22:07PM +0100, Marcel van Nies wrote:
> Hi,
> 
> The good news:
> sparc-next-2.6 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reverted
> does NOT segfault. I did not apply the genirq patch yet.

Narrowing it down to a sinlge patch is good.

> 
> The bad news:
> Segfault gone, say hello to EXT2 read failure   :o(

So we are dealing with two faults. Not a suprise considering how
little we have tested on sparc32 lately.

> I'll rebuild this kernel with the esp_debug.patch Sam sent a couple of days ago.

I have tried said patch myself.
You may try to play around with the value as it produces a lot of output.

Regarding the segfault - the easiest way forward would be to split the
patch up in smaller chunks so we know which part causes the segfault to happen.

I assume you had to hand-apply the revert. If you could post the exact patch
you used for revert I will try to split it up in smaller logical parts.
But likely not until the weekend.

I have a sparcstation 5 that I managed to boot - unfortunately it
did not show erratic behaviour as you describe.
And for now I do not have any Ext2 filesystem on disk to play with.

	Sam
