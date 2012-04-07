From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 07 Apr 2012 17:21:38 +0000
Subject: Re: [sparc] BUG: NMI Watchdog detected LOCKUP on CPU0
Message-Id: <1333819298.7150.63.camel@deadeye>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-mKPtp0WbCUCzCTxPbLT3"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-mKPtp0WbCUCzCTxPbLT3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Summary for the SPARC maintainers:

The NMI watchdog is firing on Sunfire 280R and Sun Blade2500 systems
with one or both processors in cheetah_xcall_deliver().  This has been
seen under 3.0, 3.2 and 3.3 and seems to be associated with disk I/O.

Full bug log is at: http://bugs.debian.org/648766

On Tue, 2012-04-03 at 20:56 -0400, Kieron Gillespie wrote:
> I have also noticed, that if I am reading the trace correctly that in=20
> both of my cases, and the original bug submitter's, and a bug posted on=
=20
> old.nabble.com's case the crash always seems to happen when one CPU is=
=20
> doing cheetah_xcall_deliver, and the other CPU is in the same=20
> instruction in tl0_irq15. Here is a link to the post.
[...]

tl0_irq15 seems to be part of the NMI watchdog (for detecting that the
kernel has hung), so you should always see that in a backtrace when the
NMI watchdog fires.  It's not part of the problem.

cheetah_xcall_deliver() does appear to be relevant to the problem and it
looks like it could loop indefinitely - though presumably only if a
processor is behaving strangely?  It appears to periodically enable and
disable interrupts, but then I'm not sure how the PSTATE.IE and PIL
interrupt control fields interact and I don't think this will reset the
NMI watchdog.  In any case, it seems like there's a serious problem if
it's looping for a long time, whether or not interrupts remain disabled.

Ben.

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.

--=-mKPtp0WbCUCzCTxPbLT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT4B3oue/yOyVhhEJAQqMRA/+IVMrnB6m5nIpko3GGHbgYFipKZ8u3Y6q
zK4CmDwHjdKH1mqRZ6felN5qeRSZADFHrhzivne3G33na+CZe+LFmwghag0+9bRt
jtyTmuiEhUzk51vuQxpPDKHAM7OptOmb267M5of6P2jUlTsE/U1uku4/9YjZ9jrE
zA1diLsR0vK0jacwmIJmCs6SPa034aizUAGXrXvAgQfaetAAk3MSFxjO5itQXBL1
Ec71n/DzBDdoyC8AGaI/VTSNEsZfclcFBcJ79XN8AAyEHY32emSPd73IL5CGtvOL
sCCYpoUr+M7s7PVy+/C64c/h0NIjYd5RofSCDHU/8eGwJ1kn/UU6QTch3WlCDrpL
Jz9Jsw5CALzBPPVxdhfS2q0Rv7S8nxa4a3ROweZgx3/gtYfHLuPpNu2/z62uCAc3
SQitinzyz2Ek/m1eZZnhT+qo6sXkxIQIajsR2RE2m4jt4MvBM42nz0gJ/f22Fhu+
lt8rLPFZC2MbjwYK+OyYAsMm6MentIDfaDVp7HOl9AErlNx8nTQGG/pyQIuGONe/
v/CcQqkMhiwJiO4uhV0S4JN2rp7hSr2SfMaTMt4d56XEioV+UwNPUmnUwdrpBvD6
Gg4XYE7aKCss2gDhoVqgsod8vmAPsxSjP/++KgNaOXvaxh3lVD58t5OQSTncxk7f
a0FaCBYogtE=
=/xGI
-----END PGP SIGNATURE-----

--=-mKPtp0WbCUCzCTxPbLT3--
