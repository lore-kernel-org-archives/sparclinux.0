From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Thu, 02 Apr 2020 14:57:38 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <2790388.WAhmubx6ku@daneel.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1641587.pqXMvmSoLt"
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
To: sparclinux@vger.kernel.org

--nextPart1641587.pqXMvmSoLt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> The only recent change prior the move to assembly was on 2.25 where we had
> to disable the stack protector.  For 2.31 release, for instance, I used the
> gcc 7.5.0 since it didn't trigger this issue.

I recently tried rebuilding 2.29 on Gentoo with 9.2 and things started 
breaking, may that still be an issue?

> > I know that there have been some stability issues with the Linux kernel on
> > SPARC with older hardware like the UltraSPARC IIIi. The T5120 we have and
> > newer machines seem to run relatively fine with a 64-bit userland.
> 
> Not only stability issues, but I noticed that kernel developers had
> fixed a SysV IPC kernel issue on 32-bits kernels that has been
> lingering for years.  So I am not sure how well maintained is
> 32-bit sparc is in general.

This seems generally be an option, but noone has a clue of LDOM at the moment. 
You way come to #gentoo-sparc on Freenode if you want to give a helping hand.

> [1] https://sourceware.org/glibc/wiki/Release/2.31

That only lists known test failures regarding sparc?

Eike
--nextPart1641587.pqXMvmSoLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXoX9YgAKCRBcpIk+abn8
Tqs4AJwLtCrbsc59c7zeb17QbEVOn+KgFwCfQb4YtqiDvu+cMMJFT9fymZfIyRk=
=BXwS
-----END PGP SIGNATURE-----

--nextPart1641587.pqXMvmSoLt--
