From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Fri, 28 Jul 2017 13:24:03 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170728142403.0000122b@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
In-Reply-To: <20170728084411.00001ddb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 28 Jul 2017 08:44:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Jul 2017 09:52:45 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Thu, Jul 27, 2017 at 05:39:23PM +0100, Jonathan Cameron wrote:  
> > > On Thu, 27 Jul 2017 14:49:03 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >     
> > > > On Thu, 27 Jul 2017 05:49:13 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >     
> > > > > On Thu, Jul 27, 2017 at 02:34:00PM +1000, Nicholas Piggin wrote:      
> > > > > > On Wed, 26 Jul 2017 18:42:14 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >         
> > > > > > > On Wed, Jul 26, 2017 at 04:22:00PM -0700, David Miller wrote:        
> > > > > >         
> > > > > > > > Indeed, that really wouldn't explain how we end up with a RCU stall
> > > > > > > > dump listing almost all of the cpus as having missed a grace period.          
> > > > > > > 
> > > > > > > I have seen stranger things, but admittedly not often.        
> > > > > > 
> > > > > > So the backtraces show the RCU gp thread in schedule_timeout.
> > > > > > 
> > > > > > Are you sure that it's timeout has expired and it's not being scheduled,
> > > > > > or could it be a bad (large) timeout (looks unlikely) or that it's being
> > > > > > scheduled but not correctly noting gps on other CPUs?
> > > > > > 
> > > > > > It's not in R state, so if it's not being scheduled at all, then it's
> > > > > > because the timer has not fired:        
> > > > > 
> > > > > Good point, Nick!
> > > > > 
> > > > > Jonathan, could you please reproduce collecting timer event tracing?      
> > > > I'm a little new to tracing (only started playing with it last week)
> > > > so fingers crossed I've set it up right.  No splats yet.  Was getting
> > > > splats on reading out the trace when running with the RCU stall timer
> > > > set to 4 so have increased that back to the default and am rerunning.
> > > > 
> > > > This may take a while.  Correct me if I've gotten this wrong to save time
> > > > 
> > > > echo "timer:*" > /sys/kernel/debug/tracing/set_event
> > > > 
> > > > when it dumps, just send you the relevant part of what is in
> > > > /sys/kernel/debug/tracing/trace?    
> > > 
> > > Interestingly the only thing that can make trip for me with tracing on
> > > is peaking in the tracing buffers.  Not sure this is a valid case or
> > > not.
> > > 
> > > Anyhow all timer activity seems to stop around the area of interest.
> > > 
> > > 

Firstly sorry to those who got the rather silly length email a minute ago.
It bounced on the list (fair enough - I was just being lazy on getting
data past our firewalls).

Ok.  Some info.  I disabled a few driver (usb and SAS) in the interest of having
fewer timer events.  Issue became much easier to trigger (on some runs before
I could get tracing up and running)

So logs are large enough that pastebin doesn't like them - please shout if
another timer period is of interest.

https://pastebin.com/iUZDfQGM for the timer trace.
https://pastebin.com/3w1F7amH for dmesg.  

The relevant timeout on the RCU stall detector was 8 seconds.  Event is
detected around 835.

It's a lot of logs, so I haven't identified a smoking gun yet but there
may well be one in there.

Jonathan
