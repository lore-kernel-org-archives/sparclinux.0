From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 13 Jan 2015 01:24:17 +0000
Subject: Re: [linux-nics] Solved: Re: ixgbe/linux/sparc perf issues
Message-Id: <20150113012417.GO20062@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150109152118.GA6560@oracle.com>
In-Reply-To: <20150109152118.GA6560@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/13/15 01:08), Tantilov, Emil S wrote:
>
> Relaxed ordering is disabled by default at init and the driver only
> enables it for reads when DCA is used, which I suppose is not the case
> for you since you are on sparc.
   :
> Relaxed ordering was disabled due to an issue with some chipsets. There
> is a comment to that effect when enabling relaxed ordering for reads in
> ixgbe_update_tx_dca(). This was done back in 2011, so I'm still trying
> to dig through the details.

> As I mentioned above it is intentional. I guess it makes sense to
> have it enabled for chipsets where it helps with performance, but I'm
> not sure what the criteria should be. In your patch below you enable
> relaxed ordering for writes - have you tested if there is any effect if
> you enable it only for reads or both?

I'm not sure how to instrument reads separately from writes?
In my case (tested with iperf, 10 threads) I'm guessing both happen 
at some point. But the effect of the absence of RO is seen most clearly
for iperf acting as the Rx (i.e., lot of incoming TCP traffic from a
remote host, relatively little outgoing TCP traffic).

FWIW,  I based my patch on the equivalent solaris driver code, which has
an indirection per chipset, resulting in something like the patch below
(which I'm still testing on sparc/x86 with X540/82598). But the concern
is that we may need this fix in other related drivers like igb- I
havent tested each driver yet.

I think the perf throttle might not be seen on x86 because of DCA
and other enhancements that are not available on sparc? 

-----------------------------------------------------------------------

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index c5c97b4..85c7a28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -1161,6 +1161,7 @@ static struct ixgbe_mac_operations mac_ops_82598 = {
 	.clear_hw_cntrs		= &ixgbe_clear_hw_cntrs_generic,
 	.get_media_type		= &ixgbe_get_media_type_82598,
 	.enable_rx_dma          = &ixgbe_enable_rx_dma_generic,
+	.enable_relaxed_ordering = &ixgbe_enable_relaxed_ordering,
 	.get_mac_addr		= &ixgbe_get_mac_addr_generic,
 	.stop_adapter		= &ixgbe_stop_adapter_generic,
 	.get_bus_info           = &ixgbe_get_bus_info_generic,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 9c66bab..4453d92 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -338,6 +338,26 @@ s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
 	return 0;
 }
 
+void ixgbe_enable_relaxed_ordering(struct ixgbe_hw *hw)
+{
+	u32 i;
+	u32 regval;
+
+	/* Enable relaxed ordering */
+	for (i = 0; i < hw->mac.max_tx_queues; i++) {
+		regval = IXGBE_READ_REG(hw, IXGBE_DCA_TXCTRL_82599(i));
+		regval |= IXGBE_DCA_TXCTRL_DESC_WRO_EN;
+		IXGBE_WRITE_REG(hw, IXGBE_DCA_TXCTRL_82599(i), regval);
+	}
+
+	for (i = 0; i < hw->mac.max_rx_queues; i++) {
+		regval = IXGBE_READ_REG(hw, IXGBE_DCA_RXCTRL(i));
+		regval |= (IXGBE_DCA_RXCTRL_DATA_WRO_EN |
+			    IXGBE_DCA_RXCTRL_HEAD_WRO_EN);
+		IXGBE_WRITE_REG(hw, IXGBE_DCA_RXCTRL(i), regval);
+	}
+}
+
 /**
  *  ixgbe_init_hw_generic - Generic hardware initialization
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 8cfadcb..c399c18 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -37,6 +37,7 @@ s32 ixgbe_init_ops_generic(struct ixgbe_hw *hw);
 s32 ixgbe_init_hw_generic(struct ixgbe_hw *hw);
 s32 ixgbe_start_hw_generic(struct ixgbe_hw *hw);
 s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw);
+void ixgbe_enable_relaxed_ordering(struct ixgbe_hw *hw);
 s32 ixgbe_clear_hw_cntrs_generic(struct ixgbe_hw *hw);
 s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 				  u32 pba_num_size);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2ed2c7d..a35a264 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4898,6 +4898,9 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_reset(adapter);
+
+	if (hw->mac.ops.enable_relaxed_ordering)
+		hw->mac.ops.enable_relaxed_ordering(hw);
 }
 
 /**
@@ -8470,6 +8473,8 @@ skip_sriov:
 			   "representative who provided you with this "
 			   "hardware.\n");
 	}
+	if (hw->mac.ops.enable_relaxed_ordering)
+		hw->mac.ops.enable_relaxed_ordering(hw);
 	strcpy(netdev->name, "eth%d");
 	err = register_netdev(netdev);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index d101b25..b967241 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3013,6 +3013,7 @@ struct ixgbe_mac_operations {
 	void (*release_swfw_sync)(struct ixgbe_hw *, u32);
 	s32 (*prot_autoc_read)(struct ixgbe_hw *, bool *, u32 *);
 	s32 (*prot_autoc_write)(struct ixgbe_hw *, u32, bool);
+	void (*enable_relaxed_ordering)(struct ixgbe_hw *);
 
 	/* Link */
 	void (*disable_tx_laser)(struct ixgbe_hw *);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index ba54ff0..88adad2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -781,6 +781,7 @@ static struct ixgbe_mac_operations mac_ops_X540 = {
 	.clear_hw_cntrs         = &ixgbe_clear_hw_cntrs_generic,
 	.get_media_type         = &ixgbe_get_media_type_X540,
 	.enable_rx_dma          = &ixgbe_enable_rx_dma_generic,
+	.enable_relaxed_ordering = &ixgbe_enable_relaxed_ordering,
 	.get_mac_addr           = &ixgbe_get_mac_addr_generic,
 	.get_san_mac_addr       = &ixgbe_get_san_mac_addr_generic,
 	.get_device_caps        = &ixgbe_get_device_caps_generic,
-- 
1.7.1

