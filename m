From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Mon, 23 Nov 2009 14:00:50 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091123150050.A2547@linux.karinthy.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 22, 2009 at 12:26:05AM +0100, Laszlo Valko wrote:
> Now I'm going to see which kernel update introduced the problem.

Guys, here's the first change that makes my v240 unbootable:

commit e5553a6d04421eec326a629571d696e8e745a0e4
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Jan 29 21:22:47 2009 -0800

    sparc64: Implement NMI watchdog on capable cpus.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

I tried to patch -R this onto 2.6.31.6 for a cross-check, but some of the
changes have already been undone, so I guess it's not trivial to do this.

Dave, how to go on now?

Regards,
Laszlo
