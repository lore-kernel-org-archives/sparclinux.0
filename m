From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 15 Sep 2005 20:30:26 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <20050915.133026.21581824.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kloczek@rudy.mif.pg.gda.pl
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org, davem@redhat.com

From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Thu, 15 Sep 2005 19:40:27 +0200 (CEST)

> I'm just catch series of kernel messages with soft lockup detected report=
s=20
> (in attachment).
> It occures during store big amout of data on NFS volume.
>=20
> As NIC I use now Sun Swift gigabit eth (cassini driver). Probably this is=
=20
> NFS related because I'm just browse yesterday logs and simillar was also =

> on Sun Happy Meal.

Interesting.  Can you reproduce this with SLAB poisioning disabled?
That debugging feature is extremely expensive, although it shouldn't
make the CPU stop scheduling processes for more than 10 seconds.

I wonder if the NFS daemon code needs to have some limits put on
how much cpu it consumes handling requests before it gives up the
cpu.  Perhaps, it has such throttling already, I don't know.

I'll also try to see if there can be some kind of sparc64 specific
issue which would cause this.

Where did you get that Cassini driver btw?  It's not upstream,
although if it exists it should be.
