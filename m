From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Jan 2008 19:44:14 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <20080117114414.308db9e7.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117135641.GD2693@hacking>
	<200801171911.16230.m.kozlowski@tuxland.pl>
	<20080117105606.ff89e9e9.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Thu, 17 Jan 2008 11:38:53 -0800 "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

>  
> 
> >-----Original Message-----
> >From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> >Sent: Thursday, January 17, 2008 10:56 AM
> >To: Mariusz Kozlowski
> >Cc: WANG Cong; linux-kernel@vger.kernel.org; Jeff Dike; 
> >user-mode-linux-devel@lists.sourceforge.net; David Miller; 
> >sparclinux@vger.kernel.org; Ingo Molnar; Thomas Gleixner; 
> >Pallipadi, Venkatesh
> >Subject: Re: [-mm Patch] uml: fix a building error
> >
> >On Thu, 17 Jan 2008 19:11:13 +0100 Mariusz Kozlowski 
> ><m.kozlowski@tuxland.pl> wrote:
> >
> >> Hello,
> >> 
> >> > This patch fixes this building error:
> >> > ...
> >> > drivers/char/mem.c: In function 'read_mem':
> >> > drivers/char/mem.c:136: error: implicit declaration of 
> >function 'unxlate_dev_mem_ptr'
> >> > ...
> >> 
> >> I see this on sparc64 as well:
> >> 
> >>   CC      drivers/char/mem.o
> >> drivers/char/mem.c: In function 'read_mem':
> >> drivers/char/mem.c:136: error: implicit declaration of 
> >function 'unxlate_dev_mem_ptr'
> >> make[2]: *** [drivers/char/mem.o] Error 1
> >> make[1]: *** [drivers/char] Error 2
> >> make: *** [drivers] Error 2
> >> 
> >> Does sparc64 need similar fix?
> >> 
> >
> >The PAT patches strike again.
> >
> >Ingo, I think you might need to toss some cross-compilers into 
> >that build
> >test setup of yours.
> >
> 
> These functions were defined for other archs in asm-generic/iomap.h.
> We need all archs including it in io.h. I now see only few archs are
> including it..
> 
> Apart from unxlate, there is also ioremap_wc which is defined in the
> same way.
> 
> I can send a patch for this. But, I don't have cross compiler setup for
> all archs to test. Andrew, I will need your help.

Well.

- there are a bunch of cross-compiler binaries in
  http://userweb.kernel.org/~akpm/cross-compilers/

- I'll (again) encourage Ingo to add cross-compilation testing to his
  auto-testing setup. 

- I ran out of steam (and the selinux bug crashed my remote
  cross-compilation test box) so I didn't do much cross-compilation testing
  on rc8-mm1: just alpha and ia64 iirc.  

I'd suggest that you just prepare a best-effort patch and when I next get
around to doing more cross-compilation any problems shold get weeded out.

