From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 27 Jun 2019 00:01:14 +0000
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190627100114.3eda815f@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/TmVpELSjnXhVlpZ+rR=WhJA"
List-Id: <sparclinux.vger.kernel.org>
References: <20190626225807.205f1382@canb.auug.org.au>
        <20190626131318.GA5101@lst.de>
In-Reply-To: <20190626131318.GA5101@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 26 Jun 2019 15:13:18 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> As that function is in code only there to provide compile coverage
> something like this should fix the problem:
>=20
>=20
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index 547ff96fb228..1599de730532 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -861,10 +861,12 @@ static inline unsigned long pud_page_vaddr(pud_t pu=
d)
>  #define pud_clear(pudp)			(pud_val(*(pudp)) =3D 0UL)
>  #define pgd_page_vaddr(pgd)		\
>  	((unsigned long) __va(pgd_val(pgd)))
> -#define pgd_page(pgd)			pfn_to_page(pgd_pfn(pgd))
>  #define pgd_present(pgd)		(pgd_val(pgd) !=3D 0U)
>  #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) =3D 0UL)
> =20
> +/* only used by the stubbed out hugetlb gup code, should never be called=
 */
> +#define pgd_page(pgd)			NULL
> +
>  static inline unsigned long pud_large(pud_t pud)
>  {
>  	pte_t pte =3D __pte(pud_val(pud));

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UB0oACgkQAVBC80lX
0GxIZwgAhEu9RAp1zw7pbbiYTJSgyEfJ+NiUbwBPJBdW898jCXDYggkQdOge4hID
9ycFIIX9NcWqFPEp4aZIs7WoAh+d6IhOR4AEd61u0x2l9r4JsydkQ95K0EruOQtQ
VexF4aPCCNbFwOxRADrkHZ/ZOQIUZ/9MQCCLg1Zm3kJXITjsnm7TqSFfGJXsR1+V
w+ekwkxnB0EYzJPhk/1mZRoXvijX+9cOdLX+G4orCEqPCLFl4/y1Z2Cse8CmAnzS
ArQsJI3xn7BUUHdXMeE3o5kJWeAa53pgC0rwTxbnysGtXq5uJmyGb6mRnkKOf+tk
3MM/gznYCyCM66+sWmjLLu4xb8cN2g==
=ERSj
-----END PGP SIGNATURE-----

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA--
