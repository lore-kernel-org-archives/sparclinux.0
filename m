From: David Miller <davem@davemloft.net>
Date: Sun, 18 Dec 2016 03:14:42 +0000
Subject: Re: [RFC PATCH 04/14] sparc64: load shared id into context register 1
Message-Id: <20161217.221442.430708127662119954.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
	<1481913337-9331-5-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-5-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@oracle.com, nitin.m.gupta@oracle.com, vijay.ac.kumar@oracle.com, julian.calaby@gmail.com, adam.buchbinder@gmail.com, kirill.shutemov@linux.intel.com, mhocko@suse.com, akpm@linux-foundation.org

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 10:35:27 -0800

> In current code, only context ID register 0 is set and used by the MMU.
> On sun4v platforms that support MMU shared context, there is an additional
> context ID register: specifically context register 1.  When searching
> the TLB, the MMU will find a match if the virtual address matches and
> the ID contained in context register 0 -OR- context register 1 matches.
> 
> Load the shared context ID into context ID register 1.  Care must be
> taken to load register 1 after register 0, as loading register 0
> overwrites both register 0 and 1.  Modify code loading register 0 to
> also load register one if applicable.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

You can't make these register accesses if the feature isn't being
used.

Considering the percentage of applications which will actually use
this thing, incuring the overhead of even loading the shared context
register is simply unacceptable.
