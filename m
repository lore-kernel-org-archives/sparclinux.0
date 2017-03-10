From: Meelis Roos <mroos@linux.ee>
Date: Fri, 10 Mar 2017 17:46:12 +0000
Subject: Re: 4.10 sparc64 regression: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]
Message-Id: <alpine.LRH.2.20.1703101945440.21677@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I am seeing the following soft lockup on multiple Ultrasparc II era 
> sparc machines - Ultra 2, Netra X1, Blade 100 at least. 4.9 was fine. 
> Will attempt to bisect some time.
> 
> The lockups are detected routinely (every 2-3 files when compiling new 
> kernel) but the machine keeps running.
> 
> CC added because of NMI changes - no idea if it is related.
> 
> I have THP enabled and always on in most machines' kernel config.
> 
> [503216.376072] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]

Ocassionally, I also get this on the U2:

[500680.792223] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 39s!
[500680.891127] Showing busy workqueues and worker pools:
[500680.955396] workqueue events: flags=0x0
[500681.005072]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
[500681.080732]     pending: vmstat_shepherd
[500681.131337] workqueue events_freezable_power_: flags=0x84
[500681.199644]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[500681.275233]     pending: disk_events_workfn
[500681.328847] workqueue kblockd: flags=0x18
[500681.380364]   pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=2/256
[500681.457924]     pending: blk_mq_timeout_work, blk_mq_timeout_work
[500681.534525] workqueue vmstat: flags=0xc
[500681.583956]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
[500681.659357]     pending: vmstat_update


-- 
Meelis Roos (mroos@linux.ee)
