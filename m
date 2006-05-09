From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 09 May 2006 22:00:00 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060509.150000.102037355.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 9 May 2006 22:27:22 +0100

> Sadly, no. I can try to do some of the easier things, but fixing
> something like the esp driver without the esp&dma datasheets is
> beyond me I'm afraid :).

http://en.wikipedia.org/wiki/NCR_53C9x

The DMA programming manual is really not that necessary to
understand the chip.

> Yes, these actually fail to load. Maybe it's a memory corruption in module.c
> somehow: if I make too many debugging changes in apply_relocate_add() the
> problem disappears.
> I'm trying different things now to make it show me the failing section and
> symbol when it fails. I'll post again once I have more details.

Are you using Debian's gcc-4.1 compiler to build kernels?

That has already had problems reported with it wrt. miscompiling
the simplest kernel code such as the SUN disk label checksum
calculation in fs/partitions/sun.c and the similar code in
util-linux's fdisk.
