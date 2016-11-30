From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Nov 2016 19:21:59 +0000
Subject: Re: next: Commit 'mm: Prevent __alloc_pages_nodemask() RCU CPU stall ...' causing hang on sparc32 qe
Message-Id: <20161130192159.GB22216@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161129212308.GA12447@roeck-us.net>
 <20161130012817.GH3924@linux.vnet.ibm.com>
 <b96c1560-3f06-bb6d-717a-7a0f0c6e869a@roeck-us.net>
 <20161130070212.GM3924@linux.vnet.ibm.com>
 <929f6b29-461a-6e94-fcfd-710c3da789e9@roeck-us.net>
 <20161130120333.GQ3924@linux.vnet.ibm.com>
In-Reply-To: <20161130120333.GQ3924@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, davem@davemloft.net

On Wed, Nov 30, 2016 at 04:03:33AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2016 at 02:52:11AM -0800, Guenter Roeck wrote:
> > On 11/29/2016 11:02 PM, Paul E. McKenney wrote:
> > >On Tue, Nov 29, 2016 at 08:32:51PM -0800, Guenter Roeck wrote:
> > >>On 11/29/2016 05:28 PM, Paul E. McKenney wrote:
> > >>>On Tue, Nov 29, 2016 at 01:23:08PM -0800, Guenter Roeck wrote:
> > >>>>Hi Paul,
> > >>>>
> > >>>>most of my qemu tests for sparc32 targets started to fail in next-20161129.
> > >>>>The problem is only seen in SMP builds; non-SMP builds are fine.
> > >>>>Bisect points to commit 2d66cccd73436 ("mm: Prevent __alloc_pages_nodemask()
> > >>>>RCU CPU stall warnings"); reverting that commit fixes the problem.
> 
> And I have dropped this patch.  Michal Hocko showed me the error of
> my ways with this patch.
> 

:-)

On another note, I still get RCU tracebacks in the s390 tests.

BUG: sleeping function called from invalid context at mm/page_alloc.c:3775

That is caused by 'rcu: Maintain special bits at bottom of ->dynticks counter';
if I recall correctly we had discussed that earlier.

Thanks,
Guenter
