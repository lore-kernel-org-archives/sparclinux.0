From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 03 Jul 2006 16:22:10 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <200607031122.10110.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 02 July 2006 19:02, Dennis Gilmore wrote:
> On Saturday 01 July 2006 7:21 am, Rene Rebe wrote:
> > Hi all,
> >
> > I just test the freshly installed T1000 under load and got a single stray
> > oops after 5 hours of uptime with excessive load (software compilation).
> > The software is the T2 release from this week (software compiled from
> > vanilla sources) with GCC 4.1.1, Kernel 2.6.17.2:
> >
>
> I am using a 2.6.17pre  kernel  on my T1000
> Linux version 2.6.16-1.2241sp7 (root@arthur.devel.redhat.com) (gcc version
> 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 SMP Thu Jun 29 10:59:22 EDT 2006
>
> i have been using it with an average load of around 10 for a couple of days
> now.  It has received 125gb in that time.  and have not seen any issues at
> all.
I spoke too soon  just got an oops  the nfs connection locked up with the oops

kernel BUG at include/linux/skbuff.h:466!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
rpciod/2(2109): Kernel bad sw trap 5 [#1]
TSTATE: 0000000080001602 TPC: 0000000000630534 TNPC: 0000000000630538 Y: 
00000000    Not tainted
TPC: <tcp_sendmsg+0x5ec/0xc7c>
g0: fffff803fb1b2b98 g1: 00000000006d0c00 g2: ffffffffffffffd3 g3: 
00000000007a3400
g4: fffff803fb7905a0 g5: fffff800074fa0c0 g6: fffff803fa868000 g7: 
0000000000000000
o0: 000000000000002d o1: 000000000068ae68 o2: 00000000000001d2 o3: 
000000000000009c
o4: 000000000000009c o5: 0000000000000080 sp: fffff803fa86abd1 ret_pc: 
000000000063052c
RPC: <tcp_sendmsg+0x5e4/0xc7c>
l0: fffff80169cce580 l1: fffff80169cce580 l2: 0000000000000000 l3: 
fffff803fa86b930
l4: fffff803fb1b2b98 l5: 0000000000000000 l6: fffff803fd909aa0 l7: 
fffff803fb1b2b90
i0: ffffffffffffffe0 i1: fffff8008ad23780 i2: 0000000000000000 i3: 
0000000000004040
i4: 000000000000009c i5: fffff801bc71a000 i6: fffff803fa86acd1 i7: 
000000000064e834
I7: <inet_sendmsg+0x40/0x54>
Caller[000000000064e834]: inet_sendmsg+0x40/0x54
Caller[00000000005f8110]: sock_sendmsg+0xac/0xd8
Caller[00000000005f8160]: kernel_sendmsg+0x24/0x40
Caller[00000000100e7d78]: xs_tcp_send_request+0x108/0x360 [sunrpc]
Caller[00000000100e6cf0]: xprt_transmit+0xec/0x228 [sunrpc]
Caller[00000000100e55f0]: call_transmit+0x1e0/0x230 [sunrpc]
Caller[00000000100eaa34]: __rpc_execute+0xa4/0x244 [sunrpc]
Caller[0000000000460974]: run_workqueue+0xb8/0x10c
Caller[0000000000460aa8]: worker_thread+0xe0/0x11c
Caller[0000000000464498]: kthread+0xb4/0xe8
Caller[00000000004187a0]: kernel_thread+0x30/0x48
Caller[00000000004644dc]: keventd_create_kthread+0x10/0x88
Instruction DUMP: 90122048  7ff7a1de  01000000 <91d02005> 15001b50  82102049  
83287008  9412a180  94028001
