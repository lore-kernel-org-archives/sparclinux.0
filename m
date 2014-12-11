From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 11 Dec 2014 19:45:42 +0000
Subject: ixgbe/linux/sparc perf issues
Message-Id: <20141211194542.GA5536@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

e1000-developers,

[Cc-ing sparclinux due to the iommu observations..]

I'm looking at an iperf issue running over ixgbe on linux 
on a sparc T5-2 platform (64 cpu) where we cannot get to line-speed
(peaks at 3 Gbps on a 10Gbps link) and I'm trying to get to the bottom
of this.

I've run iperf with 8 threads. Observations are
1. lockstat and perf report that iommu->lock is the hot-lock (in a typical 
   instance, I get about 21M contentions out of 27M acquisitions, 25 us
   avg wait time). Even if I fix this issue (see below), I see:
2. ethtool stat: rx_missed_errors and/or rx_no_dma_resources
   goes up (even with just one iperf thread).

Disabling IOMMU is not an option on this arch (sun4v). 
But I tried a fix to mitigate #1 by breaking up the iommu map/lock
into locks with finer granularity for map-pools, similar to the 
design for iommu on powerpc.  That fix takes care of the lockstat output,
but it shows lot of latency for packet receive (14 us wait time on
socket lock without RPS, and even with RPS, the rcu lock has a high
wait time), and throughput still cannot go beyond the 3 Gbps limit. 
This suggests that #2 needs to be solved first.

I dont think this is a setup issue, though I could be mistaken: 
when I boot solaris on the exact same hardware config, I am able to get
a throughput of approx 9.4 Gbps. 

There are other things one could do, to ameliorate iommu overhead on this
e.g., keep a cache of premapped buffers for small packets (such as the
TCP ACK, for example) with a configurable threshold defining "small". 

But before I go too far into experimenting with those things, I wanted
to check with e1000-devel to see if this just sub-optimal tuning of
the ixgbe driver. 

Attached are the output of the commands (listed in the order they appear 
below) for a single iperf thread (similar stats issues are there even in
the 1 thread case)
  ethtool -i eth1
  lspci -vvv -s <bus>
  ethtool -k eth1
  ethtool -S eth1 

Any insights or tuning-recommendations would be appreciated,

--Sowmini


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eth1.out"

#ethtool -i eth1
driver: ixgbe
version: 3.19.1-k
firmware-version: 0x800003ed
bus-info: 0001:03:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

#  lspci -vvv -s  0001:03:00.1
0001:03:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
	Subsystem: Oracle/SUN Device 4848
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 00000008
	Region 0: Memory at 100600000 (64-bit, prefetchable) [size=2M]
	Region 2: I/O ports at 00000020 [disabled] [size=32]
	Region 3: [virtual] Memory at ffff7ff000000000 (32-bit, non-prefetchable)
	Region 4: Memory at 100404000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM at ffff7ff000000000 [disabled]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #14, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 unlimited, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 1515
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 0000000100408000 (64-bit, non-prefetchable)
		Region 3: Memory at 0000000100800000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1d0 v1] #00
	Kernel driver in use: ixgbe

# ethtool -k eth1

Features for eth1:
rx-checksumming: on
tx-checksumming: on
	tx-checksum-ipv4: on
	tx-checksum-ip-generic: off [fixed]
	tx-checksum-ipv6: on
	tx-checksum-fcoe-crc: on [fixed]
	tx-checksum-sctp: on
scatter-gather: on
	tx-scatter-gather: on
	tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
	tx-tcp-segmentation: on
	tx-tcp-ecn-segmentation: off [fixed]
	tx-tcp6-segmentation: on
udp-fragmentation-offload: off [fixed]
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: on
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: off
receive-hashing: on
highdma: off [fixed]
rx-vlan-filter: on
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: on [fixed]
tx-gre-segmentation: off [fixed]
tx-ipip-segmentation: off [fixed]
tx-sit-segmentation: off [fixed]
tx-udp_tnl-segmentation: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off
busy-poll: on [fixed]

