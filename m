From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Fri, 28 Jul 2017 19:09:56 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170728190956.GA26640@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
In-Reply-To: <20170728184129.GA24364@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:

[ . . . ]

> > Even though Jonathan's testing indicates that it didn't fix this
> > particular problem:
> > 
> > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> And while we are at it:
> 
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Not because it it fixed the TREE01 issue -- it did not.  But as near
as I can see, it didn't cause any additional issues.

							Thanx, Paul

