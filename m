From: Aaron Scheiner <blue@aquarat.za.net>
Date: Mon, 23 Nov 2009 09:16:59 +0000
Subject: Re: Sun fire V890 UltraSparc server kernel panic, offertoassist
Message-Id: <1258967820.29183.15.camel@mail.aquarat.za.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091122220621.GA16620@orion.carnet.hr>
In-Reply-To: <20091122220621.GA16620@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I don't know who's going to do this, but if it's me does anyone have a
guide lying around ? :P

...or some useful links.

Aaron

On Sun, 2009-11-22 at 19:03 -0800, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Sun, 22 Nov 2009 23:06:21 +0100
> 
> >> [   82.663939] Kernel unaligned access at TPC[46d24c]
> >> notifier_chain_register+0x10/0x38
> >> [   82.671606] Unable to handle kernel paging request in mna handler<1>
> >> at virtual address e00000a00b000046
> 
> That address is not only unaligned, it's completely out of range
> for valid kernel virtual addresses.
> 
> notifier_chain_register() and their ilk are pretty simply and
> take constant kernel symbol addresses rather than, for example,
> dynamically allocated memory or something else more easily
> corrupted.  So this is even more mysterious.
> 
> Backtrace is:
> 
> >> [   82.759812] RPC: <atomic_notifier_chain_register+0x1c/0x44>
>  ...
> >> [   82.800022] I7: <kernel_init+0x38/0x204>
>  ...
> >> [   82.803917] Caller[0000000000782128]: kernel_init+0x38/0x204
> >> [   82.809549] Caller[0000000000426df8]: kernel_thread+0x38/0x48
> >> [   82.815268] Caller[000000000067bae0]: rest_init+0x18/0x60
> 
> And I can't see anything that registers notifiers from kernel_init().
> 
> I suspect the real caller of atomic_notifier_chain_register() is
> being optimized out by tail-call optimizations so we can't see
> exactly what it is.
> 
> Can you build a test kernel with something like the following
> patch applied and reproduce?  Thanks.
> 
> diff --git a/Makefile b/Makefile
> index aa3e13a..d953cd3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -537,6 +537,8 @@ ifndef CONFIG_CC_STACKPROTECTOR
>  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  endif
>  
> +KBUILD_CFLAGS	+= -fno-optimize-sibling-calls
> +
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else
> 
> 


