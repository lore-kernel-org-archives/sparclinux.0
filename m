From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2006 07:59:56 +0000
Subject: Re: [Bugme-new] [Bug 7118] New: OOPS in 2.6.18-rc5 and flash.ko
Message-Id: <20060918.005956.10298998.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060906224256.9e689f7c.akpm@osdl.org>
In-Reply-To: <20060906224256.9e689f7c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 6 Sep 2006 22:42:56 -0700

> It oopsed.
 ...
> discover(2007): Oops [#1]
> TSTATE: 0000004411009607 TPC: 0000000000428644 TNPC: 0000000000428648 Y: 00000000    Not tainted
> TPC: <of_find_property+0xc/0x60>
> g0: fffff80016823231 g1: 0000000020004f07 g2: 0000000020004c00 g3: 0000000000000f7c
> g4: fffff80017c30e00 g5: 0000000000000000 g6: fffff80016820000 g7: 0000000000000000
> o0: fffff80017f38940 o1: 00000000000000d0 o2: 0000000001010101 o3: 0000000080808080
> o4: 0000000053554e57 o5: 0000000073627573 sp: fffff800168231f1 ret_pc: 00000000f7fa8db0
> RPC: <0xf7fa8db8>
> l0: 000000000000058c l1: 00000000f7fad4a0 l2: 00000000f7fbef78 l3: 0000000000000000
> l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000f7fbe7ac
> i0: 0000000000000000 i1: fffff800179bb004 i2: fffff80016823c2c i3: fffff800179bb000
> i4: 0000000000000000 i5: 0000000000000000 i6: fffff800168232b1 i7: 00000000004286b0
> I7: <of_get_property+0x18/0x40>
> Caller[00000000004286b0]: of_get_property+0x18/0x40
> Caller[00000000005c8e70]: opromgetprop+0x18/0xa0
> Caller[00000000005c92b0]: openprom_sunos_ioctl+0xf8/0x240
> Caller[00000000005c9c8c]: openprom_compat_ioctl+0x54/0x60
> Caller[00000000004c773c]: compat_sys_ioctl+0x204/0x280
> Caller[00000000004069d4]: linux_sparc_syscall32+0x3c/0x40
> Caller[00000000f7fa8d54]: 0xf7fa8d5c
> Instruction DUMP: 01000000  01000000  9de3bf40 <f05e2028> 02c60011  01000000  d05e0000  4004c0c3  92100019 

The /dev/openprom driver is somehow getting a NULL pointer
in data->current_node.

I think the issue is that we don't handle the termination
properly when OPROMNEXT hits the end of the list.  We
set ->current_node to NULL and things explode.

The NULL ->current_node handling in this file needs a lot
of fixing and auditing, I'll try to work on fixing all of
it soon.

Thanks for the report.
