From: "Zi Yan" <zi.yan@cs.rutgers.edu>
Date: Thu, 10 Aug 2017 14:46:08 +0000
Subject: Re: [PATCH] mm: add pmd_t initializer __pmd() to work around a GCC bug.
Message-Id: <3DDB3EDA-D008-45C1-A5A9-A92DF74DFB5E@cs.rutgers.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_MailMate_231E0106-56D2-4C20-8AC3-CEB79C2FD081_="
List-Id: <sparclinux.vger.kernel.org>
References: <20170803131721.74011-1-zi.yan@sent.com>
In-Reply-To: <20170803131721.74011-1-zi.yan@sent.com>
To: Sam Ravnborg <sam@ravnborg.org>, "David S . Miller" <davem@davemloft.net>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_231E0106-56D2-4C20-8AC3-CEB79C2FD081_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ping. Just wonder what is the status of this patch.

This patch is trivial and I successfully compiled it for sparc32.
swp_entry_to_pmd() will be the only user of __pmd() in sparc32,
returning __pmd(0). Having __pmd() can help replace following
code in include/linux/swapops.h (in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
include/linux/swapops.h#n224):

static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
{
	pmd_t e;
	memset(&e, 0, sizeof(pmd_t));
	return e;
}

with:

static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
{
	return __pmd(0);
}

It makes the code more portable.

Thanks.

--
Best Regards
Yan Zi

On 3 Aug 2017, at 9:17, Zi Yan wrote:

> From: Zi Yan <zi.yan@cs.rutgers.edu>
>
> THP migration is added but only supports x86_64 at the moment. For all
> other architectures, swp_entry_to_pmd() only returns a zero pmd_t.
>
> Due to a GCC zero initializer bug #53119, the standard (pmd_t){0}
> initializer is not accepted by all GCC versions. __pmd() is a feasible
> workaround. In addition, sparc32's pmd_t is an array instead of a singl=
e
> value, so we need (pmd_t){ {0}, } instead of (pmd_t){0}. Thus,
> a different __pmd() definition is needed in sparc32.
>
> Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
> ---
>  arch/sparc/include/asm/page_32.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/=
page_32.h
> index 0efd0583a8c9..6249214148c2 100644
> --- a/arch/sparc/include/asm/page_32.h
> +++ b/arch/sparc/include/asm/page_32.h
> @@ -68,6 +68,7 @@ typedef struct { unsigned long iopgprot; } iopgprot_t=
;
>  #define iopgprot_val(x)	((x).iopgprot)
>
>  #define __pte(x)	((pte_t) { (x) } )
> +#define __pmd(x)	((pmd_t) { { (x) }, })
>  #define __iopte(x)	((iopte_t) { (x) } )
>  #define __pgd(x)	((pgd_t) { (x) } )
>  #define __ctxd(x)	((ctxd_t) { (x) } )
> @@ -95,6 +96,7 @@ typedef unsigned long iopgprot_t;
>  #define iopgprot_val(x)	(x)
>
>  #define __pte(x)	(x)
> +#define __pmd(x)	((pmd_t) { { (x) }, })
>  #define __iopte(x)	(x)
>  #define __pgd(x)	(x)
>  #define __ctxd(x)	(x)
> -- =

> 2.13.2

--=_MailMate_231E0106-56D2-4C20-8AC3-CEB79C2FD081_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJZjHGxAAoJEEGLLxGcTqbMEK0IAIeZtAfDX9+lFu6SjAtW6Ito
Mut52feYlCdRYZcPEx579uCDQnofMtvH9Nc1UJs5vkeDMcetS7Qkmxf++IsiHnvW
jMe7Gp++SURBbKmHvNUUeMo9U4wUsmIRMJGcNfyM/tBjdTi+i18w4Cls5N6gMD43
hTR8ip8UgLqGySwifliDt5xgxsxfjI5LQJRHuvUmOMpURlnBPAVJDferCUDBXlZE
RKNtV992F5JPppuklA7lSjfFU2/Qx4QXrGgggE0bRDm12IPb+vCYm6XFR7rog4hP
crD8contmnnwQmxv+vkdrIH5fbNdbuWyf2zRdfS3Sr0agARgF1EcumLCTnEKG2c=
=26bw
-----END PGP SIGNATURE-----

--=_MailMate_231E0106-56D2-4C20-8AC3-CEB79C2FD081_=--
