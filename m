From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 22:11:25 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.151125.230139297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 00:05:43 +0200

> [  127.911796] FAULT[bash:2183]: 32-bit process reports 64-bit fault address [1dc5d706cc]

Any time I see this in a trace it usually means that the
register set of the cpu has been completely corrupted.

I just got a crash shortly after catting the 'trace' file
on my Niagara2 box too.  And I had never seen this before.

One thing that happened since I last tested is I did
a merge of Linus's tree into the sparc-2.6 tree I was
doing testing on.

So I wonder if some tracing et al. change in that merge
introduced this problem.

I'll take a look at the commits under kernel/trace to look
for clues and thanks for the heads up about cleaning up
the backtraces ala x86.  I can't decide which is more useful
for me, since at least half of the time I'll want to see
the real return address values in the cpu registers. :-)

