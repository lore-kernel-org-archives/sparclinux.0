From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2016 18:58:30 +0000
Subject: Re: [PATCH 21/23] sparc: remove ARCH_WANT_OPTIONAL_GPIOLIB
Message-Id: <20160421.145830.1101835916715485213.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
	<1461142701-21096-22-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1461142701-21096-22-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, acourbot@nvidia.com, m@bues.ch, sparclinux@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Apr 2016 10:58:19 +0200

> This symbols is not needed to get access to selecting the
> GPIOLIB anymore: any arch can select GPIOLIB.
>=20
> Cc: Michael B=FCsch <m@bues.ch>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
