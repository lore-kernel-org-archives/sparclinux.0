From: Meelis Roos <mroos@linux.ee>
Date: Tue, 24 May 2016 19:34:05 +0000
Subject: Re: newest 4.6.0-08907-g7639dad on sparc64 - possible irq lock inversion dependency detected
Message-Id: <alpine.LRH.2.20.1605242231150.29672@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Thanks for the report.  This code path only runs on cheetah+ cpus,
> which is why your V240 is one machine where you see this.
> 
> Please test the following patch, thanks again!
> 
> ==========
> sparc64: Take ctx_alloc_lock properly in hugetlb_setup().

This seems to work fine - ran "git clone-" for hours and the warning did 
not reappear.

However, I have seen this during the hours in dmesg, sooin after start:

[  698.710915] ------------[ cut here ]------------
[  698.771673] WARNING: CPU: 1 PID: 1565 at kernel/smp.c:416 smp_call_function_many+0xc0/0x400
[  698.881558] Modules linked in: loop sg tg3 i2c_ali15x3 hwmon i2c_ali1535 ptp pps_core skge i2c_core
[  699.000592] CPU: 1 PID: 1565 Comm: git Not tainted 4.6.0-08907-g7639dad-dirty #8
[  699.097834] Call Trace:
[  699.129850]  [00000000004602a4] __warn+0xa4/0xe0
[  699.190471]  [0000000000460378] warn_slowpath_null+0x18/0x40
[  699.264816]  [00000000004e7ae0] smp_call_function_many+0xc0/0x400
[  699.344882]  [00000000004e7e44] smp_call_function+0x24/0x40
[  699.418081]  [00000000004e7e7c] on_each_cpu+0x1c/0xa0
[  699.484422]  [0000000000451a80] hugetlb_setup+0x120/0x160
[  699.555335]  [0000000000450568] do_sparc64_fault+0x508/0x7a0
[  699.629683]  [0000000000407cb0] sparc64_realfault_common+0x10/0x20
[  699.710890] ---[ end trace d3b6e60a330e267d ]---
[  699.771506] ------------[ cut here ]------------
[  699.832130] WARNING: CPU: 1 PID: 1565 at kernel/smp.c:291 smp_call_function_single+0xc4/0x1c0
[  699.944230] Modules linked in: loop sg tg3 i2c_ali15x3 hwmon i2c_ali1535 ptp pps_core skge i2c_core
[  700.063160] CPU: 1 PID: 1565 Comm: git Tainted: G        W       4.6.0-08907-g7639dad-dirty #8
[  700.176419] Call Trace:
[  700.208530]  [00000000004602a4] __warn+0xa4/0xe0
[  700.269156]  [0000000000460378] warn_slowpath_null+0x18/0x40
[  700.343503]  [00000000004e76c4] smp_call_function_single+0xc4/0x1c0
[  700.425857]  [00000000004e7b80] smp_call_function_many+0x160/0x400
[  700.507063]  [00000000004e7e44] smp_call_function+0x24/0x40
[  700.580263]  [00000000004e7e7c] on_each_cpu+0x1c/0xa0
[  700.646602]  [0000000000451a80] hugetlb_setup+0x120/0x160
[  700.717518]  [0000000000450568] do_sparc64_fault+0x508/0x7a0
[  700.791865]  [0000000000407cb0] sparc64_realfault_common+0x10/0x20
[  700.873070] ---[ end trace d3b6e60a330e267e ]---
[ 1992.438454] kworker/dying (61) used greatest stack depth: 1760 bytes left



-- 
Meelis Roos (mroos@linux.ee)
