From: David Miller <davem@davemloft.net>
Date: Wed, 09 Oct 2013 19:18:27 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131009.151827.599038805991024801.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Thu, 03 Oct 2013 19:07:11 -0700

> And run echo 1000000 > /proc/sys/vm/nr_hugepages couple of
> times.

You're running the machine out of memory and stressing the
setup path of the hugepage subsystem a lot.

This looks entirely different from the other crash/lockup,
in that there it looked like a cpu died with interrupts
disabled and thus wasn't responding even to cross calls.

This really isn't in a format I can look into, sorry.
