From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 26 May 2006 16:22:15 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <44772B37.3070503@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> Can you guys give this patch a spin?  I think this might
> cure it.  Please be sure to add this patch to a kernel
> you know produced the symptoms before.
> 
> Thanks.
> 
> diff --git a/arch/sparc64/lib/U1memcpy.S b/arch/sparc64/lib/U1memcpy.S
> index bafd2fc..7293020 100644
> --- a/arch/sparc64/lib/U1memcpy.S
> +++ b/arch/sparc64/lib/U1memcpy.S
> @@ -97,7 +97,7 @@
>  	EX_ST(STORE_BLK(%fsrc, %dest));			\
>  	add			%dest, 0x40, %dest;	\
>  	ba,pt			%xcc, target;		\
> -	 nop;
> +	 DO_SYNC
>  
>  #define FINISH_VISCHUNK(dest, f0, f1, left)	\
>  	subcc			%left, 8, %left;\
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I test it on my E250 with debian sid and 2.6.17-rc4. With 2.6.16.16 no 
problem with status database. I switch to 2.6.17-rc4 install some 
package and DB is corrupted. Reboot to 2.6.16.16 and all works. I 
applied your patch and situation is the same as without patch still db 
corruption.


			Dan

