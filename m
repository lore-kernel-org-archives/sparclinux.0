From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 24 Apr 2007 15:17:34 +0000
Subject: Re: Dropping sparc32 for lenny
Message-Id: <462E1F8E.3070406@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Michelle Konzack a =E9crit :
> Hello *,
>=20
> Am 2007-04-19 09:31:43, schrieb Mark Morgan Lloyd:
>> Martin wrote:
>>
>>> I was under the impression that there were other SPARC based embedded
>>> chips around.  Is it worth contacting the developers of the Leon about
>>> this?  IIRC one of their selling points was a full, free OS and tool
>>> chain.  I suspect if Debian stops supporting sparc32 then the amount of
>>> work done on keeping it viable will drop andthe bit rot will set in.
>>> Thus I can see some advantage to them commiting some time to keeping it
>>> live.
>> At that point it might be worth having a Debian subproject specifically =
for
>> SPARC kernel 2.4 in the same vein as Debian GNU/Hurd. Discard any GUI th=
at takes
>> an excessive amount of CPU resources, discard audio, streaming video etc=
. and
>> concentrate on a reliable toolchain and kernel.
>=20
> I am running a SS10 SMP (512 MB of memory) with minimal installation
> and fvwm.  I think, for further Debian releases, sparc32 should drop
> all memory consuming apps and I fully agree with you.
>=20
> In general, I use my 2 of my 4 SS10 as buildd.

	I don't aggree. Some new hardware are created today with Leon and some=20
other sparc v8 processors (in fpga or other technology). If sparc32 port=20
is dropped, no one usable system will be able to use these systems.

1/ Sparc32 (with sun4m) support was dropped with solaris 10 and solaris=20
9 is not stable with more than two procs;
2/ NetBSD 3.1 is not stable when it runs on SMP configuration;
3/ NetBSD 4.x is not usable (on SS20 with CG14);
4/ OpenBSD cannot run on any SMP station;
5/ Linux sparc32 is not dropped, some bugs remain in sparc32 SMP kernel,=20
but is better than all other systems on sparc32.

	I use several SS20 (with raid, CG14, SMP, X, windowmaker...) with only=20
one trouble: a bug in read_pipe()... And I have worked on another=20
project that uses Leon. Berkeley University work today on a calculator=20
that shall use several Leon processors... Sparc32 is not died even Sun=20
does not sell Sparc32 anymore.

	Thus dropped sparc32 arch will be a big strategic error for Debian.

	Regards,

	JKB
