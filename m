From: David Miller <davem@davemloft.net>
Date: Wed, 15 Aug 2012 23:57:09 +0000
Subject: Re: SILO fails to read silo.conf from EXT4 FS
Message-Id: <20120815.165709.1978359982760891260.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5015201A.8060309@gentoo.org>
In-Reply-To: <5015201A.8060309@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ra=FAl Porcel <armin76@gentoo.org>
Date: Sun, 29 Jul 2012 13:35:54 +0200

> With the rewrite of the e2fs part of SILO, its unable to read
> /etc/silo.conf from an EXT4 FS. It can read from EXT2 and EXT3,
> though.
>=20
> Dumpe2fs from the partition where silo.conf is located:

Thanks for the report, I'll try to fix this.
