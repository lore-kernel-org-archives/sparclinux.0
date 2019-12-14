From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 14 Dec 2019 01:37:51 +0000
Subject: Re: [PATCH v2 24/24] y2038: sparc: remove use of struct timex
Message-Id: <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-15-arnd@arndb.de>
In-Reply-To: <20191213205417.3871055-15-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, sparclinux <sparclinux@vger.kernel.org>

Hi Arnd,

On Sat, Dec 14, 2019 at 7:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct timex' is one of the last users of 'struct timeval' and is
> only referenced in one place in the kernel any more, to convert the
> user space timex into the kernel-internal version on sparc64, with a
> different tv_usec member type.
>
> As a preparation for hiding the time_t definition and everything
> using that in the kernel, change the implementation once more
> to only convert the timeval member, and then enclose the
> struct definition in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sparc/kernel/sys_sparc_64.c | 29 +++++++++++++++--------------
>  include/uapi/linux/timex.h       |  2 ++
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index 9f41a6f5a032..1c85b0af4dfd 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -548,34 +548,35 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>         return err;
>  }
>
> -SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
> +SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
>  {
> -       struct timex txc;               /* Local copy of parameter */
> -       struct __kernel_timex *kt = (void *)&txc;
> +       struct __kernel_timex txc;
> +       __kernel_old_timeval *tv = (void *)&txc->time;
>         int ret;
>
>         /* Copy the user data space into the kernel copy
>          * structure. But bear in mind that the structures
>          * may change
>          */
> -       if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
> +       if (copy_from_user(&txc, txc_p, sizeof(txc)))
>                 return -EFAULT;
>
>         /*
>          * override for sparc64 specific timeval type: tv_usec
>          * is 32 bit wide instead of 64-bit in __kernel_timex
>          */
> -       kt->time.tv_usec = txc.time.tv_usec;
> +       kt->time.tv_usec = tv->tv_usec;

Am I mis-reading the patch, or is "kt" not defined?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
