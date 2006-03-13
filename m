From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Mar 2006 03:14:25 +0000
Subject: Re: ESP busted
Message-Id: <Pine.LNX.4.64.0603122012060.10262@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 12 Mar 2006, David S. Miller wrote:

> From: Jason Wever <weeve@gentoo.org>
> Date: Sun, 12 Mar 2006 14:09:43 -0700
>
>> OK, just got time to test this.  Using gcc-3.3.5 and your patch
>> against 2.6.16-rc6, everything is booting fine on an Ultra 1.
>> Anything you'd like to see from the compiled output?
>
> And 2.6.16-rc6 without the patch is definitely broken
> right?  Can you verify this?  I want to make sure I'm
> fixing something.

With gcc-3.3.5 and gcc-3.3.6, esp works fine with or without the patch on=20
2.6.16-rc6.  If gcc-3.4.5 is used to compile 2.6.16-rc6, the patch does=20
not really appear to change anything as the esp errors happen with or=20
without it.

Cheers,
- --=20
Jason Wever
Gentoo/Sparc Team Co-Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEFOOVdKvgdVioq28RAoO6AKC1CDFsZ5lWu919fAHRGXDyPHMjqACfZr+J
IGFMQOkPgPn55+QyueXCOn8=A0Qp
-----END PGP SIGNATURE-----
