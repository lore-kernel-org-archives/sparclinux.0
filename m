From: Andrew Gaffney <agaffney@gentoo.org>
Date: Wed, 21 Mar 2007 13:49:14 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <460137DA.8030808@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Chini, Georg wrote:
>=20
>=20
> Ferris McCormick wrote:
>=20
>> On Wed, 2007-03-21 at 10:53 +0100, bertrand wrote:
>> =20
>>
>>> Ferris McCormick a =C3=A9crit :
>>>  =20
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>>    =20
>>
>> --- snip ---
>>
>> =20
>>
>>>>>     JKB
>>>>>      =20
>>>> This is a problem with U2+kernel-2.6.x generally.  Unfortunately, I
>>>> have no suggestions nor do I have a solution. I just grit my teeth and
>>>> stay with the kernel-2.4.x series, which are completely stable on U2,
>>>> so far as I can tell.
>>>>    =20
>>>     What is your U2 configuration ? I have only one U2 and I cannot=20
>>> test on this station because it's a mail server :-( In fact, I think=20
>>> it should be interesting to know if this trouble come from SMP, ESP=20
>>> or Sbus support. It is impossible to build a kernel with debug=20
>>> information (it does not boot due to a address not aligned...), but I=20
>>> have tested the same kernel on a U1E (with the same ESP chip and two=20
>>> additional HappyMeal Ethernet cards on Sbus slots). It perfectly=20
>>> works. Can you try a 2.6 on U2 without SMP support ?
>>>
>>>     Regards,
>>>
>>>     JKB
>>>  =20
>>
>> I have 2 U2's; U2(2x300), U2(2x400).  The SMP doesn't matter, though; U2
>> with 2.6.x will freeze eventually even if a uniprocessor.  SMP just lets
>> it fail more quickly.  Problem is believed to be SCSI or Sbus, I think,
>> but I don't know that anyone is sure.  The kernel people have known
>> about this for well over a year, but no fix.
>>
>> For more current information, you might ask squash@gentoo.org or
>> weeve@gentoo.org --- I haven't tried 2.6 on U2 for a while because no
>> one has claimed to have a fix for this problem.  (Gentoo spent a lot of
>> time on this freeze a few months ago, but no satisfaction.  I am sure,
>> though, that we ruled out SMP as the problem.)
>>
>> =20
>>
>>> -
>>>  =20
>> Regards,
>>
>> =20
>>
> Hi,
>=20
> I'm running 2.6.20-rc5 on my ultra2 (2x300) for a few weeks now and have =

> not
> observed any freezes at all. I attach my config, maybe you can find some =

> hint
> what causes the problem.
>=20
> Regards

That doesn't really mean much. My U2 ran for 45 days on 2.6.12 before locki=
ng up=20
solid. It was killed by a nightly rsync of the Gentoo portage tree. It had =
done=20
the same sync 44 times previously, but that time took it out. With 2.6.17, =
it=20
hard locked the first time I synced the tree on a new install, but that was=
 a=20
full sync instead of just a small subset like with 2.6.12.

--=20
Andrew Gaffney                            http://dev.gentoo.org/~agaffney/
Gentoo Linux Developer                                   Installer Project
