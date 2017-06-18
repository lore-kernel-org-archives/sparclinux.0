From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 18 Jun 2017 09:22:58 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170618092258.GA20211@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
 <20170531.171008.528800003662477033.davem@davemloft.net>
In-Reply-To: <20170531.171008.528800003662477033.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm=
/pgtable_32.h
> index ce6f569..cf19072 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -91,9 +91,9 @@ extern unsigned long pfn_base;
>   * ZERO_PAGE is a global shared page that is always zero: used
>   * for zero-mapped memory areas etc..
>   */
> -extern unsigned long empty_zero_page;
> +extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];

Would it make sense to make empty_zero_page array of bytes? There's
nothing fundamentally structured in it...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllGRnIACgkQMOfwapXb+vJmGACgwlHJFk4iSvjinL5JuP5vQVEW
EQkAn2JTx0wfmnmjJnmHlvixW3gntEl6
=Bfm5
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
