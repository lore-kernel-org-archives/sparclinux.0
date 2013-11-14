From: David Miller <davem@davemloft.net>
Date: Thu, 14 Nov 2013 23:00:26 +0000
Subject: Re: [PATCH 2/2] sparc64: Implement HAVE_CONTEXT_TRACKING
Message-Id: <20131114.180026.2077976789068450970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <149311379160131@web12j.yandex.ru>
In-Reply-To: <149311379160131@web12j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 14 Sep 2013 16:02:11 +0400

> Mark the places when the system are in user or are in kernel.
> This is used to make full dynticks system (tickless) --
> CONFIG_NO_HZ_FULL dependence.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied, although:

> -void do_fpe_common(struct pt_regs *regs)
> +static void do_fpe_common(struct pt_regs *regs)

I had to thus remove the extern declaration of do_fpe_common from
arch/sparc/kernel/entry.h otherwise a warning is issued and the code
under arch/sparc builds -Werror and thus the build broke.
