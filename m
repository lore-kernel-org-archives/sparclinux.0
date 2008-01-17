From: Jeff Dike <jdike@addtoit.com>
Date: Thu, 17 Jan 2008 18:56:25 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <20080117185625.GA5724@c2.user-mode-linux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org> <20080117135641.GD2693@hacking> <200801171911.16230.m.kozlowski@tuxland.pl>
In-Reply-To: <200801171911.16230.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Jan 17, 2008 at 07:11:13PM +0100, Mariusz Kozlowski wrote:
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

Probably - it seems that xlate_dev_mem_ptr can now introduce
side-effects which need to be undone with unxlate_dev_mem_ptr.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
