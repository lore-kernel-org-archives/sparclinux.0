From: David Miller <davem@davemloft.net>
Date: Wed, 14 Apr 2010 01:51:06 +0000
Subject: Re: Weird rcu lockdep warning
Message-Id: <20100413.185106.46340154.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100414000226.GH5602@nowhere>
	<20100413.171306.25868761.davem@davemloft.net>
	<20100414014930.GI2538@linux.vnet.ibm.com>
In-Reply-To: <20100414014930.GI2538@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulmck@linux.vnet.ibm.com
Cc: fweisbec@gmail.com, a.p.zijlstra@chello.nl, mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 13 Apr 2010 18:49:30 -0700

> On Tue, Apr 13, 2010 at 05:13:06PM -0700, David Miller wrote:
>> From: Frederic Weisbecker <fweisbec@gmail.com>
>> Date: Wed, 14 Apr 2010 02:02:27 +0200
>> 
>> > I just have a guess though....
>> > This seems to always happen from NMI path, and lockdep is disabled on NMI.
>> > I suspect the lock_acquire() performed by rcu_read_lock() is just ignored
>> > and then the rcu_read_lock_held() check has the wrong result...
>> 
>> Yeah, I bet that's it too.
>> 
>> lock_is_held() can't return anything meaningful while lockdep is
>> disabled, which it is during NMIs.
> 
> Ah!  So I just need to add a "current->lockdep_recursion"
> check to debug_lockdep_rcu_enabled().  And move the function to
> kernel/rcutree_plugin.h to avoid #include hell.
> 
> See below for (untested) patch.

Looks good to me, Frederic please test :-)
