From: Jeff Dike <jdike@addtoit.com>
Date: Thu, 17 Jan 2008 21:14:37 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <20080117211437.GA7573@c2.user-mode-linux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117105606.ff89e9e9.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jan 17, 2008 at 11:38:53AM -0800, Pallipadi, Venkatesh wrote:
> Apart from unxlate, there is also ioremap_wc which is defined in the
> same way.

And while we're on the subject, what's the deal with these, in
include/asm-x86/io.h?

#define ioremap_wc ioremap_wc
#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr

				Jeff

-- 
Work email - jdike at linux dot intel dot com
