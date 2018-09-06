From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 06 Sep 2018 15:32:56 +0000
Subject: Re: [PATCH 3/4] sparc: Add system call table generation support
Message-Id: <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall_32/64.tbl file which'll be the input for the
> scripts.

I would argue that for sparc we only want a single input
table, since the 32/64 versions are similar enough that the
differences can be addressed with 'abi' flag, rather than
having everything marked as 'common'. Isn't that the
purpose of the abi flag in the first place?

          Arnd
