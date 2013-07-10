From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jul 2013 20:42:16 +0000
Subject: Re: [PATCH] arch: sparc: kernel: check the memory length before use strcpy().
Message-Id: <20130710.134216.1407498845215548973.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <51C53571.9070403@asianux.com>
In-Reply-To: <51C53571.9070403@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gang.chen@asianux.com
Cc: sam@ravnborg.org, zhaohongjiang@huawei.com, gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Chen Gang <gang.chen@asianux.com>
Date: Sat, 22 Jun 2013 13:26:09 +0800

> 
> For the related next strcpy(), the destination length is less than 512,
> but the source maximize length may be 'OPROMMAXPARAM' (4096) which is
> more than 512.
> 
> One work flow may:
>   openprom_sunos_ioctl() ->  if (cmd = OPROMSETOPT)
>     getstrings() ->  will alloc buffer with size 'OPROMMAXPARAM'.
>     opromsetopt() ->  devide the buffer into 'var' and 'value'
>       of_set_property() -> pass
>         prom_setprop() -> pass
>           ldom_set_var()
> 
> And do not mind the additional 4 alignment buffer increasing, since
> 'sizeof(pkt) - sizeof(pkt.header)' is 4 alignment at least.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Applied.
