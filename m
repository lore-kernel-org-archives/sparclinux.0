From: David Miller <davem@davemloft.net>
Date: Fri, 28 Mar 2008 23:10:11 +0000
Subject: Re: 2.6.25-rc5-mm1 sparc64 boot problems due to generic
Message-Id: <20080328.161011.08762096.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<200803282352.10780.m.kozlowski@tuxland.pl>
In-Reply-To: <200803282352.10780.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.kozlowski@tuxland.pl
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, greg@kroah.com, sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Fri, 28 Mar 2008 23:52:10 +0100

> 	The gregkh-pci-pci-sparc64-use-generic-pci_enable_resources.patch which
> replaces arch-specific code with generic pci_enable_resources() makes my sparc64
> box unable to boot (that's what quilt bisection says). At first I see these messages:

Yes, that generic code won't work because of the NULL
r->parent check.

Alpha, ARM, V32, FRV, IA64, MIPS, MN10300, PARISC, PPC,
SH, V850, X86, and Xtensa are all likely to run into
problems because of this change.

The only platform that did the check as a test of r->parent
being NULL is Powerpc.

The rest either didn't check (like sparc64), or tested it by going:

	if (!r->start && r->end)

So the amount of potential breakage from this change is enormous.
