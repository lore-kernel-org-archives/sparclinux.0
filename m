From: Joe Perches <joe@perches.com>
Date: Sat, 30 Jan 2021 18:56:17 +0000
Subject: Re: [PATCH 04/29] sparc: Avoid comma separated statements
Message-Id: <537f6b211185eec4e511bc146d1863f448e7d6c7.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1598331148.git.joe@perches.com>
         <9dade53620b9532ff76a726320a497c67138264c.1598331148.git.joe@perches.com>
In-Reply-To: <9dade53620b9532ff76a726320a497c67138264c.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =A0arch/sparc/kernel/smp_64.c | 7 +++++--
> =A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index e286e2badc8a..28c11f7871cd 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -186,8 +186,11 @@ static inline long get_delta (long *rt, long *master)
> =A0		wmb();
> =A0		t1 =3D tick_ops->get_tick();
> =A0
>=20
> -		if (t1 - t0 < best_t1 - best_t0)
> -			best_t0 =3D t0, best_t1 =3D t1, best_tm =3D tm;
> +		if (t1 - t0 < best_t1 - best_t0) {
> +			best_t0 =3D t0;
> +			best_t1 =3D t1;
> +			best_tm =3D tm;
> +		}
> =A0	}
> =A0
>=20
> =A0	*rt =3D best_t1 - best_t0;
