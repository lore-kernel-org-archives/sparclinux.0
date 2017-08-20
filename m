From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Sun, 20 Aug 2017 05:04:52 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170820050452.GI11320@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
In-Reply-To: <20170820144553.2ab2727b@ppc64le>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Aug 20, 2017 at 02:45:53PM +1000, Nicholas Piggin wrote:
> On Wed, 16 Aug 2017 09:27:31 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> > 
> > Thomas, John, am I misinterpreting the timer trace event messages?
> 
> So I did some digging, and what you find is that rcu_sched seems to do a
> simple scheudle_timeout(1) and just goes out to lunch for many seconds.
> The process_timeout timer never fires (when it finally does wake after
> one of these events, it usually removes the timer with del_timer_sync).
> 
> So this patch seems to fix it. Testing, comments welcome.

Fired up some tests, which should complete in about 12 hours.

Here is hoping!  ;-)

							Thanx, Paul

