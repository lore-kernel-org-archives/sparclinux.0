From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 08:21:46 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110804.012146.856104592127548350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110728104017.GA27861@entuzijast.net>
In-Reply-To: <20110728104017.GA27861@entuzijast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 28 Jul 2011 12:40:17 +0200

> This patch[0] seems to fix a build issue, but it doesn't fix the
> functionality - the previous change[1] changed the return value semantics,
> it's now supposed to be to be just the old value, rather than a compariso=
n.
>=20
> [0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff;hg8624e401b0b7747762b5223fb23f86dcdacc93
> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff;h=F24219b4e90cf70ec4a211b17fbabc725a0ddf3c

Stephen please post a fix for this before a 32-bit sparc person
loses their filesystem or worse.

The return value semantics have changed for this function, you
can't just put two underscores in front of the name, export
the symbol, and say "Ship it!" :-)
