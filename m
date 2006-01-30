From: Frans Pop <aragorn@tiscali.nl>
Date: Mon, 30 Jan 2006 13:07:24 +0000
Subject: Re: Attempts to set date with 'date -s' hang the machine
Message-Id: <200601301407.25423.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1551149.CCihTFjOgH"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0601300019430.4017@bobcat>
In-Reply-To: <Pine.LNX.4.63.0601300019430.4017@bobcat>
To: sparclinux@vger.kernel.org

--nextPart1551149.CCihTFjOgH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 30 January 2006 10:19, David S. Miller wrote:
> This patch does that, and should fix this bug.

I've tested this patch on my Ultra10 and it works. The date is now set=20
correctly without hanging.

Thanks David.

--nextPart1551149.CCihTFjOgH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3g+Ngm/Kwh6ICoQRAlmDAJ4j8sTLtyJhnoqG8r4xQdrdlvej+gCgvS45
0l6bV8K/yWKAWeD21va2e6Y=
=KUV6
-----END PGP SIGNATURE-----

--nextPart1551149.CCihTFjOgH--
