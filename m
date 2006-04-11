From: Frans Pop <aragorn@tiscali.nl>
Date: Tue, 11 Apr 2006 18:21:50 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <200604112021.51367.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1350348.JLbQNObf2Z"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
To: sparclinux@vger.kernel.org

--nextPart1350348.JLbQNObf2Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 April 2006 03:53, Jurij Smakov wrote:
> Frans Pop has noted that when used on his Ultra 10, new SILO does not
> handle the timeout before booting correctly. On Ultra 10 it just sits
> at the boot prompt, waiting for someone to press Enter, which is pretty
> bad. It works fine on my Ultra 60. Frans has also confirmed, that if
> the changes in second/timer.c, introduced in 1.4.11 are reverted, the
> old behaviour is restored.

=46rom a "releasing the new silo version for Debian" point of view, I'm=20
actually more concerned about this regression than adding support for=20
hardware that was not supported in previous versions either.

What are the reasons the code in second/timer.c was changed?

That the sun4u_notimer support is still needed for a large class of=20
hardware out there has been demonstrated by my tests.

Cheers,
=46rans Pop

(Please keep my address in replies as I'm not subscribed to sparclinux.)

--nextPart1350348.JLbQNObf2Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEO/O/gm/Kwh6ICoQRAriRAKC+EIpmnuPluVZf6t+F1BEE+yWcEwCdE2w0
Cg6xoAeAGaeS36KLoLVDpKI=
=7O1x
-----END PGP SIGNATURE-----

--nextPart1350348.JLbQNObf2Z--
