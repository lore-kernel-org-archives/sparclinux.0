From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 11 Apr 2018 19:32:04 +0000
Subject: Re: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
Message-Id: <87fu41ilor.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180411150829.3881900-1-arnd@arndb.de>
In-Reply-To: <20180411150829.3881900-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 11 Apr 2018 17:07:58 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Deepa Dinamani <deepa.kernel@gmail.com>, y2038@lists.linaro.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> We have several files on sparc that include linux/compat.h and expect
> asm/compat.h not to be included, otherwise we get a build failure.

Should this say: "We have several files on sparc that include
linux/compat.h and expect asm/compat.h not be included when
!CONFIG_COMPAT." ?

I don't have your tree and I see asm/compat.h included from
linux/compat.h already so the description above seems wrong.

Eric
