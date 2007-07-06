From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 06 Jul 2007 09:54:09 +0000
Subject: Re: [BUG] 2.6.22-rc7 breaks nis server on sparc64
Message-Id: <468E1141.40303@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <468E0DCE.7020207@systella.fr>
In-Reply-To: <468E0DCE.7020207@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 06 Jul 2007 11:39:26 +0200
>=20
>> 	Hello,
>>
>> 	I test a 2.6.22-rc7 kernel on a U60/SMP. This U60 is a NIS server for a=
=20
>> U2 (that runs 2.6.21.3). If U60 runs a 2.6.21.5, ypserv runs fine. With =

>> 2.6.22-rc7 (and of course the same system), ypbind on U2 cannot connect =

>> to ypserv. Portmap runs in both kernels.
>=20
> I'm going to need more debugging information than that.

	I understand. There is no information in log file, no oops. What kind=20
of information do you want ?

Root rayleigh:[~] > ypserv --version
ypserv (ypserv) 2.19
Root rayleigh:[~] > portmap -V
portmap version 6.0 - 2007-May-11
Root rayleigh:[~] > ypbind --version
ypbind (ypbind-mt) 1.20.1

	Maybe this trouble is related to threads support that is broken on=20
sparc64 with glibc-2.5. I'm testing glibc-2.6 on my U60 and it seems to=20
run better (without pthreads deadlocks I have seen on portmap, clamd,=20
named...).

	Regards,

	JKB
