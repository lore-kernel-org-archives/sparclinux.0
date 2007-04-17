From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 19:29:24 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <46252014.4030100@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 17 Apr 2007 17:28:24 +0200
>=20
>> 	Some news about this new driver on sparc32.
>> Test configuration : SS20 with dual SM71, 448 MB, VSIMM, internal raid1,=
=20
>>   ESP100A and HME-ESP (UW). All esp patches are applied against=20
>> 2.6.21-rc7 (thus with new IOMMU Sbus support).
>=20
> THe IOMMU sbus support patch only effects sparc32, so applying
> that patch for sparc32 testing will have no effect.

	I suppose that I have to read 'only effect sparc64', isn't it ?

>> 	The obtained kernel can boot with init=3D/bin/bash, but is unable to bo=
ot=20
>> with init=3D2. All ESP interfaces are shown and initialized, all disks=20
>> (two internal ID1 and 3 and CDROM ID6). When kernel starts init, I can=20
>> see on console :
>>
>> 	esp: esp0: reconnect, tag type changed 22 --> 00
>>
>> followed by a lot of insaned messages :-(
>=20
> Nevertheless I'll try to look into this.

	Thanks.

> Does the existing ESP driver work fine on this machine?

	The old one works fine.

	Regards,

	JKB
