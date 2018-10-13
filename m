From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Sat, 13 Oct 2018 18:18:20 +0000
Subject: Re: [PATCH] sparc: vDSO: Silence an uninitialized variable warning
Message-Id: <6122ffb9-4c61-b2da-8a89-a04fc6a1ed31@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181013102653.GE16086@mwanda>
In-Reply-To: <20181013102653.GE16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On 10/13/2018 3:26 AM, Dan Carpenter wrote:
> Smatch complains that "val" would be uninitialized if kstrtoul() fails.
> 
> Fixes: 9a08862a5d2e ("vDSO for sparc")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   arch/sparc/vdso/vma.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
> index f51595f861b8..5eaff3c1aa0c 100644
> --- a/arch/sparc/vdso/vma.c
> +++ b/arch/sparc/vdso/vma.c
> @@ -262,7 +262,9 @@ static __init int vdso_setup(char *s)
>   	unsigned long val;
>   
>   	err = kstrtoul(s, 10, &val);
> +	if (err)
> +		return err;
>   	vdso_enabled = val;
> -	return err;
> +	return 0;
>   }
>   __setup("vdso=", vdso_setup);
> 

This is probably fine, but it might be cleaner as

    	err = kstrtoul(s, 10, &val);
	if (!err)
		vdso_enabled = val;
	return err;

sln
