From: Joerg Friedrich <Joerg.Friedrich@friedrich-kn.de>
Date: Tue, 27 Feb 2007 05:22:39 +0000
Subject: Re: sparc64 / bbc_i2c.c
Message-Id: <20070227052239.GA30083@stardust.friedrich-kn.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1171978032.18442.11.camel@lax.shef.ac.uk> <20070225044754.1d849a8d.akpm@linux-foundation.org> <Pine.LNX.4.64.0702252352310.32309@parallax.ddns.shef.ac.uk> <20070226.101219.18306730.davem@davemloft.net>
In-Reply-To: <20070226.101219.18306730.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: j.j.green@sheffield.ac.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi David,

David Miller schrieb am Montag, 26. Februar 2007 um 10:12:19 -0800:
> From: "J.J.Green" <j.j.green@sheffield.ac.uk>
> Date: Sun, 25 Feb 2007 23:58:48 +0000 (GMT)
>=20
> > Hi Andrew
> >=20
> > > The code around there looks relatively unbuggy to me.  Removing that
> > > remove_wait_queue() would be very bad - it would cause later stack
> > > corruption.
> > >
> > > msleep_interruptible() certainly shouldn't consume CPU like that.  Do=
 we
> > > know where the CPU time is being spent?  The output of:
> > >
> > > readprofile -r
> > > sleep 10
> > > readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40
> > >
> > > would tell us.
> >=20
> > As was mentioned in another reply, this message by
> > Joerg Friedrich
> >=20
> >    http://lists.debian.org/debian-sparc/2007/02/msg00045.html
> >=20
> > gives a possible explanantion of where the time is going.
> > I applied the patch to the debian kernel sources for 2.6.18,
> > it applied cleanly and fixed the problem.
>=20
> I've added Joerg's patch to my tree and will push it into
> -stable as well.
>=20
> Reviewing this patch had been sitting deep in my backlog for weeks, I
> just never got around to it, sorry.

Can you just tell me if it's sufficient to check for  a return value >0
of wait_event_interruptible_timeout? I was not sure so I extended the
check to=20
if ((val !=3D -ERESTARTSYS) && (val > 0))

--=20
Yours,
J=C3=B6rg Friedrich

There are only 10 types of people:
Those who understand binary and those who don't.
