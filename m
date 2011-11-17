From: David Miller <davem@davemloft.net>
Date: Thu, 17 Nov 2011 21:49:41 +0000
Subject: Re: [BUG] Bad page map in process ibv_devinfo
Message-Id: <20111117.164941.2104520709167256016.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1321110951.99968.YahooMailNeo@web24712.mail.ird.yahoo.com>
	<CAL1RGDXnzQTQuMica3ZsRYbGNhT7GcySQvcAnJ+-5E2P0xw4Ag@mail.gmail.com>
	<1321471354.5493.YahooMailNeo@web24714.mail.ird.yahoo.com>
In-Reply-To: <1321471354.5493.YahooMailNeo-tOYT8urs2cbyX4RqAA4FmIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-GLgANOly0l1BDLzU/O5InQ@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, roland-BHEL68pLQRGGvPXPguhicg@public.gmane.org

From: Lukas Razik <linux@razik.name>
Date: Wed, 16 Nov 2011 19:22:34 +0000 (GMT)

> I'm wondering if the bug is in the mlx4 code or in the sparc
> io_remap_pfn_range()
> code.=A0 From the "Bad page map" pte value, if I understand sparc mm corr=
ectly,
> the PTE is seen as not present.

The not-present test is essentially testing the PTE against zero.

This bug check is making sure that there are not already existing mappings
at that address when the io_remap_pfn_range() call occurs.

x86 uses remap_pfn_range() as the implementation of it's
io_remap_pfn_range() and it also has the same exact assertion
check, in remap_pte_range().

I can't see any obvious bug in the mlx4 mmap method.

The only thing I can come up with is that perhaps there is an assumption
hiding around somewhere that PAGE_SIZE is 4096.  Such an assumption would
go undetected on both 32-bit and 64-bit x86 platforms since PAGE_SIZE is
4096 there.  Whereas on sparc64 it is 8192.
