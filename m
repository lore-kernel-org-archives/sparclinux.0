From: seb@frankengul.org
Date: Tue, 04 Mar 2008 10:08:24 +0000
Subject: Gigabit ethernet Saturn hw ck failure on ipv6 packet
Message-Id: <20080304100824.GA24055@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
I recently installed a gigabit ethernet card on my ultra 60.

The machine is running a 2.6.24.3 kernel compiled with gcc-4.1.
lspci shows :
0000:00:02.0 Ethernet controller: National Semiconductor Corporation DP83065 [Saturn] 10/100/1000 Ethernet Controller (rev 30)
Since, I encountered a batch of error in the kernel log each time I received an ipv6 packet:
eth1: hw csum failure.
Call Trace:
 [00000000006c02e8] __skb_checksum_complete+0x10/0x40
 [00000000101bec5c] icmpv6_rcv+0x1e4/0x860 [ipv6]
 [00000000101a5d20] ip6_input_finish+0x1c8/0x4e0 [ipv6]
 [00000000101a6160] ip6_mc_input+0xa8/0xc0 [ipv6]
 [00000000101a6434] ipv6_rcv+0x25c/0x480 [ipv6]
 [00000000006c4a14] netif_receive_skb+0x2fc/0x5c0
 [00000000006c79b0] process_backlog+0x78/0x120
 [00000000006c73b0] net_rx_action+0x158/0x240
 [00000000004725b4] __do_softirq+0xbc/0x100
 [000000000047265c] do_softirq+0x64/0x80
 [000000000042f738] handler_irq+0xa0/0xc0
 [00000000004208b4] tl0_irq5+0x1c/0x20
 [0000000000428944] cpu_idle+0x12c/0x160
 [0000000000446334] after_lock_tlb+0x1a4/0x1b0
 [fffff800af05baa0] 0xfffff800af05baa8

The ethtool show the following offload :
root#ethtool -k eth1
Offload parameters for eth1:
Cannot get device rx csum settings: Operation not supported
rx-checksumming: off
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: off
udp fragmentation offload: off
generic segmentation offload: off
Offload seems to be off for reception.

Is this problem related to the hardware or to the kernel ?

	Seb

