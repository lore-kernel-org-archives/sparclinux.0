From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 18 Dec 2007 09:47:58 +0000
Subject: Re: [sparc64] 2.6.23.x kernel and udev on U2E
Message-Id: <4767974E.50700@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <476785EA.8030906@systella.fr>
In-Reply-To: <476785EA.8030906@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 18 Dec 2007 09:33:46 +0100
>=20
>> If I restart udev, it is restarted without any timeout. I don't=20
>> understand where is the mistake (PCI support ?). It seems to be a bad=20
>> interaction between udev and kernel but I don't know the last=20
>> configuration where kernel and udev work fine together. I have trie to=20
>> find an old configuration that boots without this timeout without any=20
>> success. I don't understand why with exactly the same .config I cannot=20
>> see the same trouble on my U60.
>=20
> Probably something unique about the ESP scsi driver, although
> I have no idea what that might be.

	Maybe, but I'm not sure because I have used some kernels with your new=20
ESP driver (2.0) and without this trouble.

	Regards,

	JKB
