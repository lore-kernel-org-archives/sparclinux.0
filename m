From: Kjetil Oftedal <oftedal@gmail.com>
Date: Tue, 24 May 2011 17:43:21 +0000
Subject: Re: Sun4d boot crash in sun4d_init_timers
Message-Id: <Pine.LNX.4.64.1105241854260.7984@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, 24 May 2011, Josip Rodin wrote:

> On Tue, May 24, 2011 at 01:05:14AM +0200, Josip Rodin wrote:
> > +	board =3D of_getintprop_default(dp, "board#", 0);
> > +	if (!board) {
>=20
> > Passing around the 'board' property of 'cpu-unit' looks like it should =
be done
> > because the same thing is used to seed board_to_cpu[].
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/davem/prtconfs.git;a=3Dblob=
;f=3Dss1000;h=F420dc005d6939b837134d146741316c024d5932;hb=3DHEAD
> > says both cpu-units have the same, zeroth board, but it might not hurt
> > to check just in case some other machine happens to use a different ind=
ex.
>=20
> In fact it looks like 0 is a common valid value in the analogous pieces of
> code that don't even verify the result of that lookup. The above code sho=
uld
> either not check that lookup either (the simple solution), or set the
> default to -1 so that it can actually discern error state.
>=20

Hi,

Thanks for your suggestions. I tested this earlier and you are correct, it =

has to be -1 to work at all, as the boards are 0-indexed. It does however n=
ot=20
work completly as intended. The same goes for Daniel suggestion about using=
=20
the virtual IRQ for the irq registration.=20

With these changes request_irq completes without errors, and the system=20
continues to boot. But stalls again during "Calibrating delay loop...".=20
Closer inspection reveals that this is caused by the system jiffies not=20
increasing, and the processor being stuck in a spinlock.

I added printouts to the sun4d interrupt handler (Hoping that prom_printf=20
is interruptsafe). This reveals that it is triggered only once with=20
the SUN4D_TIMER_IRQ as the pil argument. I guess that the interrupt is not =

marked as processed correctly/retriggered.=20
(sun4d_clear_clock_irq is called, so it should be)

Does anyone have the datasheet for SuperSparc II and MXCC? as there are=20
some sun4d specific calls being made during interrupt processing that=20
read some status flags from the MXCC.

-
Kjetil Oftedal
