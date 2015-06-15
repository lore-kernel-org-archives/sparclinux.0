From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 15 Jun 2015 18:27:57 +0000
Subject: Re: netboot failure with current kernels?
Message-Id: <20150615182757.GA1347@aspire-one.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1506021937230.9956@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1506021937230.9956@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Wed, Jun 10, 2015 at 12:29:43AM +0300, Aaro Koskinen wrote:
> On Tue, Jun 02, 2015 at 07:50:19PM +0300, Meelis Roos wrote:
> > I tried to install Debian on my E280R. Netboot is the most natural way =

> > for remote install so I tried that. Current Debian installer fails to=20
> > load:
> >=20
> > {0} ok boot net
> > Boot device: /pci@8,700000/network@5,1:  File and args:=20
> > Timeout waiting for ARP/RARP packet
> > 4000 \
> >      ERROR: /packages/obp-tftp: Last Trap: Fast Data Access MMU Miss
> >=20
> >=20
> > Boot load failed
> >=20
> > Is this some known problem with TFTP booting that Debian needs to fix, =

> > or something new? Size of the boot.img file is 12988928 bytes, OBP=20
> > version 4.16.4 2004/12/18.
>=20
> Probably the image is too big. At least on older sparcs the limit
> is 10 MB.

Based on quick look, Debian netboot image has 8 MB
uncompressed kernel=A0and 4.5 MB compressed initramfs.
By using compressed kernel it would all fit under 10 MB.
Such image could be created using the latest TILO version from:
https://git.kernel.org/cgit/linux/kernel/git/davem/silo.git

A.
