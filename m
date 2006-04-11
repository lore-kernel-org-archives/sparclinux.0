From: Frans Pop <aragorn@tiscali.nl>
Date: Tue, 11 Apr 2006 21:37:43 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <200604112337.53848.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4137952.p081MhLqzl"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
To: sparclinux@vger.kernel.org

--nextPart4137952.p081MhLqzl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 April 2006 23:21, David S. Miller wrote:
> > What are the reasons the code in second/timer.c was changed?
> >
> > That the sun4u_notimer support is still needed for a large class of
> > hardware out there has been demonstrated by my tests.
>
> You cannot write to the %tick register on some cpu variants,
> it can only be written by the hypervisor.

Is it possible to test for that capability being present?

--nextPart4137952.p081MhLqzl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEPCGxgm/Kwh6ICoQRAtvbAJ4xqd7Veo0H6BoigtJx1Poz6LKZLACgj7+H
kN0wtEyeGXgFV+szFFrgWKQ=
=l9PK
-----END PGP SIGNATURE-----

--nextPart4137952.p081MhLqzl--
