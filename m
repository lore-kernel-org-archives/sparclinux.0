From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 18 Jan 2008 02:19:08 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <20080118021908.GA10658@c2.user-mode-linux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117105606.ff89e9e9.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com> <20080117211437.GA7573@c2.user-mode-linux.org> <20080117214150.GA25872@linux-os.sc.intel.com> <20080117230802.GA9360@c2.user-mode-linux.org> <924EFEDD5F540B4284297C4DC59F3DEE62B45A@orsmsx423.amr.corp.intel.com>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE62B45A@orsmsx423.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jan 17, 2008 at 03:17:38PM -0800, Pallipadi, Venkatesh wrote:
> >#define X X
> >
> >is a no-op, yes?
> >
> 
> Later there is code in generic.h which is doing
> #ifndef ioremap_wc
> #define ioremap_wc ioremap_nocache
> #endif

Ah, that makes a bit more sense.

It'd be nice if there was less of a WTF factor there, though.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

