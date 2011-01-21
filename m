From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jan 2011 06:42:00 +0000
Subject: Re: physical_package_id on sun4v
Message-Id: <20110120.224200.190365297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 21 Jan 2011 02:17:52 +0100 (CET)

> I am still a bit puzzled since the T1 is configured quite like the
> Intel i7 920:
>=20
> T1: 4 threads =D7 6 cores =D7 1 CPU
> 	core_sibling_list=3D0-3, thread_sibling_list=3D0-3
>=20
> i7: 2 threads =D7 4 cores =D7 1 CPU
> 	core_sibling_list=3D0-7, thread_sibling_list=3D0,4
>=20
> And in comparison:
> Altix4700: 2 threads =D7 2 cores =D7 128 CPUs
> 	cpu0/core_sibling=3D0x03 (inferring>) core_sibling_list=3D0-3
> 	cpu0/thread_sibling=3D0x01 (inferring>) thread_sibling_list=3D0-1
>=20
>=20
> So it seems as if, because the toplogy is different between sparc
> and {ia64, x86}, at least one has worse scheduling.

This is to make room for T2's design, wherein inside of a core there
are two integer units.

So in the T2 we get:

cpu0 --> cpu7    --> core_id =3D 1
cpu8 --> cpu15   --> core_id =3D 2

cpu0 --> cpu3    --> phys_package_id =3D 0
cpu4 --> cpu7    --> phys_package_id =3D 1
cpu8 --> cpu11   --> phys_package_id =3D 2
cpu12 --> cpu15  --> phys_package_id =3D 3

etc. etc. etc.

