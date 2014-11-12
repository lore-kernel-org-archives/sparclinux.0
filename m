From: David Miller <davem@davemloft.net>
Date: Wed, 12 Nov 2014 18:32:10 +0000
Subject: Re: [PATCH] sparc64: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <20141112.133210.2150102649123612493.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1415810741-25131-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1415810741-25131-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: bob.picco@oracle.com, sam@ravnborg.org, mgorman@suse.de, riel@redhat.com, tkhai@yandex.ru, allen.pais@oracle.com, sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 12 Nov 2014 09:45:41 -0700

> sparc64: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
> 
> Bit 9 of TTE is CV (Cacheable in V-cache) on sparc v9 processor while
> the same bit 9 is MCDE (Memory Corruption Detection Enable) on M7
> processor. This creates a conflicting usage of the same bit. Kernel
> sets TTE.cv bit on all pages for sun4v architecture which works well
> for sparc v9, but sets memory corruption detection bit on M7 processor
> which is not the intent. This patch adds code to determine if kernel
> is running on M7 processor and takes steps to not enable memory
> corruption detection in TTE erroneously.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

The hypervisor specification clearly defines bit 9 as V-Cache
cacheable.

Reusing this bit instead of doing something else was quite unwise if
you ask me.

I also really want a programmers manual for the M7 chip at this point
before I'm willing to apply any patches of this nature.

It's nearly impossible for me to sufficiently review all of the recent
binutils (for new instructions) and now kernel (redefined TTE bits)
changes without access to the programmer's manual.

Thanks.
