From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jul 2006 03:43:11 +0000
Subject: Re: [PATCH 2.6.17 sparc64] fix stack overflow checking in modular
Message-Id: <20060705.204311.78725710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607042010.k64KABmC011107@harpo.it.uu.se>
In-Reply-To: <200607042010.k64KABmC011107@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 4 Jul 2006 22:10:11 +0200 (MEST)

> The sparc64 kernel's EXPORT_SYMBOL(_mcount) is inside an
> #ifdef CONFIG_SMP. This breaks modules in non-SMP kernels
> built with stack overflow checking (CONFIG_STACK_DEBUG=y),
> as modules_install reports:
> 
> WARNING: /lib/modules/2.6.17/kernel/drivers/ide/ide-cd.ko needs unknown symbol _mcount
> 
> Trivially fixed by moving EXPORT_SYMBOL(_mcount) outside of
> the #ifdef CONFIG_SMP.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied, thanks Mikael.
