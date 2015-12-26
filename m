From: David Miller <davem@davemloft.net>
Date: Sat, 26 Dec 2015 06:27:20 +0000
Subject: Re: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <20151226.012720.821933898483646366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 25 Dec 2015 22:02:43 -0700

> Also, in the code we submitted, there was an optimization in which
> %asi is read, and then only set to ASI_AIUS if necessary. This
> drastically reduces the number of writes to the %asi register since
> most of the time %asi will contain ASI_AIUS. This seems like a
> reasonable optimization, since this function may be called thousands
> of times per second on every cpu.

I noticed the optimization.

If this was happening for every memcpy call, I'd say it's worth it.

But it's happening once for a series of memcpy/copy_from_user_inatomic()
calls so I'd say it's not really worth it.

So unless you can show me how the current version fails, I'm keeping it
as-is because either we should consistently use set_fs/get_fs in C
code rather than open coded inline asm, or we should create a well
documented set of helper functions for this specific situation and
_ALSO_ use it elsewhere where the same problems exist such as some
of the uses of set_fs/get_fs in process_64.c

