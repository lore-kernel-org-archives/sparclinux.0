From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 21:01:31 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329.140131.118617762.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100328043446.GA11748@nowhere>
	<20100329.130931.149161813.davem@davemloft.net>
	<20100329204931.GJ5101@nowhere>
In-Reply-To: <20100329204931.GJ5101@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 29 Mar 2010 22:49:33 +0200

> While building perf tools, or the kernel, or whatever, I often
> get the following error in the middle:
> 
> 	gcc: Internal error: Segmentation fault (program as)
> 
> And this in the logs:
> 
> 	[ 1429.477049] as[2658]: segfault at 4054dfa8 ip 0000000000020690 (rpc 00000000700adcf4) sp 00000000ffcbf008 
> error 30001 in as[10000+40000]

What distribution and binutils are you using?
