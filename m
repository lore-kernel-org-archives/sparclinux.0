From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 19 May 2014 08:48:39 +0000
Subject: Re: [PATCH] fix format string mismatch in arch/sparc/kernel/sysfs.c
Message-Id: <20140519084839.GA8960@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140518185256.GB6194@ravnborg.org>
In-Reply-To: <20140518185256.GB6194@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, May 19, 2014 at 10:26:31AM +0200, Toralf F=F6rster wrote:
> found by cppcheck
>=20
> Signed-off-by: Toralf F=F6rster <toralf.foerster@gmx.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  arch/sparc/kernel/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
> index a364000..7f41d40 100644
> --- a/arch/sparc/kernel/sysfs.c
> +++ b/arch/sparc/kernel/sysfs.c
> @@ -151,7 +151,7 @@ static ssize_t store_mmustat_enable(struct device *s,
>  			size_t count)
>  {
>  	unsigned long val, err;
> -	int ret =3D sscanf(buf, "%ld", &val);
> +	int ret =3D sscanf(buf, "%lu", &val);
> =20
>  	if (ret !=3D 1)
>  		return -EINVAL;
> --=20
> 1.9.3
>=20
