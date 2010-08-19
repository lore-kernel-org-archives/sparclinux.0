From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 18:32:12 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20100819.113212.180411371.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 19 Aug 2010 09:15:16 -0400 (EDT)

> BTW. two years ago, I reported a bug that userspace programs on sparc64 
> would randomly crash in a few hours with preempt enabled 
> ( http://marc.info/?l=linux-sparc&m1222607414906&w=4 )
> 
> Now I tried the same workload with 2.6.35 and it is stable with preempt.
> 
> Are you aware that the bug was fixed? Or if not, it may be still lurking 
> there and some unrelated change hid the race condition. Should I bisect 
> the kernel to find out which patch actually fixed (or hid) the bug?

I can't think of anything we did explicitly to fix that.

I'm sure you can find more useful things to do than to try and
bisect that thing down, really :-)
