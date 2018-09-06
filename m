From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 06 Sep 2018 15:34:11 +0000
Subject: Re: [PATCH 4/4] sparc: uapi header and system call table file generation
Message-Id: <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-5-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to generate
> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32/64.h and syscall_table_
> 32/64/c32.h files by the syscall table generation script
> invoked by arch/sparc/Makefile and the generated files against
> the removed files will be identical.
>
> The generated uapi header file will be included in uapi/asm/
> unistd_32/64.h and generated system call table support file will
> be included by arch/sparc/kernel/syscall_table_32/64.S file.

These changes all look good to me.

       Arnd
