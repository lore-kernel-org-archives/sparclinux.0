From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 16:48:58 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726.094858.1478051591748336400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726103232.0000368e@huawei.com>
 <20170726132801.00001e8c@huawei.com>
 <20170726141417.GJ3730@linux.vnet.ibm.com>
In-Reply-To: <20170726141417.GJ3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 07:14:17 -0700

> Dave, any other ideas on what might be causing this or what might be
> tested?

I was going to go through the changes that happened between v4.12
and now to kernel/timer/tick-sched.c and see if reverting any of
those help.

But I don't know when I would get to that.

Commit 411fe24e6b7c283c3a1911450cdba6dd3aaea56e, looks particularly juicy.
:-)
