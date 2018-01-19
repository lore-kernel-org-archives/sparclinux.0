From: nagarathnam muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Fri, 19 Jan 2018 18:09:44 +0000
Subject: Re: [PATCH spark] sparc: vDSO: remove an extra tab
Message-Id: <5A623468.6030906@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180119132321.GA32694@mwanda>
In-Reply-To: <20180119132321.GA32694@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org


On 1/19/2018 5:23 AM, Dan Carpenter wrote:
> This statement is indented one tab too far which is confusing and
> leads to a Smatch warning:
>
>      arch/sparc/vdso/vma.c:254 arch_setup_additional_pages()
>      warn: curly braces intended?
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
> index 0a6f50098e23..f51595f861b8 100644
> --- a/arch/sparc/vdso/vma.c
> +++ b/arch/sparc/vdso/vma.c
> @@ -251,7 +251,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>   	else
>   		return map_vdso(&vdso_image_32_builtin, &vdso_mapping32);
>   #else
> -		return map_vdso(&vdso_image_64_builtin, &vdso_mapping64);
> +	return map_vdso(&vdso_image_64_builtin, &vdso_mapping64);
>   #endif
>   
>   }
Should the subject be sparc instead of spark? Other than that,

Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>

Thanks!


