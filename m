From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 30 Sep 2011 12:43:36 +0000
Subject: Re: [PATCH 2/4] apbuart: add support for virtual KGDB<->GRMON channel
Message-Id: <CAGRGNgUyGoFjk2iKqh35YqzwdHSU6hoKdE+gmGZX1J4CS20EAw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381744-24862-2-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381744-24862-2-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I'm not sure what Dave would say, but the code cleanups, (see below)
whilst minor, should probably live in a separate patch.

Thanks,

Julian Calaby

On Fri, Sep 30, 2011 at 21:22, Konrad Eisele <konrad@gaisler.com> wrote:
> Add support for a virtual GRMON<->KGDB channel that
> is created using share memory polling by GRMON. Start
> GRMON with the option "-vchannel" to enable polling. This
> feature enables connecting to KGDB without having an hardware
> serial connection, but using GRMON as an tunnel.
> Reorder Makefile addition so that apbuart.o gets inserted
> before kgdboc.o.
> Add Kconfig option SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL to enable
> the feature.
>
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
> =A0drivers/tty/serial/Kconfig =A0 | =A0 12 ++++
> =A0drivers/tty/serial/Makefile =A0| =A0 =A02 +-
> =A0drivers/tty/serial/apbuart.c | =A0133 ++++++++++++++++++++++++++++++++=
++++------
> =A03 files changed, 128 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
> index 5f40f42..38eb8cc 100644
> --- a/drivers/tty/serial/apbuart.c
> +++ b/drivers/tty/serial/apbuart.c
> @@ -124,7 +124,6 @@ static void apbuart_rx_chars(struct uart_port *port)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_insert_char(port, rsr, UART_STATUS_OE=
, ch, flag);
>
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0ignore_char:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D UART_GET_STATUS(port);
> =A0 =A0 =A0 =A0}
> @@ -350,11 +349,88 @@ static struct uart_ops grlib_apbuart_ops =3D {
> =A0 =A0 =A0 =A0.config_port =3D apbuart_config_port,
> =A0 =A0 =A0 =A0.verify_port =3D apbuart_verify_port,
> =A0#ifdef CONFIG_CONSOLE_POLL
> - =A0 =A0 =A0 .poll_get_char =A0=3D apbuart_poll_get_char,
> - =A0 =A0 =A0 .poll_put_char =A0=3D apbuart_poll_put_char,
> -#endif
> + =A0 =A0 =A0 .poll_get_char =3D apbuart_poll_get_char,
> + =A0 =A0 =A0 .poll_put_char =3D apbuart_poll_put_char,
> +#endif
> @@ -423,7 +499,6 @@ static void apbuart_flush_fifo(struct uart_port *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UART_GET_CHAR(port);
> =A0}
>
> -
> =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> =A0/* Console driver, if enabled =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> @@ -551,7 +626,6 @@ static struct console grlib_apbuart_console =3D {
> =A0 =A0 =A0 =A0.data =3D &grlib_apbuart_driver,
> =A0};
>
> -
> =A0static int grlib_apbuart_configure(void);
>
> =A0static int __init apbuart_console_init(void)
> @@ -579,7 +653,6 @@ static struct uart_driver grlib_apbuart_driver =3D {
> =A0 =A0 =A0 =A0.cons =3D APBUART_CONSOLE,
> =A0};
>
> -
> =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> =A0/* OF Platform Driver =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> @@ -598,12 +671,12 @@ static int __devinit apbuart_probe(struct platform_=
device *op)
> =A0 =A0 =A0 =A0port->dev =3D &op->dev;
> =A0 =A0 =A0 =A0port->irq =3D op->archdata.irqs[0];
>
> - =A0 =A0 =A0 uart_add_one_port(&grlib_apbuart_driver, (struct uart_port =
*) port);
> + =A0 =A0 =A0 uart_add_one_port(&grlib_apbuart_driver, (struct uart_port =
*)port);
>
> - =A0 =A0 =A0 apbuart_flush_fifo((struct uart_port *) port);
> + =A0 =A0 =A0 apbuart_flush_fifo((struct uart_port *)port);
>
> =A0 =A0 =A0 =A0printk(KERN_INFO "grlib-apbuart at 0x%llx, irq %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long) port->mapbase, port->ir=
q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)port->mapbase, port->irq=
);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -620,13 +693,12 @@ static struct of_device_id __initdata apbuart_match=
[] =3D {
> =A0static struct platform_driver grlib_apbuart_of_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D apbuart_probe,
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "grlib-apbuart",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D apbuart_match,
> - =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "grlib-apbuart",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D apbuart_match,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0};
>
> -
> =A0static int grlib_apbuart_configure(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> @@ -641,7 +713,7 @@ static int grlib_apbuart_configure(void)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ampopts =3D of_get_property(np, "ampopts",=
 NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ampopts && (*ampopts =3D 0))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue; /* Ignore if used=
 by another OS instance */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue; =A0 =A0 =A0 /* Ig=
nore if used by another OS instance */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs =3D of_get_property(np, "reg", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Frequency of APB Bus is frequency of UA=
RT */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0freq_hz =3D of_get_property(np, "freq", NU=
LL);
> @@ -656,14 +728,16 @@ static int grlib_apbuart_configure(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port =3D &grlib_apbuart_ports[line];
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->mapbase =3D addr;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->membase =3D ioremap(addr, sizeof(stru=
ct grlib_apbuart_regs_map));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->membase > + =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->irq =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->iotype =3D UPIO_MEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->ops =3D &grlib_apbuart_ops;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->flags =3D UPF_BOOT_AUTOCONF;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->line =3D line;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->uartclk =3D *freq_hz;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->fifosize =3D apbuart_scan_fifo_size((=
struct uart_port *) port, line);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->fifosize > + =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 apbuart_scan_fifo_size((struct uart_port *)port, line);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0line++;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We support maximum UART_NR uarts ... */

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
