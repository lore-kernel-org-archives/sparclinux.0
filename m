From: David Miller <davem@davemloft.net>
Date: Mon, 19 Nov 2018 02:59:13 +0000
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Message-Id: <20181118.185913.65989390344960294.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: firoz.khan@linaro.org
Cc: sparclinux@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 14 Nov 2018 10:56:27 +0530

> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
 ...

Series applied to sparc-next.
