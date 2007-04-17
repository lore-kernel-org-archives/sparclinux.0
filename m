From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 18:48:57 +0000
Subject: Re: QuadEthernet driver broken
Message-Id: <20070417.114857.54189141.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87lkgxgxvj.fsf@chbouib.org>
In-Reply-To: <87lkgxgxvj.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: ludo@chbouib.org (Ludovic Court=E8s)
Date: Tue, 17 Apr 2007 20:45:26 +0200

> Hi,
>=20
> ludo@chbouib.org (Ludovic Court=E8s) writes:
>=20
> > The `sunqe' driver appears to be currently broken:
> >
> >   http://lists.debian.org/debian-sparc/2007/04/msg00036.html
>=20
> To sum up, `sunqe' displays erroneous addresses at initialization time:
>=20
>   sunqe.c:v4.0 June 23, 2006 David S. Miller (davem@davemloft.net)
>   eth0: qe channel[0] 00:00:00:00:00:00=20
>   eth1: qe channel[1] 00:00:00:00:00:00=20
>   eth2: qe channel[2] 00:00:00:00:00:00=20
>   eth3: qe channel[3] 00:00:00:00:00:00
>=20
> Since these are displayed at module initialization time (in
> `qec_ether_init ()'), couldn't it be due to incorrect accesses to the
> PROM device tree, somehow related to the recent PROM API change [0]?

I'll look into this bug report, I'm just swamped with about
10 or so other sparc platform bug reports at this time.

Just be patient or figure out the bug yourself and post a patch
for me to apply which fixes it :-)

