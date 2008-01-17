From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 17 Jan 2008 18:11:13 +0000
Subject: Re: [-mm Patch] uml: fix a building error
Message-Id: <200801171911.16230.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org> <20080117135641.GD2693@hacking>
In-Reply-To: <20080117135641.GD2693@hacking>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

Hello,

> This patch fixes this building error:
> ...
> drivers/char/mem.c: In function ‘read_mem’:
> drivers/char/mem.c:136: error: implicit declaration of function ‘unxlate_dev_mem_ptr’
> ...

I see this on sparc64 as well:

  CC      drivers/char/mem.o
drivers/char/mem.c: In function 'read_mem':
drivers/char/mem.c:136: error: implicit declaration of function 'unxlate_dev_mem_ptr'
make[2]: *** [drivers/char/mem.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Does sparc64 need similar fix?

Regards,

	Mariusz
