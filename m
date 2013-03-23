From: David Miller <davem@davemloft.net>
Date: Sat, 23 Mar 2013 23:49:03 +0000
Subject: Re: [PATCH] sparc64: Move offset calculation of several structures to asm-offset.c
Message-Id: <20130323.194903.518532142246973253.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1631521364039095@web14d.yandex.ru>
In-Reply-To: <1631521364039095@web14d.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 23 Mar 2013 15:44:55 +0400

> 1)Calculate offset of members of thread_info, trap_per_cpu and tsb_config
> in asm-offset.c
> 2)Replace DEFINE(*, offsetof(...)) with OFFSET(...)
> 3)Inify using of asm-offset.h in header files
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Things are done this way on purpose.

When the offsets change, I don't want the code to just automatically
adjust the assembler offset defines.

Instead, I want whoever changes things in this area to carefully
analyze the side effects.

For example, if anyone adds members, it now makes the trap block
larger than the power of 2 it currently is, and that means the
shift used to compute a cpu number to a trap block offset no
longer works.

Also, if members are moved, cache alignment of adjoining members
means that rearrangement must be done carefully.

This means, overall, nothing should happen automatically when
people make changes to the trap block.
