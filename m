From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 05 Apr 2010 06:57:04 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100405065701.GC5127@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100404121851.GC5177@nowhere> <20100404122113.GD5177@nowhere> <20100404.180057.109331958.davem@davemloft.net>
In-Reply-To: <20100404.180057.109331958.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

On Sun, Apr 04, 2010 at 06:00:57PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Sun, 4 Apr 2010 14:21:19 +0200
> 
> > Forgot the config, it's in attachment.
> 
> I get them too when even trying to use the function tracer in some
> simple way.  They occur in random places and eventually the entire
> machine wedges and is unusuable.


Yeah. But it's not totally random. I often see the same scheduler
crash.

It seems to happen after an unaligned access fixup.


> 
> I suspect there is some bug that ends up corrupting memory, so I
> started trying to debug this last night when I first saw it.


Ok. I indeed have the same problem with the function tracer when
it is running.

 
> I'll let you know if I make any progress.


Thanks!

