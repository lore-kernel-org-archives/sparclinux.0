Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760DC433DB
	for <sparclinux@archiver.kernel.org>; Thu, 25 Mar 2021 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0951761A07
	for <sparclinux@archiver.kernel.org>; Thu, 25 Mar 2021 21:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCYVRf (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:17:35 -0400
Received: from ozlabs.org ([203.11.71.1]:49711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhCYVR3 (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Thu, 25 Mar 2021 17:17:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F5yc63mxdz9sW4;
        Fri, 26 Mar 2021 08:17:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1616707047;
        bh=dhfvS/uOptO8OnDW7zd6CHqtm7WyNgPtyUehiL052OE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DEkcP/T4V3zP2eIfRf5IMkyTIYu2otgRGenhAEfa5S9U6hCW6LEH8YQ9wEPOo0wv4
         qmjZkNawr49gd5BKgZzTmXf30O4prY8JJx9xaJeq9ouYhp3OjZO837GaCxoS6FURHL
         QjGECzNlUIUWk0YCoWUf068PdwKwPn+cF4DXsGp0X8pLd0+VV5ZoqBfYK3iosoWrXE
         SygNYD2cc07VtF5BvNFIHwFxxp66MQmM5dEHaJjhLjROfp/l9l/vNehslMMqT8HMM8
         XO2RfA8hiG527CSMGJup1oKBzzhI1R8JRu9t51cf46V8eyqzrcdSbWH2m9xNXt1mf4
         8fsHeC1CBn5+A==
Date:   Fri, 26 Mar 2021 08:17:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sparc32: add stub pud_page define for walking huge
 vmalloc page tables
Message-ID: <20210326081725.01d50c91@canb.auug.org.au>
In-Reply-To: <20210324232825.1157363-1-npiggin@gmail.com>
References: <20210324232825.1157363-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+wqcNpk1E+aQ.Ka6LXXwCn6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--Sig_/+wqcNpk1E+aQ.Ka6LXXwCn6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 25 Mar 2021 09:28:25 +1000 Nicholas Piggin <npiggin@gmail.com> wrot=
e:
>
> Similarly to the stub p4d_page in sparc64, add a stub pud_page, this
> is needed for hugepages in the vmap page tables to be walked without
> ifdefs, which should be no functional change for sparc32.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>=20
> This should go in Andrew's mm tree which has a compile error on sparc32
> introduced by the huge vmalloc pages, noticed by Stephen.
>=20
> Thanks,
> Nick
>=20
>  arch/sparc/include/asm/pgtable_32.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm=
/pgtable_32.h
> index 632cdb959542..a5cf79c149fe 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -321,6 +321,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t ne=
wprot)
>  		pgprot_val(newprot));
>  }
> =20
> +/* only used by the huge vmap code, should never be called */
> +#define pud_page(pud)			NULL
> +
>  struct seq_file;
>  void mmu_info(struct seq_file *m);
> =20
> --=20
> 2.23.0
>=20

I have used this instead of my hack fix in linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+wqcNpk1E+aQ.Ka6LXXwCn6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmBc/eUACgkQAVBC80lX
0GzTqAf+MovxlYs/Vt4PhG8PoFMaH0d4z0kQEAe2HQ85uzSZnX44WtRLg6HUQ89n
daAEm9LnFDUFjRxX36DQcR3U+ITPU+iNqe9nR5SdDkMb/Vp8WobBjloSoqpS9BqX
+P2IGB6g5+4TTckSwW2sFSBsjFlaMbWEEwalFXAN87VPetTotq2627GnCbj4MjP0
Q0oDjHQQCaKmoKK+tF4gKJUVMTvBEhM26Irt1UH7xi2pXHwvAvqPhjX4QnONb9bq
SOcvIMEyTLLX9qWEZ5TTe6tSM86KK9qVhY8BRxrUC8dzD9QWLd/+bGTy8mxSsH2z
bPAUTdxNDz1pa+IkTZ5msEnRjWeN7w==
=N+M2
-----END PGP SIGNATURE-----

--Sig_/+wqcNpk1E+aQ.Ka6LXXwCn6--
