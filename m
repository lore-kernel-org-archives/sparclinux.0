From: David Miller <davem@davemloft.net>
Date: Wed, 02 Aug 2017 16:45:11 +0000
Subject: Re: Sparc64 kernel rcu_sched stalls
Message-Id: <20170802.094511.1422098252126719138.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Pierre Muller <pierre@freepascal.org>
Date: Wed, 2 Aug 2017 11:04:20 +0200

>=20
>=20
> Le 27/07/2017 =E0 01:41, David Miller a =E9crit :
>> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Date: Fri, 21 Jul 2017 16:28:01 +0200
>>=20
>>> When running the attached, statically linked binary on a recent
>>> kernel, the kernel locks up with:
>>=20
>> Thanks a lot, as soon as I sort through the RCU stall bug I'll take
>> a close look at this!
>>=20
>=20
>=20
> Hi David,
>=20
>   is this responsible for the fact that sometimes
> my bash sleep commands do not return after the argument given time is ela=
psed?
>=20
>   Is there a way to 'shake' the system?
>=20
>   I do have a lot of
> INFO: rcu_sched detected stalls on CPUs/tasks
> messages in dmesg output, but I do not see
> directly any user program that is causing the problem
> in the output.
>=20
> There are however a lot of segfault reports that are generated
> by the Free Pascal sparc64 testuite runs, on Debian stadler machine.
>=20
> Are the two related?

I have no idea if these two things are related.
