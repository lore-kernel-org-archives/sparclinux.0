From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Jan 2008 18:56:06 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <20080117105606.ff89e9e9.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117135641.GD2693@hacking>
	<200801171911.16230.m.kozlowski@tuxland.pl>
In-Reply-To: <200801171911.16230.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Thu, 17 Jan 2008 19:11:13 +0100 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> > This patch fixes this building error:
> > ...
> > drivers/char/mem.c: In function ‘read_mem’:
> > drivers/char/mem.c:136: error: implicit declaration of function ‘unxlate_dev_mem_ptr’
> > ...
> 
> I see this on sparc64 as well:
> 
>   CC      drivers/char/mem.o
> drivers/char/mem.c: In function 'read_mem':
> drivers/char/mem.c:136: error: implicit declaration of function 'unxlate_dev_mem_ptr'
> make[2]: *** [drivers/char/mem.o] Error 1
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
> 
> Does sparc64 need similar fix?
> 

The PAT patches strike again.

Ingo, I think you might need to toss some cross-compilers into that build
test setup of yours.

