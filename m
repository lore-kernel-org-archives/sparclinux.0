From: David Miller <davem@davemloft.net>
Date: Wed, 14 Apr 2010 00:13:06 +0000
Subject: Re: Weird rcu lockdep warning
Message-Id: <20100413.171306.25868761.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100413200432.GB5099@nowhere>
	<20100413234043.GG2538@linux.vnet.ibm.com>
	<20100414000226.GH5602@nowhere>
In-Reply-To: <20100414000226.GH5602@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 02:02:27 +0200

> I just have a guess though....
> This seems to always happen from NMI path, and lockdep is disabled on NMI.
> I suspect the lock_acquire() performed by rcu_read_lock() is just ignored
> and then the rcu_read_lock_held() check has the wrong result...

Yeah, I bet that's it too.

lock_is_held() can't return anything meaningful while lockdep is
disabled, which it is during NMIs.
