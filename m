From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
Date: Sat, 24 Nov 2007 11:14:25 +0000
Subject: Re: NETDEV WATCHDOG (3Com 3c905 adapter)
Message-Id: <20071124111425.GA29778@newton.mathematik.tu-chemnitz.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4746C44B.8040008@systella.fr> <4746F747.4010906@systella.fr>
In-Reply-To: <4746F747.4010906@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: BERTRAND =?iso-8859-1?Q?Jo=EBl?= <joel.bertrand@systella.fr>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 23, 2007 at 04:52:39PM +0100, BERTRAND Jo=EBl wrote:
> BERTRAND Jo=EBl wrote:
> >    Hello,
> >
> >    Since I have installed a 2.6.23.1 linux kernel on my U60, I can see =

> >several NETDEV WATCHDOG. This trouble never occurs with 2.6.23-rc4.
> >This bug occurs after a random uptime.
>=20
> 	I have made the same constation this evening on a amd64/up with two=20
> 3C905 and a 2.6.21.3 linux kernel... This evening, I have rebooted my=20
> U60 with a 2.6.23.8 kernel and the same 3C905 runs fine. Wait and see=20
> (but I suspect a kernel bug...).
>=20
> 	For main linux kernel list:
>=20
> >End of dmesg :
> >
> >NETDEV WATCHDOG: eth2: transmit timed out
> >eth2: transmit timed out, tx_status 00 status 8601.
> >  diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
> >eth2: Interrupt posted but not delivered -- IRQ blocked by another devic=
e?

This looks like a problem that several network drivers had recently.
The problem was genirq related and should be fixed in 2.6.23,
so I'm surprised that this happens with 2.6.23.1 but not with 2.6.23-rc4.

Steffen
