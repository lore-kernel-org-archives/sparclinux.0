From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 06 Jun 2018 05:01:50 +0000
Subject: Re: [PATCH v3 21/21] sparc64: use match_string() helper
Message-Id: <CAHp75VdvpxZCuGmFV0r9nUdO1u7=eurDFZur7Q=ZO0kMC6D0rw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com> <80339b72-902f-a74e-6ad2-28744c7760cb@huawei.com>
In-Reply-To: <80339b72-902f-a74e-6ad2-28744c7760cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>

On Wed, Jun 6, 2018 at 5:19 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>

Thanks for an update.
My comments below.

I think you need to mentioned the string literal change in the commit message.

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v3:
>  - add string literal instead of NULL for array hwcaps to make it
>    can use match_string() too.  - per Andy
> v2
>  - new add for use match_string() helper patchset.
>
>  arch/sparc/kernel/setup_64.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 7944b3c..4f0ec0c 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -401,7 +401,7 @@ void __init start_early_boot(void)
>          */
>         "mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
>         "ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
> -       "ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
> +       "ima", "cspare", "pause", "cbcond", "resv" /*reserved for crypto */,
>         "adp",

Why not to spell "crypto" explicitly and remove comment?

>  };
>
> @@ -418,7 +418,7 @@ void cpucap_info(struct seq_file *m)
>         seq_puts(m, "cpucaps\t\t: ");
>         for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
>                 unsigned long bit = 1UL << i;
> -               if (hwcaps[i] && (caps & bit)) {
> +               if (bit != HWCAP_SPARC_CRYPTO && (caps & bit)) {

I would rather swap the order of subsonditions to check if caps has a
bit first, and then exclude CRYPTO.

>                         seq_printf(m, "%s%s",
>                                    printed ? "," : "", hwcaps[i]);
>                         printed++;
> @@ -472,7 +472,7 @@ static void __init report_hwcaps(unsigned long caps)
>
>         for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
>                 unsigned long bit = 1UL << i;
> -               if (hwcaps[i] && (caps & bit))
> +               if (bit != HWCAP_SPARC_CRYPTO && (caps & bit))
>                         report_one_hwcap(&printed, hwcaps[i]);

Ditto.

>         }
>         if (caps & HWCAP_SPARC_CRYPTO)
> @@ -504,18 +504,13 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>         while (len) {
>                 int i, plen;
>
> -               for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
> -                       unsigned long bit = 1UL << i;
> +               i = match_string(hwcaps, ARRAY_SIZE(hwcaps), prop);
> +               if (i >= 0)
> +                       caps |= (1UL << i);

Parens are redundant (and actually didn't present in the original code above).

>
> -                       if (hwcaps[i] && !strcmp(prop, hwcaps[i])) {
> -                               caps |= bit;
> -                               break;
> -                       }
> -               }
> -               for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
> -                       if (!strcmp(prop, crypto_hwcaps[i]))
> -                               caps |= HWCAP_SPARC_CRYPTO;
> -               }
> +               i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
> +               if (i >= 0)
> +                       caps |= HWCAP_SPARC_CRYPTO;
>
>                 plen = strlen(prop) + 1;
>                 prop += plen;
> --
> 1.7.12.4
>
>
>



-- 
With Best Regards,
Andy Shevchenko
