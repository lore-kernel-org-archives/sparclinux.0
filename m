From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2020 01:29:41 +0000
Subject: Re: [PATCH][next] sparc: Use fallthrough pseudo-keyword
Message-Id: <20200721.182941.998193142437529225.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200707172436.GA27273@embeddedor>
In-Reply-To: <20200707172436.GA27273@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gustavoars@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Tue, 7 Jul 2020 12:24:36 -0500

> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=FAllthrough#implicit-switch-case-fall-through
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.
