From: LEROY Christophe <christophe.leroy@c-s.fr>
Date: Fri, 04 Jan 2019 17:36:59 +0000
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
Message-Id: <20190104183659.Horde.Xco_Q-bqCSSJoWwerf1bVw4@messagerie.si.c-s.fr>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org, Mathieu Malaterre <malat@debian.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") an attempt was made to remove a warning by referencing the
> variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
> from access_ok() function") the variable `type` has been removed.
>
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:
>
>   arch/powerpc/include/asm/uaccess.h:66:32: error: ‘type’ undeclared  
> (first use in this function)
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Should you add a Fixes:  96d4f267e40f ?

Note that sparc arch will have the same issue.

Christophe

> ---
>  arch/powerpc/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h  
> b/arch/powerpc/include/asm/uaccess.h
> index b31bf45eebd4..5f0c98e511a0 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr,  
> unsigned long size,
>  #endif
>
>  #define access_ok(addr, size)		\
> -	(__chk_user_ptr(addr), (void)(type),		\
> +	(__chk_user_ptr(addr),			\
>  	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
>
>  /*
> --
> 2.19.2
