From: David Miller <davem@davemloft.net>
Date: Mon, 14 Dec 2009 21:02:01 +0000
Subject: Re: RCU detected CPU 0 stall after panic on sparc64
Message-Id: <20091214.130201.144162604.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.0912121049030.26625@math.ut.ee>
	<20091212.014002.173528710.davem@davemloft.net>
	<20091214202556.GC6679@linux.vnet.ibm.com>
In-Reply-To: <20091214202556.GC6679@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulmck@linux.vnet.ibm.com
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 12:25:56 -0800

> Hmmm...  At first glance, it looks like RCU should put a notifier onto
> the panic_notifier_list to disable this check.  Or is there some global
> variable that I can check?

Probably the notifier works just fine.
