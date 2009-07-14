From: Joerg Roedel <joerg.roedel@amd.com>
Date: Tue, 14 Jul 2009 09:23:55 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090714092354.GL19087@amd.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1247466360-13330-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <4A5BD7B5.1010904@earthlink.net>
 <20090714103941B.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090714103941B.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: reif@earthlink.net, mingo@elte.hu, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

On Tue, Jul 14, 2009 at 10:40:16AM +0900, FUJITA Tomonori wrote:
> On Mon, 13 Jul 2009 20:56:21 -0400
> Robert Reif <reif@earthlink.net> wrote:
>=20
> > FUJITA Tomonori wrote:
> > > This is the second version of the patchset to convert SPARC to
> > > asm-generic/dma-mapping-common.h and pci-dma-compat.h:
> > >
> > >  =20
> > I still get the same runtime warning with this patch set at boot time.
> >=20
> > The bad address is within the kernel so it looks like
> > it's catching a real bug.
> >=20
> > cat kallsyms | grep f0007000
> > f0007000 T trapbase_cpu3
> >=20
> > WARNING: at lib/dma-debug.c:873 check_for_illegal_area+0xc8/0x100()
> > esp ffd7ba30: DMA-API: device driver maps memory from kernel text or=20
> > rodata [addr=F0007000] [len@96]
> > Modules linked in: ext3 jbd sd_mod sun_esp esp_scsi scsi_transport_spi =

>=20
> Ok, I looked at check_for_illegal_area() in dma-debug.
>=20
> What check_for_illegal_area() does looks bogus to me with some of I/O
> remapping hardware.

Can you be more specific about this one? check_for_illegal_area() should
not depend on any hardware because all it does is checking the machine
addresses to be mapped.

	Joerg

