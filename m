From: David Miller <davem@davemloft.net>
Date: Wed, 20 Dec 2006 02:49:08 +0000
Subject: Re: nfs and sparc64
Message-Id: <20061219.184908.74748190.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <458878BC.3040106@systella.fr>
In-Reply-To: <458878BC.3040106@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Wed, 20 Dec 2006 00:41:48 +0100

> 	U60 runs debian/etch, nfs-kernel-server, and client I use for tests is=20
> a i386 (K6-3/400) that runs debian/etch too. I have tested different=20
> memory configuration and the oops always occurs at the same instruction.
>=20
> 	Any idea ?

Any chance you can test a gcc-4.0.x compiled kernel?
This might be a miscompile.
