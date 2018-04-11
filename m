From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 20:25:03 +0000
Subject: Re: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
Message-Id: <CAK8P3a3em5b2Qp_y0uHz95=JbyB7dHuPnfRNWNZ79beV6hGMyQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180411150829.3881900-1-arnd@arndb.de> <87fu41ilor.fsf@xmission.com>
In-Reply-To: <87fu41ilor.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Deepa Dinamani <deepa.kernel@gmail.com>, y2038 Mailman List <y2038@lists.linaro.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 11, 2018 at 9:32 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> We have several files on sparc that include linux/compat.h and expect
>> asm/compat.h not to be included, otherwise we get a build failure.
>
> Should this say: "We have several files on sparc that include
> linux/compat.h and expect asm/compat.h not be included when
> !CONFIG_COMPAT." ?

Correct, I'll fix it up. I'll say '32-bit builds' instead, which is what
I'm interested in. On sparc64, CONFIG_COMPAT is enabled
unconditionally, so it's really the same thing.

> I don't have your tree and I see asm/compat.h included from
> linux/compat.h already so the description above seems wrong.

I removed the tree from linux-next before the merge window because
of this build regression, if you are interested in the other changes,
please see

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-next

      Arnd
