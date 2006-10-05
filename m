From: David Miller <davem@davemloft.net>
Date: Thu, 05 Oct 2006 22:22:30 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <20061005.152230.45740673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061005211543.GA18539@ele.uri.edu>
In-Reply-To: <20061005211543.GA18539@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 5 Oct 2006 17:15:44 -0400

> Here's a pair of unaligned accesses I found playing with the eth1394 driver:
> 
> Kernel unaligned access at TPC[102c8190] ether1394_tx+0xf8/0x600 [eth1394]
> Kernel unaligned access at TPC[10162c8c] ether1394_data_handler+0x914/0x1000 [eth1394]

Thanks a lot for reporting this.  I have a similar report from
Harald Welte involving IPV6 to look at as well.

I'll try to get these all fixed up next week.

Thanks again.
