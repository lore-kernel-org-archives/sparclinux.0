From: Qais Yousef <qais.yousef@arm.com>
Date: Mon, 23 Mar 2020 13:51:04 +0000
Subject: [PATCH v4 11/17] sparc: Replace cpu_up/down with add/remove_cpu
Message-Id: <20200323135110.30522-12-qais.yousef@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200323135110.30522-1-qais.yousef@arm.com>
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, sparclinux@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index bbf59b3b4af8..75232cbd58bf 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -555,7 +555,7 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 
 		printk(KERN_INFO "ds-%llu: Starting cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_up(cpu);
+		err = add_cpu(cpu);
 		if (err) {
 			__u32 res = DR_CPU_RES_FAILURE;
 			__u32 stat = DR_CPU_STAT_UNCONFIGURED;
@@ -611,7 +611,7 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
 
 		printk(KERN_INFO "ds-%llu: Shutting down cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_down(cpu);
+		err = remove_cpu(cpu);
 		if (err)
 			dr_cpu_mark(resp, cpu, ncpus,
 				    DR_CPU_RES_FAILURE,
-- 
2.17.1
