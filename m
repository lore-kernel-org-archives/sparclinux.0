From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2009 16:49:00 +0000
Subject: Re: [PATCH] Support for GRLIB APBUART serial port
Message-Id: <20091104.084900.29737719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257352368-32377-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257352368-32377-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed,  4 Nov 2009 17:32:48 +0100

> This patch adds support for the APBUART serial port from Aeroflex
> Gaisler's IP library GRLIB. It is currently used in all LEON3 designs
> (SPARC V8) but can be used on other platforms as well (which support OF).
>=20
>=20
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>

Applied, but I had to make two fixes:

> +config SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
> +	bool "Console on GRLIB APBUART serial port"
> +	depends on SERIAL_GRLIB_GAISLER_APBUART
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	Support for running a console on the GRLIB APBUART

You must make this depend on "SERIAL_GRLIB_GAISLER_APBUART=3Dy"
not just plain "SERIAL_GRLIB_GAISLER_APBUART".

Because when modular, things like console_initcall() are not
available.

> +	printk(KERN_INFO "grlib-apbuart at 0x%x, irq %d\n",
> +	       port->mapbase, port->irq);

This will warn on some platforms, port->mapbase is of type
resource_size_t and that can be anything.  I fixed it like
so:

apbuart: Fix build warning.

drivers/serial/apbuart.c: In function =E2=80=98apbuart_probe=E2=80=99:
drivers/serial/apbuart.c:574: warning: format =E2=80=98%x=E2=80=99 expects =
type =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98resou=
rce_size_t=E2=80=99

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/apbuart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/apbuart.c b/drivers/serial/apbuart.c
index 8a34304..c7883a3 100644
--- a/drivers/serial/apbuart.c
+++ b/drivers/serial/apbuart.c
@@ -570,8 +570,8 @@ static int __devinit apbuart_probe(struct of_device *op,
=20
 	apbuart_flush_fifo((struct uart_port *) port);
=20
-	printk(KERN_INFO "grlib-apbuart at 0x%x, irq %d\n",
-	       port->mapbase, port->irq);
+	printk(KERN_INFO "grlib-apbuart at 0x%llx, irq %d\n",
+	       (unsigned long long) port->mapbase, port->irq);
 	return 0;
=20
 }
--=20
1.6.5.2

=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
