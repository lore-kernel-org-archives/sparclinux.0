From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 15 Apr 2010 18:57:05 +0000
Subject: Re: Weird rcu lockdep warning
Message-Id: <20100415185702.GC5069@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100413200432.GB5099@nowhere> <20100413234043.GG2538@linux.vnet.ibm.com> <20100414000226.GH5602@nowhere> <20100413.171306.25868761.davem@davemloft.net> <20100414014930.GI2538@linux.vnet.ibm.com> <4BC537C9.8050600@cn.fujitsu.com> <20100414154302.GC2516@linux.vnet.ibm.com> <20100414155110.GG5142@nowhere> <20100414160057.GD2516@linux.vnet.ibm.com> <20100415042426.GA4254@linux.vnet.ibm.com>
In-Reply-To: <20100415042426.GA4254@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, David Miller <davem@davemloft.net>, a.p.zijlstra@chello.nl, mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 14, 2010 at 09:24:26PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 14, 2010 at 09:00:57AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 14, 2010 at 05:51:11PM +0200, Frederic Weisbecker wrote:
> 
> [ . . .]
> 
> > > Note I just tested the patch the previous one and it looks fine now.
> > > You can then safely consider the "general idea" fixes the problem :)
> > 
> > Thank you, Frederic!!!
> 
> And here is what I hope is the official fix.
> 
> Could you please test it?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9be39c445a41e458d53cf9a57d25dbfa4b74c970
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Apr 13 18:45:51 2010 -0700
> 
>     rcu: Make RCU lockdep check the lockdep_recursion variable
>     
>     The lockdep facility temporarily disables lockdep checking by incrementing
>     the current->lockdep_recursion variable.  Such disabling happens in NMIs
>     and in other situations where lockdep might expect to recurse on itself.
>     This patch therefore checks current->lockdep_recursion, disabling RCU
>     lockdep splats when this variable is non-zero.  In addition, this patch
>     removes the "likely()", as suggested by Lai Jiangshan.
>     
>     Reported-by: Frederic Weisbecker <fweisbec@gmail.com>
>     Reported-by: David Miller <davem@davemloft.net>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>


Tested-by: Frederic Weisbecker <fweisbec@gmail.com>

Thanks!

