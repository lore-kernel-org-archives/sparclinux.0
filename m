From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 04 Aug 2017 05:44:48 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170804054448.GA31513@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170801205829.GA7496@ravnborg.org>
 <20170802213647.GA5506@ravnborg.org>
 <22915.33137.173101.458489@gargle.gargle.HOWL>
 <20170803.145748.1255019771865320896.davem@davemloft.net>
In-Reply-To: <20170803.145748.1255019771865320896.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpelinux@gmail.com, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Davem.

On Thu, Aug 03, 2017 at 02:57:48PM -0700, David Miller wrote:
> From: Mikael Pettersson <mikpelinux@gmail.com>
> Date: Thu, 3 Aug 2017 22:02:57 +0200
> 
> > With that in place the kernel booted fine.
> > When I then ran the `poll' strace test binary, the OOPS was replaced by:
> > 
> > [  140.589913] _copy_from_user(fff000123c8dfa7c,           (null), 240) res 240
> > [  140.753162] _copy_from_user(fff000123c8dfa7c, 00000000f7e4a000, 8) res 8
> > [  140.824155] _copy_from_user(fff000123c8dfa7c, 00000000f7e49ff8, 16) res 18442240552407530112
> > 
> > That last `res' doesn't look good.
> 
> Please test this patch:
> 
> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 54f9870..5a8cb37 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -145,13 +145,13 @@ ENDPROC(U3_retl_o2_plus_GS_plus_0x08)
>  ENTRY(U3_retl_o2_and_7_plus_GS)
>  	and	%o2, 7, %o2
>  	retl
> -	 add	%o2, GLOBAL_SPARE, %o2
> +	 add	%o2, GLOBAL_SPARE, %o0
>  ENDPROC(U3_retl_o2_and_7_plus_GS)
>  ENTRY(U3_retl_o2_and_7_plus_GS_plus_8)
>  	add	GLOBAL_SPARE, 8, GLOBAL_SPARE
>  	and	%o2, 7, %o2
>  	retl
> -	 add	%o2, GLOBAL_SPARE, %o2
> +	 add	%o2, GLOBAL_SPARE, %o0
>  ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
>  #endif
>  
Patch looks obviously correct, and I am a bit irritated that
I did not see this myself.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I will send another patch that fixes/adds a few comments to the same file.

	Sam

