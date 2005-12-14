From: Meelis Roos <mroos@linux.ee>
Date: Wed, 14 Dec 2005 15:34:36 +0000
Subject: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Todays git snapshot fails to boot on Ultra 5, Unable to handle kernel 
NULL pointer dereference. Soma days ago it booted fine, yesterdays got 
probably not tried. It hangs after "Booting Linux" and I get the below 
dmesg from -p. The oopses contiune to scroll and come from at least 4 
different kernel threads: ksoftirqd/0(2), events/0(4), kthread(6), 
khelper(5) (and maybe I missed some because I stopped the scrolling to 
see the first oops).

PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36
Linux version 2.6.15-rc5-gacd9b7b4 (mroos@mandariin) (gcc version 4.0.3 20051201 (prerelease) (De5
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
Remapping the kernel... done.
Registering callbacks... done.
Booting Linux...
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] 
E[sz(262144):line_sz(64)]
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro -p
PID hash table entries: 2048 (order: 11, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 319352k available (2888k kernel code, 720k data, 184k init) 
[fffff80000000000,0000000013f]
Mount-cache hash table entries: 512
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800007dc4f0
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
ksoftirqd/0(2): Oops [#1]
TSTATE: 0000000080f09602 TPC: 00000000006d0854 TNPC: 00000000006d0858 Y: 
00000000    Not tainted
TPC: <wait_for_completion+0xa20/0xa70>
g0: 0000000000000000 g1: 00000000007de400 g2: 0000000000000000 g3: 000000000002d604
g4: fffff80013f1b800 g5: 0000000000000000 g6: fffff80013f12000 g7: 0000000000000003
o0: 0000000000000001 o1: 0000000000718bcc o2: 0000000000000000 o3: 0000000000000000
o4: fffff8000023bb80 o5: 0000000000000000 sp: fffff80013f13511 ret_pc: 00000000006d07e8
RPC: <wait_for_completion+0x9b4/0xa70>
l0: fffff80013f1bc00 l1: 0000000000718b80 l2: 0000000000000040 l3: 00000000007df800
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000008
i0: 0aad53b0836aaa24 i1: 0000000000000000 i2: 00000000007dbb20 i3: 0000000000000000
i4: fffff80013f156e0 i5: 0000000000000000 i6: fffff80013f135d1 i7: 0000000000472cc0
I7: <kthread+0x88/0xdc>
Caller[0000000000472cc0]: kthread+0x88/0xdc
Caller[000000000040eda4]: kernel_thread+0x30/0x48
Caller[0000000000472a34]: keventd_create_kthread+0x10/0x58
Instruction DUMP: 03001f79  9190200f  c45fa87f <c2008000> 80a06000  024ffd91  82102002  c65fa7e7


-- 
Meelis Roos (mroos@linux.ee)
