From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Sun, 30 Jul 2017 16:59:01 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170730165901.GX3730@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
 <20170728190956.GA26640@linux.vnet.ibm.com>
 <20170730133747.anusyacw2l5hhjgx@tardis>
In-Reply-To: <20170730133747.anusyacw2l5hhjgx@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Jul 30, 2017 at 09:37:47PM +0800, Boqun Feng wrote:
> On Fri, Jul 28, 2017 at 12:09:56PM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
> > 
> > [ . . . ]
> > 
> > > > Even though Jonathan's testing indicates that it didn't fix this
> > > > particular problem:
> > > > 
> > > > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > And while we are at it:
> > > 
> > > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > Not because it it fixed the TREE01 issue -- it did not.  But as near
> > as I can see, it didn't cause any additional issues.
> > 
> 
> Understood.
> 
> Still work on waketorture for a test case which could trigger this
> problem in a real world. My old plan is to send this out when I could
> use waketorture to show this patch actually resolves some potential
> bugs, but just put it ahead here in case it may help.
> 
> Will send it out with your Tested-by and Acked-by and continue to work
> on waketorture.

Sounds good!

Given that Jonathan's traces didn't show a timer expiration, the problems
might be in timers.

							Thanx, Paul

