From: Dereck Martin <dmartin@tekconxus.com>
Date: Thu, 31 Jan 2008 20:29:55 +0000
Subject: Re: OOPS 2.6.20 E450
Message-Id: <47A22FC3.7060901@tekconxus.com>
List-Id: <sparclinux.vger.kernel.org>
References: <47A22E66.1090202@mydatex.cz>
In-Reply-To: <47A22E66.1090202@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The smiley face... i have saw that a few times.

Daniel Smolik wrote:
> Hi,
> I today work on my E450 and get this :-(. I run vanilla 2.6.20.
> 
> Jan 31 15:25:09 karotka kernel:               \|/ ____ \|/
> Jan 31 15:25:09 karotka kernel:               "@'/ .. \`@"
> Jan 31 15:25:09 karotka kernel:               /_| \__/ |_\
> Jan 31 15:25:09 karotka kernel:                  \__U_/
> Jan 31 15:25:09 karotka kernel: swapper(0): Oops [#1]
> Jan 31 15:25:09 karotka kernel: TSTATE: 0000004480009606 TPC: 
> 000000000062486c TNPC: 0000000000624870 Y: 00000024    Not tainted
> Jan 31 15:25:09 karotka kernel: TPC: <tcp_ack+0xcf4/0x1c00>
> Jan 31 15:25:09 karotka kernel: g0: fffff8003fdc6bb1 g1: 
> 0000000000000000 g2: 000000000071b400 g3: 00000001060f116b
> Jan 31 15:25:09 karotka kernel: g4: fffff8003fe364a0 g5: 
> fffff800003a58c0 g6: fffff8003fdc4000 g7: 0000000000000015
> Jan 31 15:25:09 karotka kernel: o0: fffff8003ec2c060 o1: 
> fffff8003ec2c060 o2: 00000000ffffffff o3: 060f116ad3030000
> Jan 31 15:25:09 karotka kernel: o4: 0000000000000003 o5: 
> 00000000ffffb5bb sp: fffff8003fdc6ba1 ret_pc: 000000000062543c
> Jan 31 15:25:09 karotka kernel: RPC: <tcp_ack+0x18c4/0x1c00>
> Jan 31 15:25:09 karotka kernel: l0: 00000000a9906616 l1: 
> 0000000000000000 l2: 0000000000000000 l3: 00000000a9906616
> Jan 31 15:25:09 karotka kernel: l4: fffff8003ec2c110 l5: 
> 00000000a9906609 l6: 0000000000000004 l7: ffffffffffffffff
> Jan 31 15:25:09 karotka kernel: i0: fffff8003ec2c060 i1: 
> fffff8003ec2c110 i2: 000000000000010f i3: 00000000ffffb5bc
> Jan 31 15:25:09 karotka kernel: i4: 0000000000000001 i5: 
> 0000000000000007 i6: fffff8003fdc6c91 i7: 00000000006284b4
> Jan 31 15:25:09 karotka kernel: I7: <tcp_rcv_state_process+0x5bc/0x1160>
> Jan 31 15:25:09 karotka kernel: Caller[00000000006284b4]: 
> tcp_rcv_state_process+0x5bc/0x1160
> Jan 31 15:25:09 karotka kernel: Caller[0000000000630698]: 
> tcp_v4_do_rcv+0xc0/0x3e0
> Jan 31 15:25:09 karotka kernel: Caller[0000000000633364]: 
> tcp_v4_rcv+0xa4c/0xa80
> Jan 31 15:25:09 karotka kernel: Caller[00000000006124fc]: 
> ip_local_deliver+0x164/0x380
> Jan 31 15:25:09 karotka kernel: Caller[00000000006120b8]: 
> ip_rcv+0x320/0x600
> Jan 31 15:25:09 karotka kernel: Caller[00000000005f0034]: 
> netif_receive_skb+0x3dc/0x4e0
> Jan 31 15:25:09 karotka kernel: Caller[00000000005f1f80]: 
> process_backlog+0x88/0x140
> Jan 31 15:25:09 karotka kernel: Caller[00000000005f20c0]: 
> net_rx_action+0x88/0x160
> Jan 31 15:25:09 karotka kernel: Caller[000000000045a458]: 
> __do_softirq+0x80/0x100
> Jan 31 15:25:09 karotka kernel: Caller[000000000045a53c]: 
> do_softirq+0x64/0x80
> Jan 31 15:25:09 karotka kernel: Caller[000000000041cee4]: 
> handler_irq+0xac/0xc0
> Jan 31 15:25:10 karotka kernel: Caller[00000000004108b4]: 
> tl0_irq5+0x1c/0x20
> Jan 31 15:25:10 karotka kernel: Caller[0000000000418828]: 
> cpu_idle+0xb0/0xc0
> Jan 31 15:25:10 karotka kernel: Caller[000000000043613c]: 
> after_lock_tlb+0x14c/0x158
> Jan 31 15:25:10 karotka kernel: Caller[0000000040000000]: 0x40000008
> Jan 31 15:25:10 karotka kernel: Instruction DUMP: 80a50001  ce062350  
> 83647000 <c4006078> 8620c002  80a0c007  384800e1 c20e2370  820b20ff
> 
> Saw anybody this OOPS ?
> 
>             Dan
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> !DSPAM:47a22d1c168201357017964!
> 
> 
