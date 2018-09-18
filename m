From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 09:57:18 +0000
Subject: Re: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
Message-Id: <CALxhOngq7kjFTA=oQBzV5fEtdtCq6ytb8excP76Gshikq3Q-4A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On 6 September 2018 at 20:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>>
>> -#define NR_syscalls            361
>> +#define __NR_syscalls          361
>
> What about the suggestion that was made earlier to enclose this in
> #ifdef __KERNEL__?

The issue, keeping __NR_syscalls in uapi header was pointed out by
Michal Simek (microblaze) and Geert Uytterhoeven (m68k). I replied
them with this suggestion (enclose with #ifdef __KERNEL__). Once
they agree, my next version of patch series will have this change.

- Firoz
