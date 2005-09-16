From: "David S. Miller" <davem@redhat.com>
Date: Fri, 16 Sep 2005 19:59:19 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <20050916.155919.41629794.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
	<20050915.133026.21581824.davem@davemloft.net>
	<Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org

From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)

> On Thu, 15 Sep 2005, David S. Miller wrote:
>=20
> > I wonder if the NFS daemon code needs to have some limits put on
> > how much cpu it consumes handling requests before it gives up the
> > cpu.  Perhaps, it has such throttling already, I don't know.
>=20
> But this not case NFS server but NSF client. During this lookups I observ=
e=20
> rpciod takes 90-99% time of single processor. Load is between 10 and 20.

After studying some code yesterday, NFS client has the same
exact problem as NFS daemon, namely that if you give it enough
work it will never give up the cpu so that other tasks can
be scheduled.

This is a serious bug, and can easily trigger those soft lockup
messages.  Based upon some other reports seen on linux-kernel
and elsewhere, things like the raid1 kernel daemon have a similar
issue as well.

I think you can help things _enormusly_ by turning off SLAB
poisioning, as I said that debugging feature is _VERY_ expensive.
