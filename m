From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 04 Jan 2004 22:26:23 +0000
Subject: Re: [PATCH] [SPARC] Use drivers/block/Kconfig
Message-Id: <20040104222623.GC5492@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 03, 2004 at 09:23:08PM +0000, Matthew Wilcox wrote:

> Sparc32 is currently missing a way to select CRYPTOLOOP due to not using
> drivers/blok/Kconfig.  Since there doesn't seem to be any reason not to,
> this patch switches sparc to use the generic Kconfig file.

Thanks Matthew.  Your patch looks good.  As Pete mentioned, please
deliver patches to work with -p1.

This patch goes in a direction I'd like to see us take in general.
See my earlier patch to use virtually all the generic Kconfigs.
Perhaps you'd like to work on getting that in a condition to be
acceptable into the main kernel?  You'd need to work with people to
make sure all the drivers have correct bus and/or arch dependencies
(so that for example we don't offer ISA devices on sparc32).

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
