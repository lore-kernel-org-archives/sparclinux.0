From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Thu, 12 Nov 2020 08:10:34 +0000
Subject: Re: [patch V3 10/37] ARM: highmem: Switch to generic kmap atomic
Message-Id: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
 <20201103095857.582196476@linutronix.de>
 <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com>
In-Reply-To: <20201103095857.582196476@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, nouveau@lists.freedesktop.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Huang Rui <ray.huang@amd.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Paul McKenney <paulmck@kernel.org>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Christian Koenig <christian.koenig@amd.com>, linux-btrfs@vger.kernel.org

Hi Thomas,

On 03.11.2020 10:27, Thomas Gleixner wrote:
> No reason having the same code in every architecture.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org

This patch landed in linux-next 20201109 as commit 2a15ba82fa6c ("ARM: 
highmem: Switch to generic kmap atomic"). However it causes a following 
warning on my test boards (Samsung Exynos SoC based):

Run /sbin/init as init process
INIT: version 2.88 booting
------------[ cut here ]------------
WARNING: CPU: 3 PID: 120 at mm/highmem.c:502 
kunmap_local_indexed+0x194/0x1d0
Modules linked in:
CPU: 3 PID: 120 Comm: init Not tainted 5.10.0-rc2-00010-g2a15ba82fa6c #1924
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111514>] (unwind_backtrace) from [<c010ceb8>] (show_stack+0x10/0x14)
[<c010ceb8>] (show_stack) from [<c0b1b408>] (dump_stack+0xb4/0xd4)
[<c0b1b408>] (dump_stack) from [<c0126988>] (__warn+0x98/0x104)
[<c0126988>] (__warn) from [<c0126aa4>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126aa4>] (warn_slowpath_fmt) from [<c028e22c>] 
(kunmap_local_indexed+0x194/0x1d0)
[<c028e22c>] (kunmap_local_indexed) from [<c02d37f4>] 
(remove_arg_zero+0xa0/0x158)
[<c02d37f4>] (remove_arg_zero) from [<c034cfc8>] (load_script+0x250/0x318)
[<c034cfc8>] (load_script) from [<c02d2f7c>] (bprm_execve+0x3d0/0x930)
[<c02d2f7c>] (bprm_execve) from [<c02d3dc8>] 
(do_execveat_common+0x174/0x184)
[<c02d3dc8>] (do_execveat_common) from [<c02d4cec>] (sys_execve+0x30/0x38)
[<c02d4cec>] (sys_execve) from [<c0100060>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xc4561fa8 to 0xc4561ff0)
1fa0:                   b6f2bab8 bef7dac4 bef7dac4 bef7d8fc 004b9b58 
bef7dac8
1fc0: b6f2bab8 bef7dac4 bef7d8fc 0000000b 004b8000 004bac44 bef7da3c 
bef7d8dc
1fe0: 0000002f bef7d89c b6d6dc74 b6d6d65c
irq event stamp: 1283
hardirqs last  enabled at (1293): [<c019f564>] console_unlock+0x430/0x6b0
hardirqs last disabled at (1302): [<c019f55c>] console_unlock+0x428/0x6b0
softirqs last  enabled at (1282): [<c0101768>] __do_softirq+0x528/0x674
softirqs last disabled at (1269): [<c012fed4>] irq_exit+0x1dc/0x1e8
---[ end trace 6f32a2fb4294655f ]---

I can do more tests to help fixing this issue. Just let me know what to do.

...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
