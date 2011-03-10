From: Bob Breuer <breuerr@mc.net>
Date: Thu, 10 Mar 2011 17:49:29 +0000
Subject: Re: sparc32 build failure in fault_32.c
Message-Id: <4D790F29.6040109@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D7410E5.3090904@mc.net>
In-Reply-To: <4D7410E5.3090904@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bob Breuer <breuerr@mc.net>
> Date: Sun, 06 Mar 2011 16:55:33 -0600
> 
>> Would it be safe enough to initialize code to SEGV_MAPERR earlier, or
>> should vmalloc_fault have a different fault code?
> 
> Yep, and that's how I'll fix this, thanks!
> 
> ---
> sparc32: Fix might-be-used-uninitialized warning in do_sparc_fault().
> 
> When we try to handle vmalloc faults, we can take a code
> path which uses "code" before we actually set it.
> 
> Amusingly gcc-3.3 notices this yet gcc-4.x does not.
> 
> Reported-by: Bob Breuer <breuerr@mc.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---

Thanks, no errors during compile.

Tested-by: Bob Breuer <breuerr@mc.net>
