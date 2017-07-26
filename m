From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 04:02:33 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170725.210233.1441906980505926406.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170725175207.000001cb@huawei.com>
 <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
In-Reply-To: <20170726035545.GG3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 25 Jul 2017 20:55:45 -0700

> On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:
>> Just to report, turning softlockup back on fixes things for me on
>> sparc64 too.
> 
> Very good!
> 
>> The thing about softlockup is it runs an hrtimer, which seems to run
>> about every 4 seconds.
> 
> I could see where that could shake things loose, but I am surprised that
> it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> with no trouble, but I will be running a longer test later on.
> 
>> So I wonder if this is a NO_HZ problem.
> 
> Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> you running?  (Again, my symptoms are slightly different, so I might
> be seeing a different bug.)

I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.

To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.
