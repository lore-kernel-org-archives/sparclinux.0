From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 21:24:12 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20100314.142412.52181590.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100313.181754.107699673.davem@davemloft.net>
	<10f740e81003140734p30959952ld4563d2b22d834af@mail.gmail.com>
In-Reply-To: <10f740e81003140734p30959952ld4563d2b22d834af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 14 Mar 2010 15:34:03 +0100

> On Sun, Mar 14, 2010 at 03:17, David Miller <davem@davemloft.net> wrote:
>> David S. Miller (1):
>> =A0 =A0 =A0sparc64: Add very basic XVR-1000 framebuffer driver.
>=20
> Have you ever looked into getting offb to work on sparc64?

Can't for several of these drivers.

For example, the svr500 comes up in some kind of striped plane mode so
we have to write every pixel to two planes of the frame buffer.

Also offb doesn't know the implied endianness of the framebuffer.  UPA
based framebuffers are typically big endian, whereas most (but not
all) PCI are little-endian.

I also intend to get these thing supporting accelerated at some
pointer.

offb looks like a big hack instead of something generic that
could support any framebuffer that adheres to the standard
openfirmware framebuffer device properties.  It's just using
a bunch of properties created internally by bootx.
