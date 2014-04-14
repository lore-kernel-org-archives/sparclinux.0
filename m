From: David Miller <davem@davemloft.net>
Date: Mon, 14 Apr 2014 18:58:14 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140414.145814.165063775977075099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20131022174612.GC24448@blackmetal.musicnaut.iki.fi>
	<20131022.135442.1072093301788210177.davem@davemloft.net>
	<20140414184353.GA5630@drone.musicnaut.iki.fi>
In-Reply-To: <20140414184353.GA5630@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@iki.fi
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 14 Apr 2014 21:43:53 +0300

> Just for the archives, I got one of these again with 3.14:
> 
> [68674.536190] ------------[ cut here ]------------
> [68674.590467] WARNING: CPU: 0 PID: 14600 at /home/aaro/los/work/shared/linux-v3.14/mm/mmap.c:2738 exit_mmap+0x138/0x160()
> [68674.719635] Modules linked in:
> [68674.756022] CPU: 0 PID: 14600 Comm: rm Not tainted 3.14.0-ultra-los_0a2b #1
> [68674.839349] Call Trace:
> [68674.868507]  [00000000004b9c78] exit_mmap+0x138/0x160
> [68674.928931]  [00000000004503cc] mmput+0x2c/0xc0
> [68674.983103]  [0000000000452e98] do_exit+0x1b8/0x800
> [68675.041409]  [000000000045406c] do_group_exit+0x2c/0xa0
> [68675.103897]  [00000000004540f4] SyS_exit_group+0x14/0x20
> [68675.167439]  [0000000000406074] linux_sparc_syscall32+0x34/0x60
> [68675.238258] ---[ end trace 8a52741fbdb89d8e ]---
> [68675.293470] BUG: Bad rss-counter state mm:ffffff001df3d900 idx:1 val:1

Yes, I have reports of this going back several releases and I started trying to figure
out what causes this.

I suspect there is something that runs during exit_mmap() that indirectly faults in
new pages, and that's how the rss-counter ends up being non-zero at the end of
exit_mmap().

I'll let you know if I figure out exactly what the problem is.
