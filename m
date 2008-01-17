From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Date: Thu, 17 Jan 2008 23:17:38 +0000
Subject: RE: [-mm Patch] uml: fix a building error
Message-Id: <924EFEDD5F540B4284297C4DC59F3DEE62B45A@orsmsx423.amr.corp.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117105606.ff89e9e9.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com> <20080117211437.GA7573@c2.user-mode-linux.org> <20080117214150.GA25872@linux-os.sc.intel.com> <20080117230802.GA9360@c2.user-mode-linux.org>
In-Reply-To: <20080117230802.GA9360@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

 

>-----Original Message-----
>From: Jeff Dike [mailto:jdike@addtoit.com] 
>Sent: Thursday, January 17, 2008 3:08 PM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; Mariusz Kozlowski; WANG Cong; 
>linux-kernel@vger.kernel.org; 
>user-mode-linux-devel@lists.sourceforge.net; David Miller; 
>sparclinux@vger.kernel.org; Ingo Molnar; Thomas Gleixner
>Subject: Re: [-mm Patch] uml: fix a building error
>
>On Thu, Jan 17, 2008 at 01:41:50PM -0800, Venki Pallipadi wrote:
>> > And while we're on the subject, what's the deal with these, in
>> > include/asm-x86/io.h?
>> > 
>> > #define ioremap_wc ioremap_wc
>> > #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
>> > 
>> 
>> If archs want to override the defaults for these two 
>functions, they define
>> the above and then include asm-generic/iomap.h.
>
>That wasn't really the question.
>
>#define X X
>
>is a no-op, yes?
>

Later there is code in generic.h which is doing
#ifndef ioremap_wc
#define ioremap_wc ioremap_nocache
#endif
	

Thanks,
Venki
