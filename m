From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 09 Jan 2015 15:21:18 +0000
Subject: Solved: Re: ixgbe/linux/sparc perf issues
Message-Id: <20150109152118.GA6560@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Thu, 11 Dec 2014 14:45:42 -0500
> I'm looking at an iperf issue running over ixgbe on linux
> on a sparc T5-2 platform (64 cpu) where we cannot get to line-speed
> (peaks at 3 Gbps on a 10Gbps link) and I'm trying to get to the bottom
> of this.

On (12/11/14 15:09), David Miller replied:
davem> The real overhead is unavoidable due to the way the hypervisor access
davem> to the IOMMU is implemented in sun4v.
       :
davem> I've known about this issue for a decade and I do not think there is
davem> anything we can really do about this.

Not so.

The HV implementation can handle 1 (maybe even 2) NIC ports per
socket on a T5-2 without needing any additional DMA optimizations.

The real problem is that the ixgbe driver (and probably a few other
related drivers?) turns off relaxed-ordering during startup (not
sure why) and never turns it back on.

The absence of relaxed-ordering is a serous serialization point,
and is responsible for throttling throughput down to 3 Gbps.

After I hack things as shown in the patch below, I am able to easily
get 9-9.5 Gbps. (The only other patch needed is the iommu lock-break-up:
http://www.spinics.net/lists/sparclinux/msg13238.html)

Perhaps someone in e1000-devel/linux.nics can provide some background 
here on when this really needs to be turned off, and where to turn it back 
on cleanly.

I'm sure there are more drivers than ixgbe that have this crippling bug. 

there is another oddity that 'lspci -vv' reports RlxOrd as enabled,
even though this is clearly not the case, but that's a secondary issue.

--Sowmini

-----------patch follows below ---------------------------------------------


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
index 2ed2c7d..e97c89c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4898,6 +4898,7 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_reset(adapter);
+	ixgbe_enable_relaxed_ordering(hw);
 }
 
 /**
@@ -8470,6 +8471,7 @@ skip_sriov:
 			   "representative who provided you with this "
 			   "hardware.\n");
 	}
+	ixgbe_enable_relaxed_ordering(hw);
 	strcpy(netdev->name, "eth%d");
 	err = register_netdev(netdev);
 	if (err)

