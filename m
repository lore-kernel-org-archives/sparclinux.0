From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 19 Feb 2008 09:20:10 +0000
Subject: Re: [PATCH] ESP driver
Message-Id: <47BA9F4A.5040600@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47B9F9E1.8020007@systella.fr>
In-Reply-To: <47B9F9E1.8020007@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Mon, 18 Feb 2008 22:34:25 +0100
>=20
>> 	I think I have found a bug in esp_scsi.c. Without this patch, my=20
>> SS20/SMP was not able to rebuild its internal raid1 volume due to esp0=20
>> DMA errors. With the following patch, same workstation is building a=20
>> kernel, doing a rsync (between two local directories) and rebuilding a=20
>> 26 GB raid1 volume without any trouble.
>>
>> Signed-off-by: BERTRAND Joel <joel.bertrand@systella.fr>
>=20
> It may correct your problem for some reason, but this change
> is not correct (and your email client or your editor used
> spaces instead of tab characters in your change).  The FAS100A
> implements the ESP_STAT_INTR bit correctly.
>=20
> If the FAS100A needed this change, you would get spurious IRQs or
> other state machine errors, not DMA errors.
>=20
> I think your change merely changes timings, making the DMA problem
> harder to trigger.
>=20
> I'm sorry I don't have more desirable feedback for your patch, but
> it's the best I can do :-)

	David,

	Only one question. For you, where can I find this bug ? In arch/sparc,=20
in shared code or in ESP driver itself ?

	I have seen that DMA errors were allways followed by some ESP resets (I=20
think because I can see an AUTOSENSE command on console) but this ESP=20
reset command aborts or does not avoid ESP_STAT_INTR flag in esp->sreg.=20
Why not reset command does not clear this flag ? I'm not sure that it's=20
a mistake, but I don't understand why this flag remains set.

	You said that my patch makes problem harder to trigger. Maybe, but I'm=20
pretty sure than this bug is close from this ESP_STAT_INTR flag that is=20
not cleared for some reasons on SS20. I have tested my quick and dirty=20
patch all night with 6 disks (two internal, four external and a CDROM=20
reader). Configuration :

/dev/sda1 + /dev/sdb1 =3D> /boot
/dev/sda2 + /dev/sdb2 =3D> swap
/dev/sda4 + /dev/sdb4 =3D> /
/dev/sda8 + /dev/sdb8 =3D> /opt
/dev/sdc1 + /dev/sdd1 + /dev/sde1 + /dev/sdf1 =3D> /export/home (raid5)

and I have stressed ESP chip without any trouble.

	Regards,

	JKB
