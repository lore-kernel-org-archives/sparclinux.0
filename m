From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 16:58:25 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515.125825.1601451429241216417.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 15 May 2012 02:16:08 -0500

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> El Tue, 15 May 2012 01:09:44 -0400 (EDT)
> David Miller <davem@davemloft.net> escribi=F3:
>> +			prom_printf("Sparc-Linux Cypress support
>> does not longer exit.\n");
>=20
> maybe that should say
> "Sparc-Linux Cypress support no longer exists.\n"

I made it match the language used by the sun4/sun4c message
for consistency.
