From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 15 May 2012 05:16:34 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <CAGRGNgV7PUmaFcrO3g60xUYOfz49XcfQFopRU=bvkDc7B7eg9A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi David,

On Tue, May 15, 2012 at 3:09 PM, David Miller <davem@davemloft.net> wrote:
>
> It's the one aberration in v8, the only cpu that
> didn't actually have hardware multiply and divide
> instructions.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>
> I'm tempted to push this.

I would be too.

I was thinking of adding a Kconfig variable for Cypress CPU support
since it's status first came up and linking this to the CFLAGS so that
we would only generate v7 code if it's enabled, but I haven't had the
time.

But I suppose that if nobody we know has one, why keep it?

> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 765b1a5..4875fcd 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -1912,22 +1590,15 @@ static void __init get_srmmu_type(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Uniprocessor Cypress */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_cypress_604();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 10:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 11:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 12:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* _REALLY OLD_ Cypress MP =
chips... */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 13:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 14:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 15:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MP Cypress mmu/cache-con=
troller */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_cypress_605(mod_rev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Some other Cypress revis=
ion, assume a 605. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_cypress_605(mod_rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_printf("Sparc-Linux Cy=
press support does not longer exit.\n");

*exists

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
