From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 14 Mar 2009 14:43:07 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <49BBC27B.4050200@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070708000606030509080107"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708000606030509080107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Meelis Roos schrieb:
> [   60.565134] esp: probe of f0062a74 failed with error -12

I can reproduce this on my Ultra 2. I didn't notice it until now because
the boot disk is attached to an hme esp(which still works).

In esp_sbus_map_regs the of_ioremap call failes because res->start is 0
for non hme cards.

Basicly your tree looks like this:

SUNW,Ultra-1
  sbus
    SUNW,fas
    espdma
      esp

Of_bus_sbus_match works for "SUNW,fas" but not for "esp" because it only
checks the direct parent and not the parent's parent for name == "sbus".

This makes the kernel use of_bus_default_count_cells to calculate the
resources for "esp" instead of of_bus_sbus_count_cells.
And since of_bus_default_count_cells doesn't work for sbus systems the
resources of "esp" aren't detected.

I attached a patch, let me know if it works for you.

Cheers,
Friedrich

--------------070708000606030509080107
Content-Type: text/x-patch;
 name="of_bus_sbus_match.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_bus_sbus_match.patch"

sparc: of_bus_sbus_match must also check the parent's parents.

To determine wheter the bus is sbus not only the direct parent but all the
parents of the parent must be checked, too.

In a tree like this

SUNW,Ultra-2
  sbus
    SUNW,hme
    SUNW,fas
    dma/espdma
      esp

only checking the direct parent would make of_match_bus use
of_bus_default_count_cells for "esp", instead of the desired
of_bus_sbus_count_cells, and return an incorrect cell count. Which, in this
case, would make allocating resources for "esp" fail.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Friedrich Oslage <bluebird@gentoo.org>
---
 arch/sparc/kernel/of_device_32.c |   13 +++++++++++--
 arch/sparc/kernel/of_device_64.c |   13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..bee16a5 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -246,8 +246,17 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 
 static int of_bus_sbus_match(struct device_node *np)
 {
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
+	/* return true if the direct parent or any of the parent's parents is
+	 * "sbus" or "sbi"
+	 */
+	struct device_node *dp = np;
+
+	do {
+		if (!strcmp(dp->name, "sbus") || !strcmp(dp->name, "sbi"))
+			return 1;
+	} while ((dp = dp->parent));
+
+	return 0;
 }
 
 static void of_bus_sbus_count_cells(struct device_node *child,
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index b4a12c9..7a27cfd 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -301,8 +301,17 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 
 static int of_bus_sbus_match(struct device_node *np)
 {
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
+	/* return true if the direct parent or any of the parent's parents is
+	 * "sbus" or "sbi"
+	 */
+	struct device_node *dp = np;
+
+	do {
+		if (!strcmp(dp->name, "sbus") || !strcmp(dp->name, "sbi"))
+			return 1;
+	} while ((dp = dp->parent));
+
+	return 0;
 }
 
 static void of_bus_sbus_count_cells(struct device_node *child,

--------------070708000606030509080107--
