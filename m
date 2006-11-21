From: David Miller <davem@davemloft.net>
Date: Tue, 21 Nov 2006 00:33:05 +0000
Subject: Re: Unaligned accesses in hci_send_to_sock
Message-Id: <20061120.193305.102563033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <455DD98E.60102@gentoo.org>
In-Reply-To: <455DD98E.60102@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Fri, 17 Nov 2006 12:47:26 -0300

> Kernel unaligned access at TPC[10247dc4] hci_send_to_sock+0xb4/0x174 
> [bluetooth]
> 
> With my limited kernel module debugging skills i think the culprit is at 
> net/bluetooth/hci_sock.c lines 123-126:
> 
> if (flt->opcode && ((evt = HCI_EV_CMD_COMPLETE &&
>                  flt->opcode != *(__u16 *)(skb->data + 3)) ||
>                  (evt = HCI_EV_CMD_STATUS &&
>                  flt->opcode != *(__u16 *)(skb->data + 4))))
> 
> That looks terrible or am i wrong?

Thanks for the report.  This patch should fix the problem.

[ Marcel, I'd like to send this in to Linus if you don't mind. ]

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f26a9eb..3bf9222 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -120,10 +120,13 @@ void hci_send_to_sock(struct hci_dev *hd
 			if (!hci_test_bit(evt, &flt->event_mask))
 				continue;
 
-			if (flt->opcode && ((evt = HCI_EV_CMD_COMPLETE && 
-					flt->opcode != *(__u16 *)(skb->data + 3)) ||
-					(evt = HCI_EV_CMD_STATUS && 
-					flt->opcode != *(__u16 *)(skb->data + 4))))
+			if (flt->opcode &&
+			    ((evt = HCI_EV_CMD_COMPLETE && 
+			      flt->opcode !+			      get_unaligned((__u16 *)(skb->data + 3))) ||
+			     (evt = HCI_EV_CMD_STATUS && 
+			      flt->opcode !+			      get_unaligned((__u16 *)(skb->data + 4)))))
 				continue;
 		}
 
