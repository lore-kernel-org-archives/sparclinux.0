From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 11 Jan 2007 08:18:19 +0000
Subject: Re: NFS Oopses on SPARC64?
Message-Id: <45A5F2CB.5070607@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <200701091315.l09DFl1B006228@laptop13.inf.utfsm.cl>
In-Reply-To: <200701091315.l09DFl1B006228@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
> Date: Tue, 09 Jan 2007 12:56:34 -0300
>=20
>> BERTRAND Jo=EBl <joel.bertrand@systella.fr> wrote:
>>> Horst H. von Brand a =E9crit :
>>>> I've got Oopses with high(ish?) NFS load (compiling stuff on my x86_64=
 on
>>>> my automounted home from SPARC64) with vanilla 2.6.19.1 and 2.6.20-rc4
>>>> (didn't do any such madness before, and not in between). Reported as 7=
795
>>>> and 7796 in bugzilla.kernel.org. Aurora Corona on a SPARC Station Ultr=
a 1,
>>>> up to date.
>>>> Has anybody else seen something like this? This machine has had
>>>> random NFS
>>>> and hang problems, which I didn't have the time to investigate further=
 then.
>>> 	I have reported in this mailing list the same bug.
>> Please report it (again?) on bugzilla.kernel.org, so it isn't lost in the
>> noise here.
>=20
> Thanks for all the information folks.
>=20
> I plan to try and look into this after I get back from LCA2007 on
> January 22nd.

	I have seen a patch against this bug (bugzilla.kernel.org, #7795). I=20
don't have any time to test it before the next week... Can someone test it ?

	Regards,

	JKB
