From: Joerg Roedel <joerg.roedel@amd.com>
Date: Tue, 21 Jul 2009 16:05:38 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090721160538.GL25756@amd.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A5BD7B5.1010904@earthlink.net>
 <20090714103941B.fujita.tomonori@lab.ntt.co.jp>
 <20090714092354.GL19087@amd.com>
 <20090714.131224.205307048.davem@davemloft.net>
In-Reply-To: <20090714.131224.205307048.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

On Tue, Jul 14, 2009 at 01:12:24PM -0700, David Miller wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> Date: Tue, 14 Jul 2009 11:23:55 +0200
>=20
> > On Tue, Jul 14, 2009 at 10:40:16AM +0900, FUJITA Tomonori wrote:
> >> On Mon, 13 Jul 2009 20:56:21 -0400
> >> Robert Reif <reif@earthlink.net> wrote:
> >>=20
> >> > The bad address is within the kernel so it looks like
> >> > it's catching a real bug.
> >> >=20
> >> > cat kallsyms | grep f0007000
> >> > f0007000 T trapbase_cpu3
> >> >=20
> >> > WARNING: at lib/dma-debug.c:873 check_for_illegal_area+0xc8/0x100()
> >> > esp ffd7ba30: DMA-API: device driver maps memory from kernel text or=
=20
> >> > rodata [addr=F0007000] [len@96]
> >> > Modules linked in: ext3 jbd sd_mod sun_esp esp_scsi scsi_transport_s=
pi=20
> >>=20
> >> Ok, I looked at check_for_illegal_area() in dma-debug.
> >>=20
> >> What check_for_illegal_area() does looks bogus to me with some of I/O
> >> remapping hardware.
> >=20
> > Can you be more specific about this one? check_for_illegal_area() should
> > not depend on any hardware because all it does is checking the machine
> > addresses to be mapped.
>=20
> The check can't work properly on sparc32.
>=20
> Sparc32 always maps the kernel to a fixed physical location, and it
> therefore can execute in the identity mapping area of physical memory
> like where all the free pages and kmalloc areas live virtually.
>=20
> So if we free up some pages within the kernel image (because the
> memory is unused, for exmple that's what's happening here with the
> extra trap table pages on Robert's machine) we have pages in the free
> page pool that are located right inside of the kernel text, data, etc.
>=20
> We'll thus need a way to turn off these checks somehow.  You could
> also augment this check by seeing if there is a backing page, and if
> so, whether it is PageReserved or not.  That's just one idea.

Hmm these checks sound specific and hard to maintain. I think its best
to give architectures the option whether to enable this check or not.

	Joerg


