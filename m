From: David Miller <davem@davemloft.net>
Date: Fri, 15 Jan 2016 20:22:53 +0000
Subject: Re: [PATCH 0/2] n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
Message-Id: <20160115.152253.1613974535141140248.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160113214318.GB32766@yogzotot>
In-Reply-To: <20160113214318.GB32766@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: matorola@gmail.com
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, herbert@gondor.apana.org.au

From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 14 Jan 2016 00:43:18 +0300

> This patch adds support for recent oracle hardware (T5/M5, T7/M7 SPARC CP=
Us),
> so n2_rng driver would work on them.
>=20
> 1. n2rng: Attach on T5/M5, T7/M7 SPARC CPUs
> 2. n2rng: documentation, add DT bindings, vendor prefixes
>=20
> PS: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=809815#32
>=20
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

This series looks fine:

Acked-by: David S. Miller <davem@davemloft.net>

Herbert, please take this via your crypto tree.

Thanks!
