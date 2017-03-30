From: David Miller <davem@davemloft.net>
Date: Thu, 30 Mar 2017 21:25:53 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <20170330.142553.2221276682523400376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 30 Mar 2017 13:47:11 -0700

> The wrong calls to tlb_batch_add_one(), which are passing boolean to
> hugepage_shift argument, are all under CONFIG_TRANSPARENT_HUGEPAGE.
> So are you getting these corruptions only when THP is enabled?

I run with THP enabled all the time, and so should you for testing.

> I will be sending a fix for these call-sites today.

I already have a fix I'm testing now which I'll check in after my
regression test passes.
