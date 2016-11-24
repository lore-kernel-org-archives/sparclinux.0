From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 24 Nov 2016 13:33:31 +0000
Subject: Re: [bug report] SPARC/LEON: added support for selecting Timer Core and Timer within core
Message-Id: <88059740-864d-0a1c-9a1d-6e30ff430de3@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160713133816.GA8019@mwanda>
In-Reply-To: <20160713133816.GA8019@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello Dan,

Thanks for your email. By reading the code I think "break" was not the=20
intension, rather to restart from "do {" the timer instance "ampopts"=20
property is 0. The purpose was to scan for the next GPTIMER instance,=20
therefore nnp is set to np.

Best Regards,

Daniel Hellstrom
Software Section Head
Cobham Gaisler
T : +46 (0) 31 775 8657
F : +46 (0) 31 421407
daniel.hellstrom@gaisler.com

Cobham Gaisler AB, Kungsgatan 12, SE-411 19, G=D6TEBORG, Sweden.
+46 (0) 31 775 8650, www.cobham.com/gaisler

Please consider the environment before printing this email

This e-mail and any files transmitted with it ("E-mail") is intended solely=
 for the addressee(s) and may contain confidential and/or legally privilege=
d information. If you are not the addressee(s), any disclosure,
reproduction, copying, distribution or other use of the E-mail is prohibite=
d. If you have received this E-mail in error, please delete it and notify t=
he sender immediately via our switchboard or return e-mail.

Neither the company nor any subsidiary or affiliate or associated company n=
or any individual sending this Email accepts any liability in respect of th=
e content (including errors and omissions) nor shall this e-mail be deemed =
to enter the company or any subsidiary or affiliate or associated company i=
nto a contract or to create any legally binding obligations unless expressl=
y agreed to in writing under separate cover and timeliness of the E-mail wh=
ich arise as a result of transmission. If verification is required, please =
request a hard copy version from the sender.

On 2016-11-24 13:19, Dan Carpenter wrote:
> Hello Daniel Hellstrom,
>
> The patch 2791c1a43900: "SPARC/LEON: added support for selecting
> Timer Core and Timer within core" from Jan 4, 2011, leads to the
> following static checker warning:
>
> 	arch/sparc/kernel/leon_kernel.c:368 leon_init_timers()
> 	warn: continue to end of do { ... } while(0); loop
>
> arch/sparc/kernel/leon_kernel.c
>     350          /* Find GPTIMER Timer Registers base address otherwise b=
ail out. */
>     351          nnp =3D rootnp;
>     352          do {
>     353                  np =3D of_find_node_by_name(nnp, "GAISLER_GPTIME=
R");
>     354                  if (!np) {
>     355                          np =3D of_find_node_by_name(nnp, "01_011=
");
>     356                          if (!np)
>     357                                  goto bad;
>     358                  }
>     359
>     360                  ampopts =3D 0;
>     361                  pp =3D of_find_property(np, "ampopts", &len);
>     362                  if (pp) {
>     363                          ampopts =3D *(int *)pp->value;
>     364                          if (ampopts =3D 0) {
>     365                                  /* Skip this instance, resource =
already
>     366                                   * allocated by other OS */
>     367                                  nnp =3D np;
>     368                                  continue;
>
> "continue" and "break" mean the same thing here.  Please use break, if
> that's what was intended.
>
>     369                          }
>     370                  }
>     371
>     372                  /* Select Timer-Instance on Timer Core. Default =
is zero */
>     373                  leon3_gptimer_idx =3D ampopts & 0x7;
>     374
>     375                  pp =3D of_find_property(np, "reg", &len);
>     376                  if (pp)
>     377                          leon3_gptimer_regs =3D *(struct leon3_gp=
timer_regs_map **)
>     378                                                  pp->value;
>     379                  pp =3D of_find_property(np, "interrupts", &len);
>     380                  if (pp)
>     381                          leon3_gptimer_irq =3D *(unsigned int *)p=
p->value;
>     382          } while (0);
>
> regards,
> dan carpenter

