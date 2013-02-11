From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 11 Feb 2013 21:15:32 +0000
Subject: [PATCH] of: fix recursive locking in of_get_next_available_child()
Message-Id: <1360617332-2738-1-git-send-email-swarren@wwwdotorg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-next@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

of_get_next_available_child() acquires devtree_lock, then calls
of_device_is_available() which calls of_get_property() which calls
of_find_property() which tries to re-acquire devtree_lock, thus causing
deadlock.

To avoid this, create a new __of_device_is_available() which calls
__of_get_property() instead, which calls __of_find_property(), which
does not take the lock,. Update of_get_next_available_child() to call
the new __of_device_is_available() since it already owns the lock.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/of/base.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e8d65af..f7a87ce 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -290,19 +290,19 @@ int of_machine_is_compatible(const char *compat)
 EXPORT_SYMBOL(of_machine_is_compatible);
 
 /**
- *  of_device_is_available - check if a device is available for use
+ *  __of_device_is_available - check if a device is available for use
  *
- *  @device: Node to check for availability
+ *  @device: Node to check for availability, with locks already held
  *
  *  Returns 1 if the status property is absent or set to "okay" or "ok",
  *  0 otherwise
  */
-int of_device_is_available(const struct device_node *device)
+static int __of_device_is_available(const struct device_node *device)
 {
 	const char *status;
 	int statlen;
 
-	status = of_get_property(device, "status", &statlen);
+	status = __of_get_property(device, "status", &statlen);
 	if (status = NULL)
 		return 1;
 
@@ -313,6 +313,26 @@ int of_device_is_available(const struct device_node *device)
 
 	return 0;
 }
+
+/**
+ *  of_device_is_available - check if a device is available for use
+ *
+ *  @device: Node to check for availability
+ *
+ *  Returns 1 if the status property is absent or set to "okay" or "ok",
+ *  0 otherwise
+ */
+int of_device_is_available(const struct device_node *device)
+{
+	unsigned long flags;
+	int res;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	res = __of_device_is_available(device);
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	return res;
+
+}
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
@@ -404,7 +424,7 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 	raw_spin_lock(&devtree_lock);
 	next = prev ? prev->sibling : node->child;
 	for (; next; next = next->sibling) {
-		if (!of_device_is_available(next))
+		if (!__of_device_is_available(next))
 			continue;
 		if (of_node_get(next))
 			break;
-- 
1.7.10.4

