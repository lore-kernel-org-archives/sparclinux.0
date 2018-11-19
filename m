From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 19 Nov 2018 05:34:16 +0000
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Message-Id: <CALxhOni2YmDX3zYx5a_MWvkfJic+UuMmZBV7sgppkXO5pZB_vw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <20181118.185913.65989390344960294.davem@davemloft.net>
In-Reply-To: <20181118.185913.65989390344960294.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Hi David,

On Mon, 19 Nov 2018 at 08:29, David Miller <davem@davemloft.net> wrote:
>
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Wed, 14 Nov 2018 10:56:27 +0530
>
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>  ...
>
> Series applied to sparc-next.

Sounds good. Thanks

Firoz
