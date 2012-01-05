From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Jan 2012 06:13:40 +0000
Subject: Re: [PATCH][resending] SPARC32: forced setting of mode of SUN4M
Message-Id: <20120105061340.GA9111@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <772801325730475@web77.yandex.ru>
In-Reply-To: <772801325730475@web77.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Kirill.

Glad to see that you are looking into timer stuff on sparc32!

On Thu, Jan 05, 2012 at 06:27:54AM +0400, Kirill Tkhai wrote:
> SPARC32: forced setting of mode of SUN4M per-cpu timers
The subject only belongsi n the subject: line of the mail - do
not repeat it in the mail body.

Patches that touch both sparc32 and sparc64 shall be prefixed:
sparc: bla bla

Patches that touches only sparc32 shall be prefixed:
sparc32: bla bla

So if you use lower-case sparc32 I am happy.


> SUN4M per-cpu timers have two modes of work. These are timer mode and cou=
nter mode.
> SPARC32 doesn't write anything to the register, which is connected with m=
ode choice.
> So, the mode is chosen by bootloader. This patch forces to use timer mode=
 from the
> kernel and to be independent of bootloader.
>=20
> I had this problem with OpenBIOS. Timers didn't use to tick and kernel on=
 QEMU used
> to fail, when it's compiled with SMP support. The patch fixes problem.

Good description!

>=20
> Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
> ---
>=20
> diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
> index 422c16d..aa0b9df 100644
> --- a/arch/sparc/kernel/sun4m_irq.c
> +++ b/arch/sparc/kernel/sun4m_irq.c
> @@ -414,6 +414,10 @@ static void __init sun4m_init_timers(irq_handler_t c=
ounter_fn)
> =20
>  	for (i =3D 0; i < num_cpu_timers; i++)
>  		sbus_writel(0, &timers_percpu[i]->l14_limit);
> +#ifdef CONFIG_SMP
> +	/* Timer-mode for every per-cpu timer (bit '0' is timer mode) */
> +	sbus_writel(0x00000000, &timers_global->timer_config);
> +#endif

Does this have to be SMP only - I think not.

It would also be nicer to move this up a few lines so it is
right before:

	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);

Then we have the config in one place.

I looked in the sun4m manual which says:

"
The value of the User Timer and Count and Limit registers is unspecified af=
ter the
corresponding configuration bit has been changed.
It is required for software to initialize the counter after a mode
change by writing to it in order to set the register value and to
clear the limit bit. When the counter is programmed to be
a User Timer the Counter/Timer function is disabled,
and vice=E2=80=93versa; these functions share one counter, so no state is
preserved across mode changes.
"

So we should actually set the config bit before we set the limit.

Your comment says:
> +	/* Timer-mode for every per-cpu timer (bit '0' is timer mode) */

But the sun4m manual specify that the first four bits correspond to each
of the per-cpu timers. So we actually need to set all four lower bits to 0.
Which you do - but the comment is wrong.

	Sam

