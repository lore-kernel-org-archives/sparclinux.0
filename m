From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 25 Jan 2016 14:41:01 +0000
Subject: Re: [PATCH 0/2] n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
Message-Id: <20160125144101.GC8414@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20160113214318.GB32766@yogzotot>
 <20160115.152253.1613974535141140248.davem@davemloft.net>
In-Reply-To: <20160115.152253.1613974535141140248.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: matorola@gmail.com, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Jan 15, 2016 at 03:22:53PM -0500, David Miller wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Thu, 14 Jan 2016 00:43:18 +0300
>=20
> > This patch adds support for recent oracle hardware (T5/M5, T7/M7 SPARC =
CPUs),
> > so n2_rng driver would work on them.
> >=20
> > 1. n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
> > 2. n2rng: documentation, add DT bindings, vendor prefixes
> >=20
> > PS: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=809815#32
> >=20
> > Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
>=20
> This series looks fine:
>=20
> Acked-by: David S. Miller <davem@davemloft.net>
>=20
> Herbert, please take this via your crypto tree.

I'd love to but unfortunately the pathces are white-space damaged
and all the tabs have turned into spaces.

Anatoly, could you please repost with a mailer that does not eat
tabs for lunch?

Thanks!
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
