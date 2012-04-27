From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 17:56:24 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427.135624.1377865052489937669.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 13:34:07 -0400 (EDT)

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 27 Apr 2012 19:27:50 +0200
> 
>> This assignment looks redundant. I cannot see any uses of max_mapnr
>> in the kernel (which is relevant for sparc64).
> 
> pfn_valid() via asm-generic/page.h

Actually this isn't right.  We don't use asm-generic/page.h on
sparc64.

We get the pfn_valid() definition instead from linux/mmzone.h which
doesn't make use of max_mapnr.

So yes we can remove this assignment and I will do so in the sparc-next
tree, thanks!
