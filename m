From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2009 09:16:31 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090421.021631.00852238.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Apr 2009 12:16:21 +0300 (EEST)

>> Ok, following through on this... Here is how I would like to
>> fix this bug.
>> 
>> sparc: Fix bus type probing for ESP and LE devices.
>> 
>> If there is a dummy "espdma" or "ledma" parent device above ESP scsi
>> or LE ethernet device nodes, we have to match the bus as SBUS.
> 
> Unfortunately it does not work, onboard ESP is still not detected on my 
> Ultra 1.

Silly bug in that patch, I forgot to substitude "np" with "dp" in
the name tests that got moved into the loop.

Please try this patch instead.

Thanks!

sparc: Fix bus type probing for ESP and LE devices.

If there is a dummy "espdma" or "ledma" parent device above ESP scsi
or LE ethernet device nodes, we have to match the bus as SBUS.

Otherwise the address and size cell counts are wrong and we don't
calculate the final physical device resource values correctly at all.

Commit 5280267c1dddb8d413595b87dc406624bb497946 ("sparc: Fix handling
of LANCE and ESP parent nodes in of_device.c") was meant to fix this
problem, but that only influences the inner loop of
build_device_resources().  We need this logic to also kick in at the
beginning of build_device_resources() as well, when we make the first
attempt to determine the device's immediate parent bus type for 'reg'
property element extraction.

Based almost entirely upon a patch by Friedrich Oslage.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/of_device_32.c |   21 +++++++++++++++++++--
 arch/sparc/kernel/of_device_64.c |   21 +++++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..c8f14c1 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -246,8 +246,25 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 
 static int of_bus_sbus_match(struct device_node *np)
 {
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
+	struct device_node *dp = np;
+
+	while (dp) {
+		if (!strcmp(dp->name, "sbus") ||
+		    !strcmp(dp->name, "sbi"))
+			return 1;
+
+		/* Have a look at use_1to1_mapping().  We're trying
+		 * to match SBUS if that's the top-level bus and we
+		 * don't have some intervening real bus that provides
+		 * ranges based translations.
+		 */
+		if (of_find_property(dp, "ranges", NULL) != NULL)
+			break;
+
+		dp = dp->parent;
+	}
+
+	return 0;
 }
 
 static void of_bus_sbus_count_cells(struct device_node *child,
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 27381f1..5ac287a 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -300,8 +300,25 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 
 static int of_bus_sbus_match(struct device_node *np)
 {
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
+	struct device_node *dp = np;
+
+	while (dp) {
+		if (!strcmp(dp->name, "sbus") ||
+		    !strcmp(dp->name, "sbi"))
+			return 1;
+
+		/* Have a look at use_1to1_mapping().  We're trying
+		 * to match SBUS if that's the top-level bus and we
+		 * don't have some intervening real bus that provides
+		 * ranges based translations.
+		 */
+		if (of_find_property(dp, "ranges", NULL) != NULL)
+			break;
+
+		dp = dp->parent;
+	}
+
+	return 0;
 }
 
 static void of_bus_sbus_count_cells(struct device_node *child,
-- 
1.6.2.4

