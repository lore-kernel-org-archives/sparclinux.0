From: mroos@linux.ee
Date: Sat, 24 May 2014 20:02:28 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1405242301090.18040@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140414184353.GA5630@drone.musicnaut.iki.fi> <20140416.145822.1317931249717152474.davem@davemloft.net> <20140425200908.GG575@drone.musicnaut.iki.fi> <20140425.161753.153968588224593753.davem@davemloft.net>
In-Reply-To: <20140425.161753.153968588224593753.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

This is todays fresh git with 3.15.0-rc6-00190-g1ee1cea on V210, THP 
enabled & always on. Got this and a segfault on apt-spawned xz.

[  142.599575] ------------[ cut here ]------------
[  142.660349] WARNING: CPU: 1 PID: 2237 at mm/mmap.c:2741 exit_mmap+0x140/0x160()
[  142.756483] Modules linked in: ipv6 tg3 hwmon ptp pps_core
[  142.830269] CPU: 1 PID: 2237 Comm: aptitude Not tainted 3.15.0-rc6-00190-g1ee1cea #93
[  142.933226] Call Trace:
[  142.965358]  [000000000045a12c] warn_slowpath_common+0x4c/0x80
[  143.042074]  [00000000004e7a40] exit_mmap+0x140/0x160
[  143.108410]  [00000000004586a0] mmput.part.60+0x20/0xe0
[  143.177030]  [000000000045af3c] exit_mm+0x11c/0x180
[  143.241071]  [000000000045c920] do_exit+0x240/0x340
[  143.305134]  [000000000045cb48] do_group_exit+0x28/0xc0
[  143.373753]  [0000000000468ac8] get_signal_to_deliver+0x1c8/0x3a0
[  143.453819]  [0000000000449334] do_signal32+0x14/0x220
[  143.521292]  [000000000042d0e0] do_signal+0x2c0/0x520
[  143.587624]  [000000000042db40] do_notify_resume+0x40/0x60
[  143.659683]  [0000000000404b04] __handle_signal+0xc/0x2c
[  143.729448] ---[ end trace b34008751438e7e6 ]---
[  143.790182] BUG: Bad rss-counter state mm:fffffc000d9d3660 idx:1 val:1


-- 
Meelis Roos (mroos@linux.ee)
