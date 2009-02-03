From: adi@drcomp.erfurt.thur.de (Adrian Knoth)
Date: Tue, 03 Feb 2009 12:05:13 +0000
Subject: Re: Two V880, one working with a 2.6.28 kernel image, one hanging
Message-Id: <20090203120513.GM2348@ltw.loris.tv>
List-Id: <sparclinux.vger.kernel.org>
References: <20090203104353.GA5223@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20090203104353.GA5223@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Feb 03, 2009 at 11:43:53AM +0100, Hermann Lauer wrote:

> Hello Adrian,

Hi!

> Do you have your OBP firmware around? Please don't search,

Unfortunately not, we inherited the machine without anything. (and I
don't know enough about it if it's possible to extract it from a special
character device or something like that)


> if not, I'll look myself for it. And a "lspci -v" would be interesting
> for me, too.


0000:00:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev=
 04)
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 0300 [size%6]
	Memory at 00100000 (32-bit, non-prefetchable) [size=3D8K]
	Memory at 00102000 (32-bit, non-prefetchable) [size=3D8K]
	[virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Expansion ROM at fffff80200000000 [disabled] [size=3D1]
	Kernel driver in use: sym53c8xx

0001:00:01.0 Ethernet controller: Sun Microsystems Computer Corp. GEM 10/10=
0/1000 Ethernet [ge] (rev 01)
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 7
	Memory at 00200000 (32-bit, non-prefetchable) [size=3D2M]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	Expansion ROM at 00100000 [disabled] [size=3D1M]
	Kernel driver in use: gem
	Kernel modules: sungem

0001:00:02.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Cha=
nnel Adapter (rev 05)
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 8
	I/O ports at 0300 [size%6]
	Memory at 00400000 (32-bit, non-prefetchable) [size=3D8K]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=3D1]
	Expansion ROM at 00420000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
	Kernel driver in use: qla2xxx
	Kernel modules: qla2xxx

0002:00:01.0 Bridge: Sun Microsystems Computer Corp. RIO EBUS (rev 01)
	Flags: bus master, medium devsel, latency 64
	BIST result: 00
	Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	Expansion ROM at fffff80400000000 [disabled] [size=3D1]

0002:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. RIO 10/10=
0 Ethernet [eri] (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 19
	BIST result: 00
	Memory at 00100000 (32-bit, non-prefetchable) [size=128K]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	Expansion ROM at 00400000 [disabled] [size=3D4M]
	Kernel driver in use: gem
	Kernel modules: sungem

0002:00:01.3 USB Controller: Sun Microsystems Computer Corp. RIO USB (rev 0=
1) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 20
	BIST result: 00
	Memory at 01000000 (32-bit, non-prefetchable) [size=16M]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	[virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=3D1]
	Expansion ROM at 00c00000 [disabled] [size=3D4M]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd


Does the Gentoo 2008 live CD boots on your machine?


Cheerio

--=20
Friedrich-Schiller-Universit=E4t Jena               Tel: +49 3641 9 463 76
Institut f=FCr Informatik                           Ernst-Abbe-Platz 2
