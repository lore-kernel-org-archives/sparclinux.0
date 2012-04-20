From: Yong Zhang <yong.zhang0@gmail.com>
Date: Fri, 20 Apr 2012 03:36:34 +0000
Subject: Re: [PATCH 1/1] sparc: task_cpu() for stopper thread on sparc32 returns 0
Message-Id: <20120420033634.GA13068@zhy>
List-Id: <sparclinux.vger.kernel.org>
References: <1334827362-3434-1-git-send-email-konrad@gaisler.com>
 <20120419153428.GB1120@merkur.ravnborg.org>
In-Reply-To: <20120419153428.GB1120@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, davem@davemloft.net, daniel@gaisler.com

On Thu, Apr 19, 2012 at 05:34:28PM +0200, Sam Ravnborg wrote:
> Added a few more people - as this patch touches a core file.
> 
> I expect we have an issue on sparc32 - that manifest
> in this bug. But I do not know this code at all.
> 
> 	Sam
> 
> On Thu, Apr 19, 2012 at 11:22:42AM +0200, Konrad Eisele wrote:
> > The stopper thread for CPU > 0 (at least in sparc32)
> > has on initialization task_cpu() set to zero even
> > for CPUs > 0. The patch explicitly checks weather the
> > CPU is allowed to run on the cpu that task_cpu()
> > return or changes the return cpu.

Actually try_to_wake_up() will put the task to the right place.

Could you please try the following patch? (Hope I'm putting
notify_cpu_starting() in the right place).

---
From: Yong Zhang <yong.zhang@windriver.com>
Date: Fri, 20 Apr 2012 11:31:45 +0800
Subject: [PATCH] sparc32,leon: add notify_cpu_starting()

Otherwise cpu_active_mask will not set, which lead to other issue.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/sparc/kernel/leon_smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1210fde..bb017e7 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -78,6 +78,8 @@ void __cpuinit leon_callin(void)
 	local_flush_tlb_all();
 	leon_configure_cache_smp();
 
+	notify_cpu_starting(cpuid);
+
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
 
-- 
1.7.5.4
