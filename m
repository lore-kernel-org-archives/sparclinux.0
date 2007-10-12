From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 08:52:31 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <470F35CF.6030904@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 12 Oct 2007 09:04:16 +0200
>=20
>> 	I have rebuild a 2.6.23 kernel with gcc-4.1. When I try to format=20
>> (ext3fs) a raid5 volume, I _allways_ obtain (I have tested four times):
>=20
> That's a different bug which I will try to look into.

	This bug is very strange. I have done a mkfs on a raid6 (3 GB) wihtout=20
any trouble, but on a raid5 (1,5 GB), it allways crash at the same=20
inode. Same constatation on my second T1000, thus, it is not an hardware=20
problem ;-)

> At least confirm that the other problem no longer occurs
> as that's all I'm interested in at this point.

	I don't see the last one.

	Regards,

	JKB
