From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Apr 2016 12:07:02 +0000
Subject: Re: [PATCH 21/23] sparc: remove ARCH_WANT_OPTIONAL_GPIOLIB
Message-Id: <CACRpkdbZngH3QgXO0CZ3+qw4oSzkuoAj0CaoiW_jj5OssgLp=Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
	<1461142701-21096-22-git-send-email-linus.walleij@linaro.org>
	<20160421.145830.1101835916715485213.davem@davemloft.net>
In-Reply-To: <20160421.145830.1101835916715485213.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Buesch <m@bues.ch>, sparclinux@vger.kernel.org

On Thu, Apr 21, 2016 at 8:58 PM, David Miller <davem@davemloft.net> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Wed, 20 Apr 2016 10:58:19 +0200
>
>> This symbols is not needed to get access to selecting the
>> GPIOLIB anymore: any arch can select GPIOLIB.
>>
>> Cc: Michael B=C3=BCsch <m@bues.ch>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Acked-by: David S. Miller <davem@davemloft.net>

Patch applied to the GPIO tree with your ACK.

Yours,
Linus Walleij
