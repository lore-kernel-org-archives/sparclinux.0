From: David Miller <davem@davemloft.net>
Date: Mon, 05 Apr 2010 01:00:57 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100404.180057.109331958.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100404121851.GC5177@nowhere>
	<20100404122113.GD5177@nowhere>
In-Reply-To: <20100404122113.GD5177@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 4 Apr 2010 14:21:19 +0200

> Forgot the config, it's in attachment.

I get them too when even trying to use the function tracer in some
simple way.  They occur in random places and eventually the entire
machine wedges and is unusuable.

I suspect there is some bug that ends up corrupting memory, so I
started trying to debug this last night when I first saw it.

I'll let you know if I make any progress.
