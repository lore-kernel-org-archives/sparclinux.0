From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 23:15:23 +0000
Subject: Re: RCU detected CPU 0 stall after panic on sparc64
Message-Id: <20091214231523.GH6679@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.0912121049030.26625@math.ut.ee> <20091212.014002.173528710.davem@davemloft.net> <20091214202556.GC6679@linux.vnet.ibm.com> <20091214.130201.144162604.davem@davemloft.net>
In-Reply-To: <20091214.130201.144162604.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Dec 14, 2009 at 01:02:01PM -0800, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Mon, 14 Dec 2009 12:25:56 -0800
> 
> > Hmmm...  At first glance, it looks like RCU should put a notifier onto
> > the panic_notifier_list to disable this check.  Or is there some global
> > variable that I can check?
> 
> Probably the notifier works just fine.

OK, will take that approach.

							Thanx, Paul
