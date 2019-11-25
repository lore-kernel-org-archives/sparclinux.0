From: Qais Yousef <qais.yousef@arm.com>
Date: Mon, 25 Nov 2019 11:27:47 +0000
Subject: [PATCH v2 07/14] sparc: Replace cpu_up/down with device_online/offline
Message-Id: <20191125112754.25223-8-qais.yousef@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191125112754.25223-1-qais.yousef@arm.com>
In-Reply-To: <20191125112754.25223-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Qais Yousef <qais.yousef@arm.com>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

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
 arch/sparc/kernel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index bbf59b3b4af8..39350e5dbaf1 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -550,12 +550,13 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 	mdesc_populate_present_mask(mask);
 	mdesc_fill_in_cpu_data(mask);
 
+	lock_device_hotplug();
 	for_each_cpu(cpu, mask) {
 		int err;
 
 		printk(KERN_INFO "ds-%llu: Starting cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_up(cpu);
+		err = device_online(get_cpu_device(cpu));
 		if (err) {
 			__u32 res = DR_CPU_RES_FAILURE;
 			__u32 stat = DR_CPU_STAT_UNCONFIGURED;
@@ -574,6 +575,7 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 			dr_cpu_mark(resp, cpu, ncpus, res, stat);
 		}
 	}
+	unlock_device_hotplug();
 
 	spin_lock_irqsave(&ds_lock, flags);
 	__ds_send(dp->lp, resp, resp_len);
@@ -606,17 +608,19 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
 			     resp_len, ncpus, mask,
 			     DR_CPU_STAT_UNCONFIGURED);
 
+	lock_device_hotplug();
 	for_each_cpu(cpu, mask) {
 		int err;
 
 		printk(KERN_INFO "ds-%llu: Shutting down cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_down(cpu);
+		err = device_offline(get_cpu_device(cpu));
 		if (err)
 			dr_cpu_mark(resp, cpu, ncpus,
 				    DR_CPU_RES_FAILURE,
 				    DR_CPU_STAT_CONFIGURED);
 	}
+	unlock_device_hotplug();
 
 	spin_lock_irqsave(&ds_lock, flags);
 	__ds_send(dp->lp, resp, resp_len);
-- 
2.17.1
