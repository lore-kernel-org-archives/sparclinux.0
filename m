From: =?ISO-8859-15?Q?S=E9bastien_Bernard?= <seb@sfrdev.fr>
Date: Mon, 07 Sep 2009 16:53:15 +0000
Subject: Re: Sparc release requalification
Message-Id: <4AA53A7B.2010801@sfrdev.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> [great explanation snipped]
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -103,7 +103,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt=
_regs *regs)
>  	}
>  	if (!touched && __get_cpu_var(last_irq_sum) =3D sum) {
>  		local_inc(&__get_cpu_var(alert_counter));
> -		if (local_read(&__get_cpu_var(alert_counter)) =3D 5 * nmi_hz)
> +		if (local_read(&__get_cpu_var(alert_counter)) =3D 30 * nmi_hz)
>  			die_nmi("BUG: NMI Watchdog detected LOCKUP",
>  				regs, panic_on_timeout);
>  	} else {
>  =20

Hum, I tested today, and no, it does not solve the problem. Kernel is=20
still hanging at the same place.
I'll get the initcall debug back when I'll have rebuild a kernel withtou=20
the config_prom_console.


    Seb
