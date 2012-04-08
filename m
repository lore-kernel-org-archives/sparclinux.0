From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 08 Apr 2012 21:12:06 +0000
Subject: Re: [sparc] BUG: NMI Watchdog detected LOCKUP on CPU0
Message-Id: <1333919526.7150.152.camel@deadeye>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-/e1WERE7Cu521JHRqWpN"
List-Id: <sparclinux.vger.kernel.org>
References: <1333819298.7150.63.camel@deadeye>
In-Reply-To: <1333819298.7150.63.camel@deadeye>
To: sparclinux@vger.kernel.org


--=-/e1WERE7Cu521JHRqWpN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-04-07 at 13:40 -0400, David Miller wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> Date: Sat, 07 Apr 2012 18:21:38 +0100
>=20
> > cheetah_xcall_deliver() does appear to be relevant to the problem and i=
t
> > looks like it could loop indefinitely - though presumably only if a
> > processor is behaving strangely?
>=20
> I can only loop indefinitely if one of the cpus is hung and
> does not respond to the cross-call interrupt.

Well, it has to keep responding with a NACK, right?

Will the recipient NACK if the cross-call interrupt is disabled, or do
the processors have a buffer/FIFO for such IRQs?

If there's no buffer then what stops two processors live-locking here?
(The 'random time' where some interrupts are enabled isn't really very
random, so it seems to be possible for two processors to go round the
loop in lock-step.)

> > It appears to periodically enable and disable interrupts, but then
> > I'm not sure how the PSTATE.IE and PIL interrupt control fields
> > interact and I don't think this will reset the NMI watchdog.
>=20
> PSTATE.IE controls delivery of all interrupts, both PIL
> based and vectored interrupts.
>
> PIL only controls delivery of PIL interrupts.
>=20
> The NMI watchdog interrupt is a special PIL interrupt, and
> most of the standard local_irq_disable() et al. routines on
> sparc will adjust the %pil such that NMI watchdog interrupts
> are still delivered.
>=20
> See include/asm/pil.h for details.

Obviously the NMI watchdog is not being disabled, but I was wondering
how its timer gets reset.

Having RTFS, it appears that it is never really reset but is held off by
either an hrtimer interrupt or an explicit call to watchdog_nmi_touch()
during each interval.  If I'm not mistaken, the hrtimer interrupt is
being disabled by xcall_deliver() and remains disabled.

Ben.

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-/e1WERE7Cu521JHRqWpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT4H/Jue/yOyVhhEJAQqjxg/8DoRwKHdFkxJaQyOnCCymF4Q+0jX7E2sr
2nSsnGqsPV5PfnOZMhEuHxCHPZdHEGMQk+DCMhnT3h0QSKJcSuP+qOUgwFt7g6/a
GVaAG8/n5qconwq7js31mUjLF5+EWhRHw960JB+TS/Y6X5e/dk31q1pwIIQPOiII
mjjY7zhWxAdm7kX39a2LAuZ1PqnNBPYmi8ATlg3AD9V2brehnPhZfBhpICa/Y5vN
iVe2MfHNa3FJdFu5OHz5AMUbPfFVM4QcTkeC25JDIS1gVECoKElT7UdVwNarQP0f
9nvCX6+88QiMskXMp4KGyIlNlqrSIO/EjR5X/d8TuPoDoq8xx2hJOlZUfz///XD1
bYGlyfV2CHii9k5BBiCeUC4SIQ4b6i4oVTZYfNWG8C4kevclzqqx7ZCPXrg+3UBP
gIbnATiTDSBLMg9JhHciU70KCArpb/EkgDug1qvScDaVYj7Ll06KeJ60/bXHVwiJ
Ndlz3Q8TkoxjTV2Dp8ihH/i7PIY9DeJtQCkeq20fyWBU+29eW30xBt5KKVQBivN0
gAuIH8obfYfW1Zyzk8tWcAZaW7/PaVk/RvlDQs5GMTsPdoZxwRM/L/HSxwUPk09q
rKhII6I+U4pofx7ri3IyXFn3qSiuQj7CLGC7fNqPn+CTDve8/+jw6HFAyRWmEJKy
m4ODWFD4WN8=
=m7IA
-----END PGP SIGNATURE-----

--=-/e1WERE7Cu521JHRqWpN--
