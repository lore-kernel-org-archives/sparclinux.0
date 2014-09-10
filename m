From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 14:18:22 +0000
Subject: Re: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <20140910141822.GD17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 05:52:46PM EDT]
> From: Bob Picco <bob.picco@oracle.com>
> Date: Tue, 9 Sep 2014 17:12:27 -0400
> 
> > I just ran a quick experiment on my T5-2 which is supported hardware. The
> > kernel is 3.17-rc3 without any modification from me - well ixgbe. As root mmap
> > of /dev/mem at address 0UL. It powered off:
> 
> Just out of curiosity what ixgbe patches do you need that aren't
> upstream already?
It is really Martin's (mkp) from last year. I ported it over to mainline.
Basically the mac is acquired with:
 addr = of_get_property(dp, "local-mac-address", &len);
. I'll append at the end of this email what my local T5-2 is using. 
> 
> > 4 GNU/Linux
> > [root@t5-2 ~]# [31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1
> > [31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>
> > [31732.380652] SUN4V-DTLB: O7[100970]
> > [31732.387418] SUN4V-DTLB: O7<0x100970>
> > [31732.394548] SUN4V-DTLB: vaddr[fffffc0100028000] ctx[1634] pte[9a00000000000610] error[2]
> > 
> > Message from syslogd@t5-2 at Sep  9 16:53:25 ...
> >  kernel:[31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1
> > 
> > Message from syslogd@t5-2 at Sep  9 16:53:25 ...
> >  kernel:[31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>
> > 
> > Message from syslogd@t5-2 at Sep  9 16:53:25 ...
> >  kernel:[31732.380652] SUN4V-DTLB: O7[102014-09-09 20:35:34     SP> NOTICE:  Host is off
> > . Some firmware widget we are unaware of?
> 
> Hmmm...
> 
> Oh I see, if LDOMs are enabled we do ldom_power_off() instead of doing
> an OF "exit".
> 
> That explains everything.
> 
> I seem to remember that for some reason after early boot it got to the
> point with LDOMs that you had to stop talking to the OF, and that's
> why for all of these interfaces that could be invoked after early
> boot, we revector to a ldom_*() routine if ldom_domaining_enabled is
> true.
I seem to remember encountering similar for kexec and start/stop strand but
that was long ago too :)
> 
> So I don't think there is anything we can do about this, so perhaps we
> should just unconditionally avoid using prom_halt() here, and just do
> a die_if_kernel() regardless of the trap level.
okay.
> 
> Also, for the >tl1 case, it would be beneficial to print out the stack
> of trap state registers that etraptl1 saves on the stack right after
> pt_regs.  The format is traps_64.c's "struct tl1_traplog", and there
> is a dump_tl1_traplog() helper there already.
okay.
> 
> Thanks for looking into this Bob.
You're welcome and thanx,

bob
<<ixgbe>>
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   32 +++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 87bd53f..bb37bd7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -49,6 +49,10 @@
 #include <linux/if_bridge.h>
 #include <linux/prefetch.h>
 #include <scsi/fc/fc_fcoe.h>
+#ifdef CONFIG_SPARC
+#include <asm/idprom.h>
+#include <asm/prom.h>
+#endif
 
 #include "ixgbe.h"
 #include "ixgbe_common.h"
@@ -8063,6 +8067,33 @@ int ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 	return is_wol_supported;
 }
 
+#ifdef CONFIG_SPARC
+/**
+ * ixgbe_mac_addr_sparc - Look up MAC address on SPARC
+ * @adapter: Pointer to adapter struct
+ */
+static void ixgbe_mac_addr_sparc(struct ixgbe_adapter *adapter)
+{
+	struct device_node *dp = pci_device_to_OF_node(adapter->pdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	const unsigned char *addr;
+	int len;
+
+	addr = of_get_property(dp, "local-mac-address", &len);
+	if (addr && len = 6) {
+		e_dev_info("Using OpenPROM MAC address\n");
+		memcpy(hw->mac.perm_addr, addr, 6);
+	}
+
+	if (!is_valid_ether_addr(hw->mac.perm_addr)) {
+		e_dev_info("Using IDPROM MAC address\n");
+		memcpy(hw->mac.perm_addr, idprom->id_ethaddr, 6);
+	}
+}
+#else
+static void ixgbe_mac_addr_sparc(struct ixgbe_adapter *adapter) {}
+#endif
+
 /**
  * ixgbe_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -8330,6 +8361,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_sw_init;
 	}
 
+	ixgbe_mac_addr_sparc(adapter);
 	memcpy(netdev->dev_addr, hw->mac.perm_addr, netdev->addr_len);
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
