From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 25 Jan 2016 16:13:57 +0000
Subject: Re: [PATCH 0/2] n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
Message-Id: <20160125161357.GC26873@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
References: <20160113214318.GB32766@yogzotot>
 <20160115.152253.1613974535141140248.davem@davemloft.net>
 <20160125144101.GC8414@gondor.apana.org.au>
In-Reply-To: <20160125144101.GC8414@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Jan 25, 2016 at 10:41:01PM +0800, Herbert Xu wrote:
> On Fri, Jan 15, 2016 at 03:22:53PM -0500, David Miller wrote:
> > From: Anatoly Pugachev <matorola@gmail.com>
> > Date: Thu, 14 Jan 2016 00:43:18 +0300
> >=20
> > > This patch adds support for recent oracle hardware (T5/M5, T7/M7 SPAR=
C CPUs),
> > > so n2_rng driver would work on them.
> > >=20
> > > 1. n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
> > > 2. n2rng: documentation, add DT bindings, vendor prefixes
> > >=20
> > > PS: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=809815#32
> > >=20
> > > Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> >=20
> > This series looks fine:
> >=20
> > Acked-by: David S. Miller <davem@davemloft.net>
> >=20
> > Herbert, please take this via your crypto tree.
>=20
> I'd love to but unfortunately the pathces are white-space damaged
> and all the tabs have turned into spaces.
>=20
> Anatoly, could you please repost with a mailer that does not eat
> tabs for lunch?

Herbert,

I've no idea what has changed tabs to spaces. Resubmitted again, should be =
in
proper format now...

Thanks.
