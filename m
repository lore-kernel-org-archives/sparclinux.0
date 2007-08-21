From: David Miller <davem@davemloft.net>
Date: Tue, 21 Aug 2007 06:47:23 +0000
Subject: Re: Problems starting up ...
Message-Id: <20070820.234723.112620912.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200708202317.48014.Stefan.Sablatnoeg@gmx.de>
In-Reply-To: <200708202317.48014.Stefan.Sablatnoeg@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Tue, 21 Aug 2007 09:39:08 +1000

> On 8/21/07, Stefan Sablatn=F6g <Stefan.Sablatnoeg@gmx.de> wrote:
> > My questions are:
> > - Is there any further trick in using the serial console than to config=
ure
> >   CONFIG_SERIAL_SUNZILOG=3Dy and
> >   CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy ?
> >   what about CONFIG_SERIAL_CORE vs. CONFIG_SERIAL_SUNCORE have them both
> >   or only the sun part?
>=20
> If the serial console is like the serial console on i386, you have to
> set it up (pass a commandline argument to the kernel) before it will
> work.
>=20
> Also, do you have another console type enabled? e.g. the PROM console
> or a framebuffer console? - that may fix your problems.

This is not how it works on sparc, the "output-device" firmware
variable will be inspected, and if it is set to a serial device
it will be used as the console.
