From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 26 Jul 2017 08:16:23 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726091623.000004f7@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170725175207.000001cb@huawei.com>
 <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
 <20170725.210233.1441906980505926406.davem@davemloft.net>
 <20170726041217.GH3730@linux.vnet.ibm.com>
In-Reply-To: <20170726041217.GH3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 25 Jul 2017 21:12:17 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Tue, Jul 25, 2017 at 09:02:33PM -0700, David Miller wrote:
> > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Date: Tue, 25 Jul 2017 20:55:45 -0700
> >   
> > > On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:  
> > >> Just to report, turning softlockup back on fixes things for me on
> > >> sparc64 too.  
> > > 
> > > Very good!
> > >   
> > >> The thing about softlockup is it runs an hrtimer, which seems to run
> > >> about every 4 seconds.  
> > > 
> > > I could see where that could shake things loose, but I am surprised that
> > > it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> > > with no trouble, but I will be running a longer test later on.
> > >   
> > >> So I wonder if this is a NO_HZ problem.  
> > > 
> > > Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> > > you running?  (Again, my symptoms are slightly different, so I might
> > > be seeing a different bug.)  
> > 
> > I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.
> > 
> > To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.  
> 
> Same here -- but my failure case happens fairly rarely, so it will take
> some time to gain reasonable confidence that enabling SOFTLOCKUP_DETECTOR
> had effect.
> 
> But you are right, might be interesting to try NO_HZ_PERIODIC=y
> or NO_HZ_FULL=y.  So many possible tests, and so little time.  ;-)
> 
> 							Thanx, Paul
> 
I'll be the headless chicken running around and trying as many tests
as I can fit in.  Typical time to see the failure for us is sub 10
minutes so we'll see how far we get.

Make me a list to run if you like ;)

NO_HZ_PERIODIC=y running now.

Jonathan

