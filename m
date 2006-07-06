From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 06 Jul 2006 19:35:43 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <44AD660F.1010209@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mikael Pettersson napsal(a):
> On Thu, 06 Jul 2006 09:01:04 +0800, Antonino A. Daplas wrote:
> 
>>Mikael Pettersson wrote:
>>
>>>To: davem@davemloft.net
>>>Subject: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
>>>Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
>>>
>>>In recent sparc64 kernels, starting a 32-bit mode X server on
>>>a machine with a Mach64 framebuffer (CONFIG_FB_ATY_CT=y) like
>>>an Ultra5, results in the kernel complaining:
>>>
>>>ioctl32(X:1977): Unknown cmd fd(6) cmd(40584606){00} arg(ef8dd6d8) on /dev/fb0
>>>ioctl32(X:1977): Unknown cmd fd(6) cmd(40184600){00} arg(ef8dd6e0) on /dev/fb0
>>>
>>>That's FBIOGTYPE and FBIOGATTR. These errors occur because
>>>kernel 2.6.15-rc2 changed the way sparc64 handles SPARC-specific
>>>framebuffer ioctls from 32-bit processes: before 2.6.15-rc2
>>>arch/sparc64/kernel/ioctl32.c handled them for all devices,
>>>but 2.6.15-rc2 dropped that support and changed SPARC-only
>>>framebuffer drivers like ffb.c to set up ->compat_ioctl methods
>>>pointing to sbusfb_compat_ioctl in drivers/video/sbuslib.c.
>>>However, drivers for framebuffers like the Mach64 that can exist
>>>on both SPARCs and non-SPARCs were not adjusted, so in sparc64
>>>kernels SPARC-specific framebuffer ioctls on Mach64 devices are
>>>no longer accepted from 32-bit mode processes. Hence the errors.
>>>
>>>The fix is to make atyfb_base.c set up a ->compat_ioctl pointing
>>>to sbusfb_compat_ioctl when running in a sparc64 kernel with
>>>compatibility for sparc32 user-space, and to compile and link
>>>sbuslib.o with the frambuffer driver.
>>>
>>>A complication is that sbuslib.c doesn't compile on non-SPARC
>>>machines, so we must be careful to only enable it in the case
>>>described above. That's why the patch puts an ugly "if" statement
>>>in the Makefile.
>>
>>Why not something like this?
>>
>>1. In Kconfig
>>
>>config FB_SBUSLIB
>>tristate
>>default n
>>
>>Then all the sbus drivers will have this:
>>
>>select FB_SBUSLIB
>>
>>and atyfb will have this
>>
>>select FB_SBUSLIB if SPARC64 && COMPAT
>>
>>2. In Makefile
>>obj-$(CONFIG_FB_SBUSLIB)  += sbuslib.o
>>
>>3. In sbuslib.h
>>
>>#ifdef CONFIG_COMPAT
>>int sbusfb_compat_ioctl(...);
>>#else
>>#define sbusfb_compat_ioctl NULL;
>>#endif
> 
> 
> That could work. But it's a much larger patch than mine,
> and I don't want to go around hacking random other stuff
> just to repair atyfb. It's up the the Powers That Be to
> decide whether a local fix or a global one is most appropriate.
> 
> 
>>This way, we can also eliminate all the #ifdef CONFIG_COMPAT in all the
>>cg* drivers and atyfb.
> 
> 
> That would require sbuslib.h to be completely benign on
> non-SPARC machines. If it is, great, but I can't currently
> guarantee that it is.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi,
I have similar problem with my Raptor GFX (Permedia2). If I run 
Xserver in fb driver I get this:


ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40584606){00} arg(ff25bb9c) 
on /dev/fb0
ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40184600){00} arg(ff25bba4) 
on /dev/fb0

Is it same problem as in Atyfb ?

				Thanks
					Dan Smolik












