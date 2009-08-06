From: Tejun Heo <tj@kernel.org>
Date: Thu, 06 Aug 2009 09:33:28 +0000
Subject: [PATCH 1/2 2.6.31-rc5 REPOST] init: set nr_cpu_ids before setup_per_cpu_areas()
Message-Id: <4A7AA368.8080606@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

nr_cpu_ids is dependent only on cpu_possible_map and
setup_per_cpu_areas() already depends on cpu_possible_map and will use
nr_cpu_ids.  Initialize nr_cpu_ids before setting up percpu areas.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
This is repost of the following two patches with sparclinux mailing
list cc'd because I couldn't get any response from David Miller.
Nothing has changed code-wise.

 http://thread.gmane.org/gmane.linux.kernel/867587

These two patches fix boot failure on sparc64 which happens if the
cpus don't have consecutive cpu numbers.

Thanks.

 init/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2c5ade7..2d9d6bd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -584,8 +584,8 @@ asmlinkage void __init start_kernel(void)
 	setup_arch(&command_line);
 	mm_init_owner(&init_mm, &init_task);
 	setup_command_line(command_line);
-	setup_per_cpu_areas();
 	setup_nr_cpu_ids();
+	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */

 	build_all_zonelists();
-- 
1.6.0.2

