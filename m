From: Jeremy Huddleston <jeremy@outersquare.org>
Date: Wed, 14 Apr 2004 09:17:10 +0000
Subject: Re: USB mouse problems in 2.6 + KVM
Message-Id: <1081934229.5004.104.camel@yufi.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-JTJWb17V+3qtsrCbrgvr"
List-Id: <sparclinux.vger.kernel.org>
References: <1081588488.9657.241.camel@eradicator.outersquare.org>
In-Reply-To: <1081588488.9657.241.camel@eradicator.outersquare.org>
To: sparclinux@vger.kernel.org


--=-JTJWb17V+3qtsrCbrgvr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I found the problem and posted the fix in a bugzilla entry:
http://bugzilla.kernel.org/show_bug.cgi?id=3D2504

It's not just a sparc problem.  I was wrong when I said my x86 box
worked... it was running 2.4 when I tried it.

The usbmouse problem still eludes me.  It is present as far back as
2.4.5, and I really don't feel like going further back than that to see
if it ever worked...

Additionally somewhere between 2.4.25 and 2.4.72 there seems to be a
problem selecting text in console mode, and if anyone else notices that,
please contact me, but as i said, this isn't sparc specific, so I'm
going to take this problem elsewhere.

Thanks,
Jeremy

On Sat, 2004-04-10 at 02:14, Jeremy Huddleston wrote:
> Hey all,
>=20
> System (variables that don't change):
> I've got a u10 with a Belkin USB2 PCI card (NEC chipset, OHCI).  I've
> got a logitech wheelmouse digital (usb) and a Belkin Omniview KVM
> (F1DE108B). gpm-1.20.1 kbd-1.12=20
>=20
> Problem Configuration:
> kernel-2.6.5 - belkin kvm connected to system.
>=20
> When I conenct my belkin kvm switch to my system running kernel 2.6.5,
> the keyboard works fine, but the mouse doesn't work in console mode.=20
> Whenever I left click, a 'W' is typed.  right click -> 'E'.  Scroll does
> nothing.  Middle pastes.
>=20
> When it does work (what I can change to get the correct behavior):
> 1) Use X: when I am in X, the mouse behaves correctly
> 2) Plug the mouse in directly (ie, not using the KVM)
> 3) Use a 2.4 kernel
> 4) Use 2.6.4 on an x86 machine connected in the same manner  (haven't
> tried 2.6.5, but I suspect it will work there)
>=20
> Note that I tried using 'usbmouse' kernel module instead, but I found
> another problem with it... the buttons don't respond.  moving mouse
> left-to-right moves the cursor up-and-down.  This exhibited itself in
> both X and console while the belkin was plugged in, but plugging the
> mouse in directly fixed this problem...
>=20
> Has anyone seen this type of problem?  Does anyone have any suggestions
> for debugging this?
>=20
> Thanks,
> Jeremy

--=-JTJWb17V+3qtsrCbrgvr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfQGTgKpk8srJOlIRApyKAJ9dHjHnkIgItxX39Tq5klRKENBPzACdHBrA
Fb+bwpUBxu/mha1Ymiffg3s=
=WNev
-----END PGP SIGNATURE-----

--=-JTJWb17V+3qtsrCbrgvr--

