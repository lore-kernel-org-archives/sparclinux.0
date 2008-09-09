From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 09 Sep 2008 14:54:53 +0000
Subject: Re: [PATCH] prevent sparc64 from invoking irq handlers on offline
Message-Id: <20080909145453.GA6711@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903004211.GD6748@linux.vnet.ibm.com> <20080903.022138.31681256.davem@davemloft.net> <20080903154217.GA6807@linux.vnet.ibm.com> <20080908.171708.43575256.davem@davemloft.net>
In-Reply-To: <20080908.171708.43575256.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, manfred@colorfullife.com, akpm@linux-foundation.org

On Mon, Sep 08, 2008 at 05:17:08PM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Wed, 3 Sep 2008 08:42:17 -0700
> > o	Timer irqs.  Not sure what happens to add_timer() calls from
> > 	a CPU that is going offline.  The hope would be that they get
> > 	queued to some other CPU?
> 
> This case is interesting, and I'm no sure what happens here.

It turns out that there is a timer_cpu_modifier() that invokes
migrate_timers() upon CPU_DEAD or CPU_DEAD_FROZEN.  And migrate_timers()
looks like it does what its name says.  And I believe that CPU_DEAD
happens after sparc64's local_irq_enable() window, so we should be OK.

							Thanx, Paul
