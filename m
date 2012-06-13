From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 13 Jun 2012 00:50:41 +0000
Subject: Re: linux-next: build failure after merge of the final tree (pci tree related)
Message-Id: <20120613105041.2d5dcdde6b9cf3dcfba3885d@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__13_Jun_2012_10_50_41_+1000_6vYAvXUgcl5rGlJ/"
List-Id: <sparclinux.vger.kernel.org>
References: <20120612145441.400975347f06785d391d0f8f@canb.auug.org.au>
	<CAErSpo6LxpYz_WK2mHPW3RWkOMPLar0KUp1Pgh7shhOdmT49kw@mail.gmail.com>
In-Reply-To: <CAErSpo6LxpYz_WK2mHPW3RWkOMPLar0KUp1Pgh7shhOdmT49kw@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

--Signature=_Wed__13_Jun_2012_10_50_41_+1000_6vYAvXUgcl5rGlJ/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Tue, 12 Jun 2012 09:31:49 -0600 Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>
> Thanks, I folded this typo fix into the relevant patch.  I'll rebase
> "next" today.  Sorry for the trouble.

I am not sure what you have done, but now you have a set of duplicated
commits in your tree including both versions of the one that caused the
build failure.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__13_Jun_2012_10_50_41_+1000_6vYAvXUgcl5rGlJ/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP1+PhAAoJEECxmPOUX5FEYtwP+QFdFE2JnVbn+3LOYiStpBPq
2hWCWGP84s27F7XtX8PAXK/01IBfLppyUuSp9IHHJkttRFQIcWBN995VwXCT3ebz
iYk4T1Ik40s+qscDaBixQUN4RBzU0TI/nOYhhLKYJ9VqJ+lz86qi1t7emcQoLCiS
NE9i0SlBrpzD2l47uQ/WbwjNKAAxChcttS/olQhwz5feYHhe6nkL26zyr8NDE09g
BkZ04hYnyN52GrLwfkvjB8U0JO25qUsr9bjo4WRkAT73YMuQAj/ahxXJQDEEziIP
brfJAqy09OpLcLXmKBczWODCwWIYHC61jX2kI+XtjFZTxzXYCACpR23yRq0TLy3R
M7Uk4P/CNQi31jR6ovVBUQ2zShR0Mm0PUIyvm2FNcMf/M3/RmaI9+yKKNeLY8NMP
MYYwk4Ojepr3hAxkY4gRHRiFfNQk3SB+plQV9bwOPOx42wEJyt4AvfY1PGTgiXxt
O51ysVhN+vMNUT8Txn9AQKYUjqX7AuHAVpcy2NHVwzruxoEe5x3ZMarHqZ0RkOOL
agrxANV/+RniSQ6Wark9D6fgM14OZ8b5/rf/zM3/BzF1S/UVzOIN/NFxUM9nuPcx
F+FDiCJLfcma20TSxZ3YonILyVAjmzxdEfkdD4X3SgP61nVMzcofmZLBQrIZnIrS
yD1dEmTjVPgySm6bKLk7
=tQSY
-----END PGP SIGNATURE-----

--Signature=_Wed__13_Jun_2012_10_50_41_+1000_6vYAvXUgcl5rGlJ/--
