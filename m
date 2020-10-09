From: Wolf Ruediger Spielmann <RSpielmann@gmx.de>
Date: Fri, 09 Oct 2020 20:46:29 +0000
Subject: Re: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <20201009224629.c4eb482d0d8f51e5e8097d4b@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201009161924.c8f031c079dd852941307870@gmx.de>
In-Reply-To: <20201009161924.c8f031c079dd852941307870@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Adrian,

On Fri, 9 Oct 2020 16:49:32 +0200
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> > It's (in my opinion) pcpu-alloc:
> > kernel 4.x/5.x: pcpu-alloc: [0] 0 1=20
> > kernel 3.x: pcpu-alloc: [0] 0 2=20
>=20
> Interesting. I have not yet seen this issue on any of our Debian developm=
ent
> machines. What distribution are you running? Is this Gentoo?
>=20
> Our of curiosity, could you give it a go with Debian?
>=20
> > https://cdimage.debian.org/cdimage/ports/2020-08-19/debian-10.0.0-sparc=
64-NETINST-1.iso

OK - tested this ISO-image:
- boots to bootloader GRUB
- I chose two options ("expert install" and "rescue shell")
- SUN loads and boots kernel, but I never reach installer nor rescue shell
Boot-process stalls middle in nowhere and shows me a blinking cursor foreve=
r.

R=FCdiger
