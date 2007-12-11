From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 11 Dec 2007 01:25:52 +0000
Subject: Re: [BUG] Kernel unaligned access - tcp_transmit_skb
Message-Id: <20071211012552.GB8460@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <c75cfb180712101406q64d8d242n9eb13aaf7c373eb7@mail.gmail.com>
In-Reply-To: <c75cfb180712101406q64d8d242n9eb13aaf7c373eb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Dec 10, 2007 at 04:18:12PM -0800, David Miller wrote:
>
> > A 2.6.23.3 kernel with only this additional patch (from 2.6.23.4)
> > 'TCP: Fix size calculation in sk_stream_alloc_pskb'
> > http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.23.y.git;a=
=3Dcommit;h=9Fcba4716e6ebbb0d7e0ec84bff6dd2c36c847b3
> > has the bug too.
>=20
> That patch ought to have fixed it.
>=20
> Herbert, any ideas?

Hmm, he's missing this patch which isn't in stable yet.  I sent
it to stable on the 29th of November after Linus returned.

commit 21df56c6e2372e09c916111efb6c14c372a5ab2e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Nov 18 18:48:08 2007 -0800

    [TCP]: Fix TCP header misalignment

Cheers,
--=20
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
