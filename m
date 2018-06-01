From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 01 Jun 2018 11:34:23 +0000
Subject: Re: [PATCH v2 21/21] sparc64: use match_string() helper
Message-Id: <CAHp75VeM8+pWEx=XNOGAb=Fdh+rh3WOn2i4m7ObhcVdcXKVa3A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.

> @@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>                                 break;
>                         }
>                 }

It seems previous loop also can be replaced.

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



-- 
With Best Regards,
Andy Shevchenko
