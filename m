From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Tue, 18 Apr 2006 21:15:53 +0000
Subject: Re: Building a small sparc32 kernel
Message-Id: <20060418211549.GB2484@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <20060404151927.GC2358@cassis>
In-Reply-To: <20060404151927.GC2358@cassis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

9 days, 5 hours, 9 minutes, 57 seconds ago, 
Bob Breuer wrote:
> Are you using multiple drives?  I've seen this problem before when using
> multiple drives, even with a 2.6 UP kernel, but I've not had a problem
> when only actively using one drive.

I tried to remove an SCSI disk but this did not yield any noticeable
change.

I also tried to apply a change that was made to `esp_reset ()' in 2.6.16
but that did not improve anything either [0].

Any idea of what else could go wrong?  Maybe my kernel config is broken
in some obvious way?

> Try configuring the kernel with spinlock debugging turned off.

Hmm, I'll try that, but (i) that shouldn't make a big difference and
(ii) the whole point of trying out your patch is to get more information
on what goes wrong, isn't it?  ;-)

Thanks,
Ludovic.

[0] http://lists.debian.org/debian-sparc/2006/04/msg00081.html

