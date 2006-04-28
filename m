From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 28 Apr 2006 23:00:41 +0000
Subject: Re: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <20060428.160041.42740323.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200604280042.08024.pkarlsen@mandriva.com>
In-Reply-To: <200604280042.08024.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Fri, 28 Apr 2006 00:42:07 +0200

> When running 2.6.17-rc1 or rc2 I seem to get a lot of these oops, not cer=
tain=20
> about what exactly causes those, but might seem to happen during a little=
=20
> load..
> 2.6.16 runs fine without this ever happening.
>=20
> Machine is a blade 100..

Thanks, this is the second report like this.  The theory is
that tlb->nr is becoming negative for some reason or otherwise
being corrupted.

I'll try to reproduce that here.
