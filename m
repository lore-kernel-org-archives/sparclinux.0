From: Jim Gifford <maillist@jg555.com>
Date: Sat, 14 Apr 2007 16:01:45 +0000
Subject: Running Glibc Testsuite - Eeek! page_mapcount(page) went negative!
Message-Id: <4620FAE9.4010904@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I was compiling glibc like I have done several times before, but the 
last 3 times with the 2.6.20.x series of kernel when the testsuite runs 
I get the following error. I've seen this issue reported on LKML but no 
fixes. I'm compiling on a Netra T1.

Eeek! page_mapcount(page) went negative! (-1)
page pfn = 0
page->flags = 400
page->count = 1
page->mapping = 0000000000000000
vma->vm_ops = 0x8
               

Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009600 TPC: 0000000000481574 TNPC: 0000000000481578 Y: 
00000000    Not tainted
TPC: <page_remove_rmap+0x1dc/0x1e0>

g0: 000000000a94c57d g1: 0000000000000000 g2: 0000000000000001 g3: 
00000000006cbac0
g4: fffff80037826a40 g5: 0000000000202464 g6: fffff80033e50000 g7: 
0000000000000000
o0: 0000000000000020 o1: 0000000000686dd0 o2: 000000000000024c o3: 
00000000006b87a8
o4: 00000000006b87e8 o5: fffff80000648d70 sp: fffff80033e52f71 ret_pc: 
000000000048156c
RPC: <page_remove_rmap+0x1d4/0x1e0>
l0: 0009000000000000 l1: 00000000006b87a8 l2: 00000000006b87d8 l3: 
0000000000000000
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 
0000000011009000
i0: fffff80000360000 i1: 0000000000000000 i2: 000c000000000080 i3: 
000000000071bc00
i4: 0000000000000000 i5: ffffffffffffffff i6: fffff80033e53031 i7: 
000000000047a264
I7: <unmap_vmas+0x3ac/0x6c0>
Caller[000000000047a264]: unmap_vmas+0x3ac/0x6c0
Caller[000000000047e044]: exit_mmap+0x6c/0x160
Caller[000000000044846c]: mmput+0x34/0xc04
Caller[000000000044d6f0]: do_exit+0x118/0x940
Caller[000000000044df78]: do_group_exit+0x60/0xa0e
Caller[00000000004578bc]: get_signal_to_deliver+0x2a4/0x380
Caller[0000000000420fe4]: do_notify_resume+0x4c/0x580
Caller[000000000040531c]: __handle_signal+0x18/0x34b
Caller[fffff8012808ebd0]: 0xfffff8012808ebd8

Instruction DUMP:9210224c 7ffe64ed 901221d0 <91d02005> 106fffdc c65e2010 
9de3bf30 c25e2020 a4100018

Fixing recursive fault but reboot is needed!
