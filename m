From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 20 Apr 2010 13:58:13 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100420135808.GB5854@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 20, 2010 at 12:50:51AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Mon, 19 Apr 2010 22:51:05 -0700 (PDT)
> 
> > I have to think about why I might have done things this way to
> > make sure I fix this right.
> 
> Ok, I don't get crashes any more.  There are all kinds of issues
> with the sw watchdog triggering because cpus get slogged in
> the scheduler rebalance code, but that's a seperate set of
> issues.



I merged your latest sparc tree and the crashes are gone.

I'm really happy you've solved this. Thanks a lot for having spent
so much time on it!

