From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jul 2006 01:21:06 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <20060707.182106.45892966.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Sat, 1 Jul 2006 14:21:56 +0200

> kernel BUG at include/linux/skbuff.h:457!
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> sshd(21849): Kernel bad sw trap 5 [#1]
> TSTATE: 0000000011001601 TPC: 00000000005c5c2c TNPC: 00000000005c5c30 Y: 00000000    Not tainted
> TPC: <tcp_sendmsg+0x3b0/0xcb0>
> g0: 0000000000000830 g1: 0000000000656400 g2: 0000000000714400 g3: 0000000000002bb9
> g4: fffff8018cde7060 g5: fffff80003d660c0 g6: fffff8016f6f0000 g7: 0000000000000000
> o0: 000000000000002d o1: 0000000000621e30 o2: 00000000000001c9 o3: 0000000000000240
> o4: 00000000ff1e8eef o5: 0000000000000240 sp: fffff8016f6f2fb1 ret_pc: 00000000005c5c24
> RPC: <tcp_sendmsg+0x3a8/0xcb0>

Let's try to get some more debugging.  It looks like an SKB is being
referenced after it has been freed up, or something like this.

Please add this patch and report what it prints, thanks a lot.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f6a2d92..a3cb2cf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -467,6 +467,10 @@ static inline void skb_entail(struct soc
 	TCP_SKB_CB(skb)->end_seq = tp->write_seq;
 	TCP_SKB_CB(skb)->flags = TCPCB_FLAG_ACK;
 	TCP_SKB_CB(skb)->sacked = 0;
+	if (skb->nohdr) {
+		printk("TCP DEBUG: Bogus skb->nohdr, word[%08x]\n",
+		       *(&skb->priority + 1));
+	}
 	skb_header_release(skb);
 	__skb_queue_tail(&sk->sk_write_queue, skb);
 	sk_charge_skb(sk, skb);
