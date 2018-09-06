From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 06 Sep 2018 15:29:39 +0000
Subject: Re: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
Message-Id: <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

>
> -#define NR_syscalls            361
> +#define __NR_syscalls          361

What about the suggestion that was made earlier to enclose this in
#ifdef __KERNEL__?

     Arnd
