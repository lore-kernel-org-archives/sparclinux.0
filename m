From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
Date: Sat, 10 Apr 2004 09:14:48 +0000
Subject: USB mouse problems in 2.6 + KVM
Message-Id: <1081588488.9657.241.camel@eradicator.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-J7BzgbIJBCRV4jl3arK/"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-J7BzgbIJBCRV4jl3arK/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey all,

System (variables that don't change):
I've got a u10 with a Belkin USB2 PCI card (NEC chipset, OHCI).  I've
got a logitech wheelmouse digital (usb) and a Belkin Omniview KVM
(F1DE108B). gpm-1.20.1 kbd-1.12=20

Problem Configuration:
kernel-2.6.5 - belkin kvm connected to system.

When I conenct my belkin kvm switch to my system running kernel 2.6.5,
the keyboard works fine, but the mouse doesn't work in console mode.=20
Whenever I left click, a 'W' is typed.  right click -> 'E'.  Scroll does
nothing.  Middle pastes.

When it does work (what I can change to get the correct behavior):
1) Use X: when I am in X, the mouse behaves correctly
2) Plug the mouse in directly (ie, not using the KVM)
3) Use a 2.4 kernel
4) Use 2.6.4 on an x86 machine connected in the same manner  (haven't
tried 2.6.5, but I suspect it will work there)

Note that I tried using 'usbmouse' kernel module instead, but I found
another problem with it... the buttons don't respond.  moving mouse
left-to-right moves the cursor up-and-down.  This exhibited itself in
both X and console while the belkin was plugged in, but plugging the
mouse in directly fixed this problem...

Has anyone seen this type of problem?  Does anyone have any suggestions
for debugging this?

Thanks,
Jeremy

--=-J7BzgbIJBCRV4jl3arK/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAd7sIgKpk8srJOlIRAneQAKCrvG7XY35XaFMySERpp+279Ck1DQCeO34l
F9UyYD+lS3oAeSaeIyrIQbU=
=tfxu
-----END PGP SIGNATURE-----

--=-J7BzgbIJBCRV4jl3arK/--

