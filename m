From: David Miller <davem@davemloft.net>
Date: Mon, 09 Nov 2009 01:41:34 +0000
Subject: Re: [patch] sparc: Remove bogus of_set_property_mutex
Message-Id: <20091108.174134.45234225.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091107184538.543684450@linutronix.de>
In-Reply-To: <20091107184538.543684450@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 8 Nov 2009 21:16:47 +0100 (CET)

> Then you need to fix the problem that you lock the mutex inside the
> preempt disabled region under devtree_lock. :)

That's simple, just move it outside the rwlock:

sparc: Move of_set_property_mutex acquisition outside of devtree_lock grab.

Otherwise we try to sleep with preemption disabled, etc.

Noticed by Thomas Gleixner.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 138910c..d80a65d 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -79,6 +79,7 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 
 	err = -ENODEV;
 
+	mutex_lock(&of_set_property_mutex);
 	write_lock(&devtree_lock);
 	prevp = &dp->properties;
 	while (*prevp) {
@@ -88,9 +89,7 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 			void *old_val = prop->value;
 			int ret;
 
-			mutex_lock(&of_set_property_mutex);
 			ret = prom_setprop(dp->node, name, val, len);
-			mutex_unlock(&of_set_property_mutex);
 
 			err = -EINVAL;
 			if (ret >= 0) {
@@ -109,6 +108,7 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 		prevp = &(*prevp)->next;
 	}
 	write_unlock(&devtree_lock);
+	mutex_unlock(&of_set_property_mutex);
 
 	/* XXX Upate procfs if necessary... */
 
-- 
1.6.5.2

