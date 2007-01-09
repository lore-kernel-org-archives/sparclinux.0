From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 09 Jan 2007 13:23:05 +0000
Subject: Re: NFS Oopses on SPARC64?
Message-Id: <45A39739.2010809@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <200701091315.l09DFl1B006228@laptop13.inf.utfsm.cl>
In-Reply-To: <200701091315.l09DFl1B006228@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Horst H. von Brand a =E9crit :

	Hello,

> I've got Oopses with high(ish?) NFS load (compiling stuff on my x86_64 on
> my automounted home from SPARC64) with vanilla 2.6.19.1 and 2.6.20-rc4
> (didn't do any such madness before, and not in between). Reported as 7795
> and 7796 in bugzilla.kernel.org. Aurora Corona on a SPARC Station Ultra 1,
> up to date.
>=20
> Has anybody else seen something like this? This machine has had random NFS
> and hang problems, which I didn't have the time to investigate further th=
en.
> I attributed them to the (all too common) brownouts here.

	I have reported in this mailing list the same bug. I have an U60/SMP=20
with several raid volumes and 1 GB of main memory that currently runs=20
with official 2.6.19.1. It's NFS randomly hangs with an Oops. I have=20
tried kernel-nfsd (v3 and v4), same result. But user-nfsd works fine for=20
me (very slow, but without any oops). I never see any hang trouble (only=20
with sparc32).

	Remark : older kernel work fine and the same kernel built for i386 or=20
K8 works fine too. I have tried to build 2.6.19.1 with gcc-3.4 and=20
gcc-4.1, same result, nfs oppses, but not in the same routine.

> I've set up things so I can disassemble/regenerate the .s for the stuff
> referenced in the Oops, but I'd rather not (my knowledge of SPARC assembly
> is almost non-existent). Any clues/pointers?

	No...

	Regards,

	JKB