# ethtool -S eth1
NIC statistics:
     rx_packets: 220128
     tx_packets: 204836
     rx_bytes: 2380216166
     tx_bytes: 13570184
     rx_pkts_nic: 1671338
     tx_pkts_nic: 204836
     rx_bytes_nic: 2482727634
     tx_bytes_nic: 14389744
     lsc_int: 1
     tx_busy: 0
     non_eop_descs: 1079192
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 0
     tx_dropped: 0
     multicast: 0
     broadcast: 11
     rx_no_buffer_count: 0
     collisions: 0
     rx_over_errors: 0
     rx_crc_errors: 0
     rx_frame_errors: 0
     hw_rsc_aggregated: 1671235
     hw_rsc_flushed: 220059
     fdir_match: 1671318
     fdir_miss: 1
     fdir_overflow: 0
     rx_fifo_errors: 0
     rx_missed_errors: 0
     tx_aborted_errors: 0
     tx_carrier_errors: 0
     tx_fifo_errors: 0
     tx_heartbeat_errors: 0
     tx_timeout_count: 0
     tx_restart_queue: 0
     rx_long_length_errors: 0
     rx_short_length_errors: 0
     tx_flow_control_xon: 0
     rx_flow_control_xon: 0
     tx_flow_control_xoff: 0
     rx_flow_control_xoff: 0
     rx_csum_offload_errors: 0
     alloc_rx_page_failed: 0
     alloc_rx_buff_failed: 0
     rx_no_dma_resources: 34
     os2bmc_rx_by_bmc: 0
     os2bmc_tx_by_bmc: 0
     os2bmc_tx_by_host: 0
     os2bmc_rx_by_host: 0
     fcoe_bad_fccrc: 0
     rx_fcoe_dropped: 0
     rx_fcoe_packets: 0
     rx_fcoe_dwords: 0
     fcoe_noddp: 0
     fcoe_noddp_ext_buff: 0
     tx_fcoe_packets: 0
     tx_fcoe_dwords: 0
     tx_queue_0_packets: 6521
     tx_queue_0_bytes: 432138
     tx_queue_0_bp_napi_yield: 0
     tx_queue_0_bp_misses: 0
     tx_queue_0_bp_cleaned: 0
     tx_queue_1_packets: 6383
     tx_queue_1_bytes: 422466
     tx_queue_1_bp_napi_yield: 0
     tx_queue_1_bp_misses: 0
     tx_queue_1_bp_cleaned: 0
     tx_queue_2_packets: 6520
     tx_queue_2_bytes: 431508
     tx_queue_2_bp_napi_yield: 0
     tx_queue_2_bp_misses: 0
     tx_queue_2_bp_cleaned: 0
     tx_queue_3_packets: 0
     tx_queue_3_bytes: 0
     tx_queue_3_bp_napi_yield: 0
     tx_queue_3_bp_misses: 0
     tx_queue_3_bp_cleaned: 0
     tx_queue_4_packets: 0
     tx_queue_4_bytes: 0
     tx_queue_4_bp_napi_yield: 0
     tx_queue_4_bp_misses: 0
     tx_queue_4_bp_cleaned: 0
     tx_queue_5_packets: 22
     tx_queue_5_bytes: 1452
     tx_queue_5_bp_napi_yield: 0
     tx_queue_5_bp_misses: 0
     tx_queue_5_bp_cleaned: 0
     tx_queue_6_packets: 0
     tx_queue_6_bytes: 0
     tx_queue_6_bp_napi_yield: 0
     tx_queue_6_bp_misses: 0
     tx_queue_6_bp_cleaned: 0
     tx_queue_7_packets: 141
     tx_queue_7_bytes: 9354
     tx_queue_7_bp_napi_yield: 0
     tx_queue_7_bp_misses: 0
     tx_queue_7_bp_cleaned: 0
     tx_queue_8_packets: 139
     tx_queue_8_bytes: 9714
     tx_queue_8_bp_napi_yield: 0
     tx_queue_8_bp_misses: 0
     tx_queue_8_bp_cleaned: 0
     tx_queue_9_packets: 6382
     tx_queue_9_bytes: 422520
     tx_queue_9_bp_napi_yield: 0
     tx_queue_9_bp_misses: 0
     tx_queue_9_bp_cleaned: 0
     tx_queue_10_packets: 6460
     tx_queue_10_bytes: 427668
     tx_queue_10_bp_napi_yield: 0
     tx_queue_10_bp_misses: 0
     tx_queue_10_bp_cleaned: 0
     tx_queue_11_packets: 6321
     tx_queue_11_bytes: 418638
     tx_queue_11_bp_napi_yield: 0
     tx_queue_11_bp_misses: 0
     tx_queue_11_bp_cleaned: 0
     tx_queue_12_packets: 12
     tx_queue_12_bytes: 792
     tx_queue_12_bp_napi_yield: 0
     tx_queue_12_bp_misses: 0
     tx_queue_12_bp_cleaned: 0
     tx_queue_13_packets: 6305
     tx_queue_13_bytes: 417306
     tx_queue_13_bp_napi_yield: 0
     tx_queue_13_bp_misses: 0
     tx_queue_13_bp_cleaned: 0
     tx_queue_14_packets: 118
     tx_queue_14_bytes: 7788
     tx_queue_14_bp_napi_yield: 0
     tx_queue_14_bp_misses: 0
     tx_queue_14_bp_cleaned: 0
     tx_queue_15_packets: 8423
     tx_queue_15_bytes: 558030
     tx_queue_15_bp_napi_yield: 0
     tx_queue_15_bp_misses: 0
     tx_queue_15_bp_cleaned: 0
     tx_queue_16_packets: 8406
     tx_queue_16_bytes: 556200
     tx_queue_16_bp_napi_yield: 0
     tx_queue_16_bp_misses: 0
     tx_queue_16_bp_cleaned: 0
     tx_queue_17_packets: 162
     tx_queue_17_bytes: 10704
     tx_queue_17_bp_napi_yield: 0
     tx_queue_17_bp_misses: 0
     tx_queue_17_bp_cleaned: 0
     tx_queue_18_packets: 73
     tx_queue_18_bytes: 4830
     tx_queue_18_bp_napi_yield: 0
     tx_queue_18_bp_misses: 0
     tx_queue_18_bp_cleaned: 0
     tx_queue_19_packets: 6521
     tx_queue_19_bytes: 431826
     tx_queue_19_bp_napi_yield: 0
     tx_queue_19_bp_misses: 0
     tx_queue_19_bp_cleaned: 0
     tx_queue_20_packets: 0
     tx_queue_20_bytes: 0
     tx_queue_20_bp_napi_yield: 0
     tx_queue_20_bp_misses: 0
     tx_queue_20_bp_cleaned: 0
     tx_queue_21_packets: 6461
     tx_queue_21_bytes: 427794
     tx_queue_21_bp_napi_yield: 0
     tx_queue_21_bp_misses: 0
     tx_queue_21_bp_cleaned: 0
     tx_queue_22_packets: 6622
     tx_queue_22_bytes: 438612
     tx_queue_22_bp_napi_yield: 0
     tx_queue_22_bp_misses: 0
     tx_queue_22_bp_cleaned: 0
     tx_queue_23_packets: 103
     tx_queue_23_bytes: 6930
     tx_queue_23_bp_napi_yield: 0
     tx_queue_23_bp_misses: 0
     tx_queue_23_bp_cleaned: 0
     tx_queue_24_packets: 8643
     tx_queue_24_bytes: 573090
     tx_queue_24_bp_napi_yield: 0
     tx_queue_24_bp_misses: 0
     tx_queue_24_bp_cleaned: 0
     tx_queue_25_packets: 8670
     tx_queue_25_bytes: 573708
     tx_queue_25_bp_napi_yield: 0
     tx_queue_25_bp_misses: 0
     tx_queue_25_bp_cleaned: 0
     tx_queue_26_packets: 101
     tx_queue_26_bytes: 6666
     tx_queue_26_bp_napi_yield: 0
     tx_queue_26_bp_misses: 0
     tx_queue_26_bp_cleaned: 0
     tx_queue_27_packets: 7
     tx_queue_27_bytes: 462
     tx_queue_27_bp_napi_yield: 0
     tx_queue_27_bp_misses: 0
     tx_queue_27_bp_cleaned: 0
     tx_queue_28_packets: 63
     tx_queue_28_bytes: 4182
     tx_queue_28_bp_napi_yield: 0
     tx_queue_28_bp_misses: 0
     tx_queue_28_bp_cleaned: 0
     tx_queue_29_packets: 6522
     tx_queue_29_bytes: 431568
     tx_queue_29_bp_napi_yield: 0
     tx_queue_29_bp_misses: 0
     tx_queue_29_bp_cleaned: 0
     tx_queue_30_packets: 6428
     tx_queue_30_bytes: 426284
     tx_queue_30_bp_napi_yield: 0
     tx_queue_30_bp_misses: 0
     tx_queue_30_bp_cleaned: 0
     tx_queue_31_packets: 58
     tx_queue_31_bytes: 3876
     tx_queue_31_bp_napi_yield: 0
     tx_queue_31_bp_misses: 0
     tx_queue_31_bp_cleaned: 0
     tx_queue_32_packets: 160
     tx_queue_32_bytes: 10560
     tx_queue_32_bp_napi_yield: 0
     tx_queue_32_bp_misses: 0
     tx_queue_32_bp_cleaned: 0
     tx_queue_33_packets: 8842
     tx_queue_33_bytes: 589184
     tx_queue_33_bp_napi_yield: 0
     tx_queue_33_bp_misses: 0
     tx_queue_33_bp_cleaned: 0
     tx_queue_34_packets: 8556
     tx_queue_34_bytes: 566928
     tx_queue_34_bp_napi_yield: 0
     tx_queue_34_bp_misses: 0
     tx_queue_34_bp_cleaned: 0
     tx_queue_35_packets: 3
     tx_queue_35_bytes: 198
     tx_queue_35_bp_napi_yield: 0
     tx_queue_35_bp_misses: 0
     tx_queue_35_bp_cleaned: 0
     tx_queue_36_packets: 60
     tx_queue_36_bytes: 3984
     tx_queue_36_bp_napi_yield: 0
     tx_queue_36_bp_misses: 0
     tx_queue_36_bp_cleaned: 0
     tx_queue_37_packets: 0
     tx_queue_37_bytes: 0
     tx_queue_37_bp_napi_yield: 0
     tx_queue_37_bp_misses: 0
     tx_queue_37_bp_cleaned: 0
     tx_queue_38_packets: 6402
     tx_queue_38_bytes: 423468
     tx_queue_38_bp_napi_yield: 0
     tx_queue_38_bp_misses: 0
     tx_queue_38_bp_cleaned: 0
     tx_queue_39_packets: 6562
     tx_queue_39_bytes: 434796
     tx_queue_39_bp_napi_yield: 0
     tx_queue_39_bp_misses: 0
     tx_queue_39_bp_cleaned: 0
     tx_queue_40_packets: 83
     tx_queue_40_bytes: 5478
     tx_queue_40_bp_napi_yield: 0
     tx_queue_40_bp_misses: 0
     tx_queue_40_bp_cleaned: 0
     tx_queue_41_packets: 198
     tx_queue_41_bytes: 13772
     tx_queue_41_bp_napi_yield: 0
     tx_queue_41_bp_misses: 0
     tx_queue_41_bp_cleaned: 0
     tx_queue_42_packets: 8605
     tx_queue_42_bytes: 569970
     tx_queue_42_bp_napi_yield: 0
     tx_queue_42_bp_misses: 0
     tx_queue_42_bp_cleaned: 0
     tx_queue_43_packets: 138
     tx_queue_43_bytes: 9204
     tx_queue_43_bp_napi_yield: 0
     tx_queue_43_bp_misses: 0
     tx_queue_43_bp_cleaned: 0
     tx_queue_44_packets: 8703
     tx_queue_44_bytes: 576522
     tx_queue_44_bp_napi_yield: 0
     tx_queue_44_bp_misses: 0
     tx_queue_44_bp_cleaned: 0
     tx_queue_45_packets: 64
     tx_queue_45_bytes: 4488
     tx_queue_45_bp_napi_yield: 0
     tx_queue_45_bp_misses: 0
     tx_queue_45_bp_cleaned: 0
     tx_queue_46_packets: 6748
     tx_queue_46_bytes: 447060
     tx_queue_46_bp_napi_yield: 0
     tx_queue_46_bp_misses: 0
     tx_queue_46_bp_cleaned: 0
     tx_queue_47_packets: 6522
     tx_queue_47_bytes: 431988
     tx_queue_47_bp_napi_yield: 0
     tx_queue_47_bp_misses: 0
     tx_queue_47_bp_cleaned: 0
     tx_queue_48_packets: 6442
     tx_queue_48_bytes: 426504
     tx_queue_48_bp_napi_yield: 0
     tx_queue_48_bp_misses: 0
     tx_queue_48_bp_cleaned: 0
     tx_queue_49_packets: 3
     tx_queue_49_bytes: 198
     tx_queue_49_bp_napi_yield: 0
     tx_queue_49_bp_misses: 0
     tx_queue_49_bp_cleaned: 0
     tx_queue_50_packets: 72
     tx_queue_50_bytes: 4752
     tx_queue_50_bp_napi_yield: 0
     tx_queue_50_bp_misses: 0
     tx_queue_50_bp_cleaned: 0
     tx_queue_51_packets: 18
     tx_queue_51_bytes: 1188
     tx_queue_51_bp_napi_yield: 0
     tx_queue_51_bp_misses: 0
     tx_queue_51_bp_cleaned: 0
     tx_queue_52_packets: 142
     tx_queue_52_bytes: 9420
     tx_queue_52_bp_napi_yield: 0
     tx_queue_52_bp_misses: 0
     tx_queue_52_bp_cleaned: 0
     tx_queue_53_packets: 0
     tx_queue_53_bytes: 0
     tx_queue_53_bp_napi_yield: 0
     tx_queue_53_bp_misses: 0
     tx_queue_53_bp_cleaned: 0
     tx_queue_54_packets: 0
     tx_queue_54_bytes: 0
     tx_queue_54_bp_napi_yield: 0
     tx_queue_54_bp_misses: 0
     tx_queue_54_bp_cleaned: 0
     tx_queue_55_packets: 6461
     tx_queue_55_bytes: 427818
     tx_queue_55_bp_napi_yield: 0
     tx_queue_55_bp_misses: 0
     tx_queue_55_bp_cleaned: 0
     tx_queue_56_packets: 0
     tx_queue_56_bytes: 0
     tx_queue_56_bp_napi_yield: 0
     tx_queue_56_bp_misses: 0
     tx_queue_56_bp_cleaned: 0
     tx_queue_57_packets: 69
     tx_queue_57_bytes: 4554
     tx_queue_57_bp_napi_yield: 0
     tx_queue_57_bp_misses: 0
     tx_queue_57_bp_cleaned: 0
     tx_queue_58_packets: 162
     tx_queue_58_bytes: 10704
     tx_queue_58_bp_napi_yield: 0
     tx_queue_58_bp_misses: 0
     tx_queue_58_bp_cleaned: 0
     tx_queue_59_packets: 14
     tx_queue_59_bytes: 924
     tx_queue_59_bp_napi_yield: 0
     tx_queue_59_bp_misses: 0
     tx_queue_59_bp_cleaned: 0
     tx_queue_60_packets: 8607
     tx_queue_60_bytes: 569946
     tx_queue_60_bp_napi_yield: 0
     tx_queue_60_bp_misses: 0
     tx_queue_60_bp_cleaned: 0
     tx_queue_61_packets: 125
     tx_queue_61_bytes: 8250
     tx_queue_61_bp_napi_yield: 0
     tx_queue_61_bp_misses: 0
     tx_queue_61_bp_cleaned: 0
     tx_queue_62_packets: 8488
     tx_queue_62_bytes: 562220
     tx_queue_62_bp_napi_yield: 0
     tx_queue_62_bp_misses: 0
     tx_queue_62_bp_cleaned: 0
     tx_queue_63_packets: 0
     tx_queue_63_bytes: 0
     tx_queue_63_bp_napi_yield: 0
     tx_queue_63_bp_misses: 0
     tx_queue_63_bp_cleaned: 0
     rx_queue_0_packets: 6885
     rx_queue_0_bytes: 74551584
     rx_queue_0_bp_poll_yield: 0
     rx_queue_0_bp_misses: 0
     rx_queue_0_bp_cleaned: 0
     rx_queue_1_packets: 6809
     rx_queue_1_bytes: 75222890
     rx_queue_1_bp_poll_yield: 0
     rx_queue_1_bp_misses: 0
     rx_queue_1_bp_cleaned: 0
     rx_queue_2_packets: 6987
     rx_queue_2_bytes: 76184958
     rx_queue_2_bp_poll_yield: 0
     rx_queue_2_bp_misses: 0
     rx_queue_2_bp_cleaned: 0
     rx_queue_3_packets: 0
     rx_queue_3_bytes: 0
     rx_queue_3_bp_poll_yield: 0
     rx_queue_3_bp_misses: 0
     rx_queue_3_bp_cleaned: 0
     rx_queue_4_packets: 1
     rx_queue_4_bytes: 74
     rx_queue_4_bp_poll_yield: 0
     rx_queue_4_bp_misses: 0
     rx_queue_4_bp_cleaned: 0
     rx_queue_5_packets: 12
     rx_queue_5_bytes: 26856
     rx_queue_5_bp_poll_yield: 0
     rx_queue_5_bp_misses: 0
     rx_queue_5_bp_cleaned: 0
     rx_queue_6_packets: 0
     rx_queue_6_bytes: 0
     rx_queue_6_bp_poll_yield: 0
     rx_queue_6_bp_misses: 0
     rx_queue_6_bp_cleaned: 0
     rx_queue_7_packets: 244
     rx_queue_7_bytes: 1091696
     rx_queue_7_bp_poll_yield: 0
     rx_queue_7_bp_misses: 0
     rx_queue_7_bp_cleaned: 0
     rx_queue_8_packets: 144
     rx_queue_8_bytes: 882160
     rx_queue_8_bp_poll_yield: 0
     rx_queue_8_bp_misses: 0
     rx_queue_8_bp_cleaned: 0
     rx_queue_9_packets: 6851
     rx_queue_9_bytes: 75176294
     rx_queue_9_bp_poll_yield: 0
     rx_queue_9_bp_misses: 0
     rx_queue_9_bp_cleaned: 0
     rx_queue_10_packets: 6920
     rx_queue_10_bytes: 75427616
     rx_queue_10_bp_poll_yield: 0
     rx_queue_10_bp_misses: 0
     rx_queue_10_bp_cleaned: 0
     rx_queue_11_packets: 6827
     rx_queue_11_bytes: 74797686
     rx_queue_11_bp_poll_yield: 0
     rx_queue_11_bp_misses: 0
     rx_queue_11_bp_cleaned: 0
     rx_queue_12_packets: 0
     rx_queue_12_bytes: 0
     rx_queue_12_bp_poll_yield: 0
     rx_queue_12_bp_misses: 0
     rx_queue_12_bp_cleaned: 0
     rx_queue_13_packets: 6822
     rx_queue_13_bytes: 75104476
     rx_queue_13_bp_poll_yield: 0
     rx_queue_13_bp_misses: 0
     rx_queue_13_bp_cleaned: 0
     rx_queue_14_packets: 157
     rx_queue_14_bytes: 858522
     rx_queue_14_bp_poll_yield: 0
     rx_queue_14_bp_misses: 0
     rx_queue_14_bp_cleaned: 0
     rx_queue_15_packets: 9139
     rx_queue_15_bytes: 99751782
     rx_queue_15_bp_poll_yield: 0
     rx_queue_15_bp_misses: 0
     rx_queue_15_bp_cleaned: 0
     rx_queue_16_packets: 9115
     rx_queue_16_bytes: 99043038
     rx_queue_16_bp_poll_yield: 0
     rx_queue_16_bp_misses: 0
     rx_queue_16_bp_cleaned: 0
     rx_queue_17_packets: 183
     rx_queue_17_bytes: 1142694
     rx_queue_17_bp_poll_yield: 0
     rx_queue_17_bp_misses: 0
     rx_queue_17_bp_cleaned: 0
     rx_queue_18_packets: 86
     rx_queue_18_bytes: 698348
     rx_queue_18_bp_poll_yield: 0
     rx_queue_18_bp_misses: 0
     rx_queue_18_bp_cleaned: 0
     rx_queue_19_packets: 7048
     rx_queue_19_bytes: 76672128
     rx_queue_19_bp_poll_yield: 0
     rx_queue_19_bp_misses: 0
     rx_queue_19_bp_cleaned: 0
     rx_queue_20_packets: 0
     rx_queue_20_bytes: 0
     rx_queue_20_bp_poll_yield: 0
     rx_queue_20_bp_misses: 0
     rx_queue_20_bp_cleaned: 0
     rx_queue_21_packets: 6870
     rx_queue_21_bytes: 74817188
     rx_queue_21_bp_poll_yield: 0
     rx_queue_21_bp_misses: 0
     rx_queue_21_bp_cleaned: 0
     rx_queue_22_packets: 6987
     rx_queue_22_bytes: 76917814
     rx_queue_22_bp_poll_yield: 0
     rx_queue_22_bp_misses: 0
     rx_queue_22_bp_cleaned: 0
     rx_queue_23_packets: 124
     rx_queue_23_bytes: 689984
     rx_queue_23_bp_poll_yield: 0
     rx_queue_23_bp_misses: 0
     rx_queue_23_bp_cleaned: 0
     rx_queue_24_packets: 9328
     rx_queue_24_bytes: 100313672
     rx_queue_24_bp_poll_yield: 0
     rx_queue_24_bp_misses: 0
     rx_queue_24_bp_cleaned: 0
     rx_queue_25_packets: 9431
     rx_queue_25_bytes: 102005950
     rx_queue_25_bp_poll_yield: 0
     rx_queue_25_bp_misses: 0
     rx_queue_25_bp_cleaned: 0
     rx_queue_26_packets: 156
     rx_queue_26_bytes: 1068472
     rx_queue_26_bp_poll_yield: 0
     rx_queue_26_bp_misses: 0
     rx_queue_26_bp_cleaned: 0
     rx_queue_27_packets: 0
     rx_queue_27_bytes: 0
     rx_queue_27_bp_poll_yield: 0
     rx_queue_27_bp_misses: 0
     rx_queue_27_bp_cleaned: 0
     rx_queue_28_packets: 64
     rx_queue_28_bytes: 428424
     rx_queue_28_bp_poll_yield: 0
     rx_queue_28_bp_misses: 0
     rx_queue_28_bp_cleaned: 0
     rx_queue_29_packets: 7011
     rx_queue_29_bytes: 76581142
     rx_queue_29_bp_poll_yield: 0
     rx_queue_29_bp_misses: 0
     rx_queue_29_bp_cleaned: 0
     rx_queue_30_packets: 7015
     rx_queue_30_bytes: 76217432
     rx_queue_30_bp_poll_yield: 0
     rx_queue_30_bp_misses: 0
     rx_queue_30_bp_cleaned: 0
     rx_queue_31_packets: 58
     rx_queue_31_bytes: 373540
     rx_queue_31_bp_poll_yield: 0
     rx_queue_31_bp_misses: 0
     rx_queue_31_bp_cleaned: 0
     rx_queue_32_packets: 200
     rx_queue_32_bytes: 1178824
     rx_queue_32_bp_poll_yield: 0
     rx_queue_32_bp_misses: 0
     rx_queue_32_bp_cleaned: 0
     rx_queue_33_packets: 9453
     rx_queue_33_bytes: 102083474
     rx_queue_33_bp_poll_yield: 0
     rx_queue_33_bp_misses: 0
     rx_queue_33_bp_cleaned: 0
     rx_queue_34_packets: 9086
     rx_queue_34_bytes: 99516820
     rx_queue_34_bp_poll_yield: 0
     rx_queue_34_bp_misses: 0
     rx_queue_34_bp_cleaned: 0
     rx_queue_35_packets: 0
     rx_queue_35_bytes: 0
     rx_queue_35_bp_poll_yield: 0
     rx_queue_35_bp_misses: 0
     rx_queue_35_bp_cleaned: 0
     rx_queue_36_packets: 84
     rx_queue_36_bytes: 529416
     rx_queue_36_bp_poll_yield: 0
     rx_queue_36_bp_misses: 0
     rx_queue_36_bp_cleaned: 0
     rx_queue_37_packets: 0
     rx_queue_37_bytes: 0
     rx_queue_37_bp_poll_yield: 0
     rx_queue_37_bp_misses: 0
     rx_queue_37_bp_cleaned: 0
     rx_queue_38_packets: 6761
     rx_queue_38_bytes: 74799922
     rx_queue_38_bp_poll_yield: 0
     rx_queue_38_bp_misses: 0
     rx_queue_38_bp_cleaned: 0
     rx_queue_39_packets: 6900
     rx_queue_39_bytes: 75532152
     rx_queue_39_bp_poll_yield: 0
     rx_queue_39_bp_misses: 0
     rx_queue_39_bp_cleaned: 0
     rx_queue_40_packets: 93
     rx_queue_40_bytes: 638034
     rx_queue_40_bp_poll_yield: 0
     rx_queue_40_bp_misses: 0
     rx_queue_40_bp_cleaned: 0
     rx_queue_41_packets: 167
     rx_queue_41_bytes: 961644
     rx_queue_41_bp_poll_yield: 0
     rx_queue_41_bp_misses: 0
     rx_queue_41_bp_cleaned: 0
     rx_queue_42_packets: 9271
     rx_queue_42_bytes: 100270014
     rx_queue_42_bp_poll_yield: 0
     rx_queue_42_bp_misses: 0
     rx_queue_42_bp_cleaned: 0
     rx_queue_43_packets: 179
     rx_queue_43_bytes: 937014
     rx_queue_43_bp_poll_yield: 0
     rx_queue_43_bp_misses: 0
     rx_queue_43_bp_cleaned: 0
     rx_queue_44_packets: 9213
     rx_queue_44_bytes: 98936066
     rx_queue_44_bp_poll_yield: 0
     rx_queue_44_bp_misses: 0
     rx_queue_44_bp_cleaned: 0
     rx_queue_45_packets: 52
     rx_queue_45_bytes: 157176
     rx_queue_45_bp_poll_yield: 0
     rx_queue_45_bp_misses: 0
     rx_queue_45_bp_cleaned: 0
     rx_queue_46_packets: 7169
     rx_queue_46_bytes: 77622954
     rx_queue_46_bp_poll_yield: 0
     rx_queue_46_bp_misses: 0
     rx_queue_46_bp_cleaned: 0
     rx_queue_47_packets: 7063
     rx_queue_47_bytes: 76028990
     rx_queue_47_bp_poll_yield: 0
     rx_queue_47_bp_misses: 0
     rx_queue_47_bp_cleaned: 0
     rx_queue_48_packets: 6958
     rx_queue_48_bytes: 75977492
     rx_queue_48_bp_poll_yield: 0
     rx_queue_48_bp_misses: 0
     rx_queue_48_bp_cleaned: 0
     rx_queue_49_packets: 0
     rx_queue_49_bytes: 0
     rx_queue_49_bp_poll_yield: 0
     rx_queue_49_bp_misses: 0
     rx_queue_49_bp_cleaned: 0
     rx_queue_50_packets: 93
     rx_queue_50_bytes: 549290
     rx_queue_50_bp_poll_yield: 0
     rx_queue_50_bp_misses: 0
     rx_queue_50_bp_cleaned: 0
     rx_queue_51_packets: 0
     rx_queue_51_bytes: 0
     rx_queue_51_bp_poll_yield: 0
     rx_queue_51_bp_misses: 0
     rx_queue_51_bp_cleaned: 0
     rx_queue_52_packets: 231
     rx_queue_52_bytes: 1006558
     rx_queue_52_bp_poll_yield: 0
     rx_queue_52_bp_misses: 0
     rx_queue_52_bp_cleaned: 0
     rx_queue_53_packets: 0
     rx_queue_53_bytes: 0
     rx_queue_53_bp_poll_yield: 0
     rx_queue_53_bp_misses: 0
     rx_queue_53_bp_cleaned: 0
     rx_queue_54_packets: 0
     rx_queue_54_bytes: 0
     rx_queue_54_bp_poll_yield: 0
     rx_queue_54_bp_misses: 0
     rx_queue_54_bp_cleaned: 0
     rx_queue_55_packets: 7079
     rx_queue_55_bytes: 77101638
     rx_queue_55_bp_poll_yield: 0
     rx_queue_55_bp_misses: 0
     rx_queue_55_bp_cleaned: 0
     rx_queue_56_packets: 0
     rx_queue_56_bytes: 0
     rx_queue_56_bp_poll_yield: 0
     rx_queue_56_bp_misses: 0
     rx_queue_56_bp_cleaned: 0
     rx_queue_57_packets: 96
     rx_queue_57_bytes: 694320
     rx_queue_57_bp_poll_yield: 0
     rx_queue_57_bp_misses: 0
     rx_queue_57_bp_cleaned: 0
     rx_queue_58_packets: 159
     rx_queue_58_bytes: 1121510
     rx_queue_58_bp_poll_yield: 0
     rx_queue_58_bp_misses: 0
     rx_queue_58_bp_cleaned: 0
     rx_queue_59_packets: 0
     rx_queue_59_bytes: 0
     rx_queue_59_bp_poll_yield: 0
     rx_queue_59_bp_misses: 0
     rx_queue_59_bp_cleaned: 0
     rx_queue_60_packets: 9309
     rx_queue_60_bytes: 99985482
     rx_queue_60_bp_poll_yield: 0
     rx_queue_60_bp_misses: 0
     rx_queue_60_bp_cleaned: 0
     rx_queue_61_packets: 185
     rx_queue_61_bytes: 959506
     rx_queue_61_bp_poll_yield: 0
     rx_queue_61_bp_misses: 0
     rx_queue_61_bp_cleaned: 0
     rx_queue_62_packets: 9053
     rx_queue_62_bytes: 97581450
     rx_queue_62_bp_poll_yield: 0
     rx_queue_62_bp_misses: 0
     rx_queue_62_bp_cleaned: 0
     rx_queue_63_packets: 0
     rx_queue_63_bytes: 0
     rx_queue_63_bp_poll_yield: 0
     rx_queue_63_bp_misses: 0
     rx_queue_63_bp_cleaned: 0
     tx_pb_0_pxon: 0
     tx_pb_0_pxoff: 0
     tx_pb_1_pxon: 0
     tx_pb_1_pxoff: 0
     tx_pb_2_pxon: 0
     tx_pb_2_pxoff: 0
     tx_pb_3_pxon: 0
     tx_pb_3_pxoff: 0
     tx_pb_4_pxon: 0
     tx_pb_4_pxoff: 0
     tx_pb_5_pxon: 0
     tx_pb_5_pxoff: 0
     tx_pb_6_pxon: 0
     tx_pb_6_pxoff: 0
     tx_pb_7_pxon: 0
     tx_pb_7_pxoff: 0
     rx_pb_0_pxon: 0
     rx_pb_0_pxoff: 0
     rx_pb_1_pxon: 0
     rx_pb_1_pxoff: 0
     rx_pb_2_pxon: 0
     rx_pb_2_pxoff: 0
     rx_pb_3_pxon: 0
     rx_pb_3_pxoff: 0
     rx_pb_4_pxon: 0
     rx_pb_4_pxoff: 0
     rx_pb_5_pxon: 0
     rx_pb_5_pxoff: 0
     rx_pb_6_pxon: 0
     rx_pb_6_pxoff: 0
     rx_pb_7_pxon: 0
     rx_pb_7_pxoff: 0

--X1bOJ3K7DJ5YkBrT--
