From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 07 May 2005 14:29:32 +0000
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050507142932.GK3590@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net>
In-Reply-To: <427CC082.4000603@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org, starvik@axis.com, dhowells@redhat.com, wli@holomorphy.com, uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com, sparclinux@vger.kernel.org

On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
> 
> Well I built something like this now which I mail to myself,
> overlook and then going sent to lkml:

Seems to be valuable.

> Comparing 2.6.12-rc3-mm2 to 2.6.12-rc3-mm3 (defconfig)
> 
> - arm: broke
>...
>   arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
>   : undefined reference to `rd_size'
>   make[1]: *** [.tmp_vmlinux1] Error 1
>   make: *** [_all] Error 2
>   Details: http://l4x.org/k/?d476
>...

Known issue (was my fault).

I'll send separate emails regarding some other issues the output shows.

> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

