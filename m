From: Ilya Malakhov <ilmalakhovthefirst@gmail.com>
Date: Wed, 17 Feb 2016 21:16:34 +0000
Subject: Re: Invalid SIGSEGV from sparc64_set_context ()
Message-Id: <CAK1sNPBaY+Zmn6=m79x=NH8Q433LV4xYq7JRjwsSXLqV_9FfmQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK1sNPDEk0x4mdOfma97EyAkiBAuKc10dC-hhqb3XWSkWw=SZw@mail.gmail.com>
In-Reply-To: <CAK1sNPDEk0x4mdOfma97EyAkiBAuKc10dC-hhqb3XWSkWw=SZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 17, 2016 at 11:51 PM, David Miller <davem@davemloft.net> wrote:
. . .
> Does the obvious patch below fix the problem for you?
>
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index d88beff4..39aaec1 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -52,7 +52,7 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
>         unsigned char fenab;
>         int err;
>
> -       flush_user_windows();
> +       synchronize_user_stack();
>         if (get_thread_wsaved()                                 ||
>             (((unsigned long)ucp) & (sizeof(unsigned long)-1))  ||
>             (!__access_ok(ucp, sizeof(*ucp))))
. . .

 It does.
