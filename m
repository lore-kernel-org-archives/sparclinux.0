From: Matthew Wilcox <willy@debian.org>
Date: Sun, 04 Jan 2004 23:07:34 +0000
Subject: Re: [PATCH] [SPARC] Use drivers/block/Kconfig
Message-Id: <20040104230734.GX6982@parcelfarce.linux.theplanet.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 04, 2004 at 02:26:23PM -0800, Keith M Wesolowski wrote:
> Thanks Matthew.  Your patch looks good.  As Pete mentioned, please
> deliver patches to work with -p1.

Yeah; I work out of CVS so sometimes I forget to fix them.  Did you want
it resent or will you make that minor adjustment yourself?

> This patch goes in a direction I'd like to see us take in general.
> See my earlier patch to use virtually all the generic Kconfigs.
> Perhaps you'd like to work on getting that in a condition to be
> acceptable into the main kernel?  You'd need to work with people to
> make sure all the drivers have correct bus and/or arch dependencies
> (so that for example we don't offer ISA devices on sparc32).

I missed your earlier patch, unfortunately; could you send a copy
to me?  I think we're in pretty good shape as far as using generic
Kconfigs go; I created drivers/Kconfig and I'm having a lot of luck
converting architectures to use that.  My next project is making sure
that drivers/char/Kconfig is suitable for every architecture as I think
that's the biggest remaining thing to do.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
