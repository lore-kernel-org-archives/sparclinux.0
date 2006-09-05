From: Daniel Smolik <marvin@mydatex.cz>
Date: Tue, 05 Sep 2006 14:26:48 +0000
Subject: Re: TILO and others
Message-Id: <44FD8928.4090808@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <44FC960D.3040508@mydatex.cz>
In-Reply-To: <44FC960D.3040508@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hamish Greig napsal(a):
> On Tuesday 05 September 2006 17:45, Rene Rebe wrote:
> 
>>I used elftoaout + the piggyback helper in arch/sparc64.
> 
> 
> I too have successfully used these two for netbooting.
> hgg
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Oh great info, but I spend three nights to get it work and haven't success.

TILO:
I use silo 1.4.13 compile without problem. I take compiled kernel which boot OK 
on my Ultra 5 and create small cramfs ramdisk with bash as init in /sbin + 
library. root.img is ~1.2M.

I run



./tilo/tilo.sh vmlinux ram_image.gz
Converting vmlinux (sun4u) to a.out:
PT 0 Entry: Loadable to 0x400000[0x3c2c30] from 0x0[0x354086] align 0x100000
PT 1 Entry: unknown
Compressing vmlinux.raw:
vmlinux.raw:     54.6%
Sizes (sun4u):
   raw size     = 3473542
   packed size  = 1575482
   root address = 00000000007c2c30
Root image packed size = 1085472
WARNING: Kernel for Sun4c/m/d not specified
Images are large. Will load on machines with at least 5M mapped by PROM only
TILO size = 2678102

But when I boot after loading boot stops with Illegal instruction :-(
If ram_image is smaller system boots but I need approx 2M is it possible ?


PIGGYBACK:

/usr/bin/piggyback vmliuz.aout sys_map.gz ram_image
Could not determine start and end from System.map
And nothing else. I look to piggyback.c and see then it search end statement not 
_end. I modify this but get sigsegv.

  /usr/local/bin/piggyback vmlinuz.aout System.map root.img
Start : 0x404000 End: 0x722ca4
i:137032
lseek: Invalid argument
lseek 2: Illegal seek

I search over whole world and nothing. I have large experience with i86 netboot 
but with Sun I start now :-).

		Thanks
			Dan
















