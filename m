From: David Miller <davem@davemloft.net>
Date: Tue, 26 Feb 2019 00:23:00 +0000
Subject: Re: [PATCH 0/3] sparc: Unify the system call scripts
Message-Id: <20190225.162300.209654917842732349.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: firoz.khan@linaro.org
Cc: kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, viro@zeniv.linux.org.uk, pombredanne@nexb.com, sparclinux@vger.kernel.org, tglx@linutronix.de, deepa.kernel@gmail.com

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed,  2 Jan 2019 21:22:50 +0530

> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures. In order to reduce the source code across all
> the above architectures, create common ".sh" files and
> keep it in the common directory, script/. This will 
> be a generic scripts which can use for all the above
> architectures.
> 
> This patch depends on;
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Can you please merge this series in with that dependency
then?

Acked-by: David S. Miller <davem@davemloft.net>
