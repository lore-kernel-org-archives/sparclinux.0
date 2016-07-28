From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2016 00:20:59 +0000
Subject: Re: [PATCH] sparc: round fault_address down to a page boundary
Message-Id: <20160727.172059.613769871190468937.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1607081802110.16734@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1607081802110.16734@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 8 Jul 2016 19:02:46 -0400 (EDT)

> This patch fixes the bug by rounding fault_address down to a page
> boundary.

Great analysis, but we need to modify the fix a little bit.

First of all, every use of ->fault_address potentially has this
problem.  So we should fix all such cases.

But this leads us to discover what the true root problem is in the
first place.  And this is that on CPUs where we use the TLB_TAG_ACCESS
register to get the fault address we end up with the context ID in the
lower 13 bits of the value.

Other methods of sourcing the value provide the proper full address
without any extraneous bits set (%tpc and hypervisor provided fault
addresses).

So the proper fix is to mask out the context ID bits when we read
the TLB_TAG_ACCESS with intent to store that value in the
current_thread_info()->fault_address member.

All of this is also why this bug doesn't show up on Niagara based
systems.
