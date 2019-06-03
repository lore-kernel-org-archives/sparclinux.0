From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jun 2019 05:16:48 +0000
Subject: Re: [PATCH] sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD
Message-Id: <20190602.221648.1225654208143233174.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1559096508-25847-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559096508-25847-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 92siuyang@gmail.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>
Date: Wed, 29 May 2019 10:21:48 +0800

> The PERF_EVENT_IOC_PERIOD ioctl command can be used to change the
> sample period of a running perf_event. Consequently, when calculating
> the next event period, the new period will only be considered after the
> previous one has overflowed.
> 
> This patch changes the calculation of the remaining event ticks so that
> they are offset if the period has changed.
> 
> See commit 3581fe0ef37c ("ARM: 7556/1: perf: fix updated event period in
> response to PERF_EVENT_IOC_PERIOD") for details.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>

Applied, thanks.
