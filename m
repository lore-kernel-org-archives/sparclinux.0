From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 29 Mar 2010 20:49:33 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329204931.GJ5101@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100328043446.GA11748@nowhere> <20100329.130931.149161813.davem@davemloft.net>
In-Reply-To: <20100329.130931.149161813.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Mar 29, 2010 at 01:09:31PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Sun, 28 Mar 2010 06:34:49 +0200
> 
> > I get kernel crashes each time I use perf with callchains
> > on sparc 64.
> > 
> > It triggers with a simple:
> > 
> > 	perf record -a -f -g sleep 1
> 
> This should fix it, thanks again.


I merged your tree on latest -git and it works well.

Thanks!

Sorry, I have another bug report.

While building perf tools, or the kernel, or whatever, I often
get the following error in the middle:

	gcc: Internal error: Segmentation fault (program as)

And this in the logs:

	[ 1429.477049] as[2658]: segfault at 4054dfa8 ip 0000000000020690 (rpc 00000000700adcf4) sp 00000000ffcbf008 
error 30001 in as[10000+40000]

My gcc / as and everything in userspace is 32 bits but the kernel is a 64.

My config is the same as before.

Again, tell me everything you need to help debugging this.

Thanks.

