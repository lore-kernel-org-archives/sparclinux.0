From: bertrand <joel.bertrand@systella.fr>
Date: Wed, 21 Mar 2007 09:53:37 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <460100A1.50407@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ferris McCormick a =E9crit :
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On Tue, 20 Mar 2007 21:53:26 +0100
> BERTRAND Jo_l <joel.bertrand@systella.fr> wrote:
>=20
>> On Tue, Mar 20, 2007 at 07:01:02PM +0100, mt1@systella.fr wrote:
>>> 	Hello,
>>>
>>> 	I have posted this message yesterday but I don't see it on the mailing=
 list.
>>> 	Sorry for the inconvenience if you see it twice...
>>>
>>> 	Today, I have tested hardware with diag-switch? and diag-level true and
>>> 	a serial console. Nothing to declare...
>>>
>>> 	Original message:
>>>
>>>     Hello,
>>>
>>>     A, U2 (2 GB, 2 UltraSPARC-II, 2 73 GB SCSI disks [raid1]) is running
>>> 	Debian/testing with 2.6.20.3 kernel. This station is used as mail serv=
er
>>> 	and I have seen some freezes. When it freezes, sysrq or stop+A do not
>>> 	work (not panic nor Oops, only freeze).
>>>
>>>     I have tested 2.6.18 (from debian), 2.6.20.x without any success.
>>> 	When I boot with root=3D/dev/sda4 instead root=3D/dev/md1, system is
>>> 	more stable (but not enough to be a mail server :-( ).
>>>
>>>     With 2.4 kernel and without raid1 (I don't understand  why I
>>> 	cannot use my raid1 volumes with 2.4 kernel...), system is
>>> 	stable and does not freeze. I have tested hardware with SUNvts
>>> 	(from Solaris 9) and it sounds good.
>>>
>>>     With the _same_ kernel, an U60-SMP is stable. The difference
>>> 	between both kernel are only Sbus versus PCI support _and_
>>> 	ESP-SCSI version Symbios support. I suspect a bug in the
>>> 	ESP-SCSI support but I don't know how investigate. I cannot
>>> 	boot any 2.6.20 with debug option du to a "address not
>>> 	aligned" message when it boots.
>>>
>>>     Any suggestion ?
>> 	I have tried the last 2.6.21-rc4. Same bug.
>>
>> 	JKB
>=20
> This is a problem with U2+kernel-2.6.x generally.  Unfortunately, I
> have no suggestions nor do I have a solution. I just grit my teeth and
> stay with the kernel-2.4.x series, which are completely stable on U2,
> so far as I can tell.

	What is your U2 configuration ? I have only one U2 and I cannot test on=20
this station because it's a mail server :-( In fact, I think it should=20
be interesting to know if this trouble come from SMP, ESP or Sbus=20
support. It is impossible to build a kernel with debug information (it=20
does not boot due to a address not aligned...), but I have tested the=20
same kernel on a U1E (with the same ESP chip and two additional=20
HappyMeal Ethernet cards on Sbus slots). It perfectly works. Can you try=20
a 2.6 on U2 without SMP support ?

	Regards,

	JKB
