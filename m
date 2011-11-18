From: Lukas Razik <linux@razik.name>
Date: Fri, 18 Nov 2011 17:42:30 +0000
Subject: Re: [BUG] Bad page map in process ibv_devinfo
Message-Id: <1321638150.65099.YahooMailNeo@web24701.mail.ird.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20111117.212847.1778246801048496855.davem@davemloft.net> <1321592577.354.YahooMailNeo@web24712.mail.ird.yahoo.com> <20111118.011708.677233058349078554.davem@davemloft.net> <20111118.015519.1069441245022002863.davem@davemloft.net>
In-Reply-To: <20111118.015519.1069441245022002863.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: "roland@purestorage.com" <roland@purestorage.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>

----- Urspr=FCngliche Message -----

> Von: David Miller <davem@davemloft.net>
> An: linux@razik.name
> Cc: roland@purestorage.com; sparclinux@vger.kernel.org; linux-rdma@vger.k=
ernel.org
> Gesendet: 7:55 Freitag, 18.November 2011
> Betreff: Re: [BUG] Bad page map in process ibv_devinfo
>=20
> From: David Miller <davem@davemloft.net>
> Date: Fri, 18 Nov 2011 01:17:08 -0500 (EST)
>=20
>>  That explains everything.=A0 The problem is that we don't do the sparc64
>>  PTE handling code patching in modules.=A0 So it's left at the default 4U
>>  versions.
> ...
>>  I'll work on a fix for this.
>=20
> Ok, please test this out, thanks!
>=20
> --------------------
> [PATCH] sparc64: Patch sun4v code sequences properly on module load.
>=20
> Some of the sun4v code patching occurs in inline functions visible
> to, and usable by, modules.
>=20
> Therefore we have to patch them up during module load.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> arch/sparc/kernel/entry.h=A0 =A0 |=A0 =A0 7 ++++++
> arch/sparc/kernel/module.c=A0  |=A0  27 +++++++++++++++++++++++
> arch/sparc/kernel/setup_64.c |=A0  48 +++++++++++++++++++++++++----------=
------
> 3 files changed, 63 insertions(+), 19 deletions(-)
>=20

Hi David,

I could apply also your second patch to linux-2.6.39.4 manually. So you don=
't need to write another version.
Now I'll try to test it with the new OFED drivers...

Regards,
Lukas
