From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Fri, 17 Nov 2006 15:47:26 +0000
Subject: Unaligned accesses in hci_send_to_sock
Message-Id: <455DD98E.60102@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I'm getting multiple unaligned accesses when using the bluetooth subsystem.

Kernel unaligned access at TPC[10247dc4] hci_send_to_sock+0xb4/0x174 
[bluetooth]

With my limited kernel module debugging skills i think the culprit is at 
net/bluetooth/hci_sock.c lines 123-126:

if (flt->opcode && ((evt = HCI_EV_CMD_COMPLETE &&
                 flt->opcode != *(__u16 *)(skb->data + 3)) ||
                 (evt = HCI_EV_CMD_STATUS &&
                 flt->opcode != *(__u16 *)(skb->data + 4))))

That looks terrible or am i wrong?
Best regards.

-- 
Gustavo Zacarias
Gentoo/SPARC monkey
