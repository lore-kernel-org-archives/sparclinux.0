From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Thu, 08 May 2008 10:33:29 +0000
Subject: Re: [BUG] 2.6.26-rc1 hangs during boot on UltraSPARC 5
Message-Id: <4822D6F9.8090202@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <18464.3741.133714.308327@harpo.it.uu.se>	<20080506.010523.113767579.davem@davemloft.net>	<18464.46000.226753.230481@alkaid.it.uu.se> <20080506.152042.91330094.davem@davemloft.net>
In-Reply-To: <20080506.152042.91330094.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller wrote:
> From: Mikael Pettersson <mikpe@it.uu.se>
> Date: Tue, 6 May 2008 21:38:24 +0200
>=20
>> I removed "| CON_BOOT" and got what looks like the same oops
>> Ra=FAl Porcel reported earlier today (which he for some reason
>> sent only to the lists, not to you or me); his oops was:
>=20
> I can reproduce this problem here in my t1000.
>=20
> It looks like some kind of initrd regression.
>=20
> Looking at the crashes, the kernel seems to be trying
> to dereference a physical address when peeking at the
> initrd instead of using a virtual one.  That's a big
> clue.
>=20
> This patch should fix it:
>=20
> commit d45100f7b69e3d9cd0cd5e956b6ac2c78d460d07
> Author: David S. Miller <davem@davemloft.net>
> Date:   Tue May 6 15:19:54 2008 -0700
>=20
>     sparc64: Fix initrd regression.
>    =20
>     We die because we forget to convert initrd_start and
>     initrd_end to virtual addresses.
>    =20
>     Reported by Mikael Pettersson
>    =20
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
> index db8e7fb..ec3e2c7 100644
> --- a/arch/sparc64/mm/init.c
> +++ b/arch/sparc64/mm/init.c
> @@ -771,6 +771,9 @@ static void __init find_ramdisk(unsigned long phys_ba=
se)
>  		initrd_end =3D ramdisk_image + sparc_ramdisk_size;
> =20
>  		lmb_reserve(initrd_start, initrd_end);
> +
> +		initrd_start +=3D PAGE_OFFSET;
> +		initrd_end +=3D PAGE_OFFSET;
>  	}
>  #endif
>  }
>=20

That fixed it for me as well, thanks!
