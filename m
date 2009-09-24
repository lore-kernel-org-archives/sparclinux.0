From: hyl <heyongli@gmail.com>
Date: Thu, 24 Sep 2009 02:03:25 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <505766fa0909231903t2fe2f7b6y26d2681d6d38ef0e@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
	 <505766fa0909230040m13e3dc34x2ceb83848767d825@mail.gmail.com>
In-Reply-To: <505766fa0909230040m13e3dc34x2ceb83848767d825@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

From 57b549e5e4dfc8b34d66bbad7f4297a1bc81a43d Mon Sep 17 00:00:00 2001
From: Yongli He <heyongli@gmail.com>
Date: Thu, 24 Sep 2009 10:00:04 +0800
Subject: [PATCH] Sun ldom vnet driver dead lock

if 2 vnet attach to same vswitch, ldom will report
2 same irq then lead to dead lock on the lp->lock
or the vio->lock

static irqreturn_t ldc_rx(int irq, void *dev_id){
...
out:
	spin_unlock_irqrestore(&lp->lock, flags);
           << here run with out any lock
	send_events(lp, event_mask);
           >> vnet evetn process will dead lock on
           >> lp->lock or the vio->lock

Signed-off-by: Yongli He <heyongli@gmail.com>
---
 arch/sparc/include/asm/ldc.h |    1 +
 arch/sparc64/kernel/ldc.c    |    4 ++++
 drivers/net/sunvnet.c        |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index bdb524a..dd2b30f 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -20,6 +20,7 @@ extern void ldom_power_off(void);
  */
 struct ldc_channel_config {
 	void (*event)(void *arg, int event);
+	spinlock_t *serial_lock;

 	u32			mtu;
 	unsigned int		rx_irq;
diff --git a/arch/sparc64/kernel/ldc.c b/arch/sparc64/kernel/ldc.c
index a6b75cd..72b9501 100644
--- a/arch/sparc64/kernel/ldc.c
+++ b/arch/sparc64/kernel/ldc.c
@@ -892,9 +892,13 @@ handshake_complete:
 	}

 out:
+	if(lp->cfg.serial_lock)
+		spin_lock_irqsave(lp->cfg.serial_lock, flags);
 	spin_unlock_irqrestore(&lp->lock, flags);

 	send_events(lp, event_mask);
+	if(lp->cfg.serial_lock)
+        	spin_unlock_irqrestore(lp->cfg.serial_lock, flags);

 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/sunvnet.c b/drivers/net/sunvnet.c
index 6415ce1..e58f9da 100644
--- a/drivers/net/sunvnet.c
+++ b/drivers/net/sunvnet.c
@@ -1117,11 +1117,13 @@ static struct vnet * __devinit
vnet_find_parent(struct mdesc_handle *hp,

 	return vnet_find_or_create(local_mac);
 }
+static spinlock_t event_lock=__SPIN_LOCK_UNLOCKED("vnet_event");

 static struct ldc_channel_config vnet_ldc_cfg = {
 	.event		= vnet_event,
 	.mtu		= 64,
 	.mode		= LDC_MODE_UNRELIABLE,
+	.serial_lock	= &event_lock,
 };

 static struct vio_driver_ops vnet_vio_ops = {
-- 
1.5.5.1.dirty
