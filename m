From: David Miller <davem@davemloft.net>
Date: Mon, 07 Sep 2009 23:51:21 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090907.165121.16205325.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 7 Sep 2009 16:19:22 +0200

> On Sun, Sep 06, 2009 at 11:48:05PM +0200, Sbastien Bernard wrote:
>> David Miller a =E9crit :
>> >From: S=E9bastien Bernard <seb@sfrdev.fr>
>> >Date: Tue, 28 Apr 2009 14:52:54 +0200
>> >
>> > =20
>> >>Unfortunately, this kernel hangs in the same way as the others.
>> >>Same place, same symptom.
> ...
>> Hi, the problem is still present in the 2.6.30 kernel and, since=20
>> distributions are
>> pushing new kernels, I'm now unable to boot any kernel released either=20
>> by debian or Ubuntu.
>=20
> tried 2.6.30.5 on my Sun Fire 880 (uses qla2xxx) with the nmi patches=20
> (see below), but the kernel still hangs after the famous=20
> "NET: Registered protocol family 16" line.
>=20
> Any other patches I can try (or what else) ?

So turning NMI watchdog off entirely doesn't solve it.

Oh well.  I'm going to be honest with you guys, that until I
can reproduce that problem myself here locally it's too heavy
of a bug for me to fix just going back and forth with someone
with debug patches.
