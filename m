From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Feb 2004 22:10:41 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222221041.GM703@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 22, 2004 at 01:51:16PM -0800, William Lee Irwin III wrote:
> It hanged early (I can photograph the front LED's and make them
> webabble if need be). Bootlog included as a MIME attachment. The
> "Button XIR" is me typing in the reset string (less traumatic than
> cutting the power via APC MasterSwitch). The way I captured the
> output as early as I did before was with this patch:

I get the same tftpbooting your vmlinux run through elftoaout, this
time with -p. Does elftoaout look like the culprit?


Script started on Sun Feb 22 13:54:23 2004
$ screen -x
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.
{6} ok eject cdrom
{6} ok close cdrom
close ?
{6} ok eject cdrom
{6} ok help eject
gog- Resume execution of OS
bootg- Boot the default OS
boot <device-name>g- Boot from the specified disk
printenvg- Display all configuration variables
setenv <name> <value>g- Set a configuration variable
devaliasg- Display all device aliases
devalias <name> <value>  - Create or change a device alias
show-devsg- Display the names of all devices

Many other commands are available.
{6} ok eject ?
Don't know how to eject ?
{6} ok uneject cdrom
uneject ?
{6} ok boot net:dhcp -p nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: -p nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.3 (davem@nuts) (gcc version 3.3.3 (Debian)) #2 SMP Sat Feb 21 16:37:21 PST 2004
ARCH: SUN4U
Remapping the kernel... done.
Booting Linux...
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490189
  DMA zone: 490189 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists
Kernel command line: -p nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8000000f000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f01603 TPC: 000000000044af64 TNPC: 000000000044af68 Y: 00000000    Not tainted
TPC: <wake_up_forked_process+0x1e4/0x280>
g0: 0000000000791400 g1: 00000000000007f0 g2: 0000000000000000 g3: 00000000006b6cb8
g4: 00000000006b6c80 g5: 0000000000000000 g6: 00000000006b2c80 g7: 0000000000000000
o0: 000000000000007d o1: 0000000000010000 o2: fffff80002d75c40 o3: 0000000000772000
o4: 00000000006b6a18 o5: 0000000000000008 sp: 00000000006b6161 ret_pc: 000000000044aedc
RPC: <wake_up_forked_process+0x15c/0x280>
l0: 000000000076d1a0 l1: 0000000000791400 l2: 0000000000791400 l3: 00000000006c04a0
l4: 0000000000077e8b l5: 0000000000000003 l6: 0000000000000000 l7: 00000000006c0400
i0: 00000000006b6c80 i1: 0000000000000002 i2: 000000000076d1a0 i3: fffff80002d3f678
i4: 0000000000000001 i5: fffff80002d3f680 i6: 00000000006b6231 i7: 000000000075458c
I7: <sched_init+0x12c/0x1a0>
Instruction DUMP: 9a01e008  82006020  c2762038 <c4586008> c6706008  82102001  c6708000  c470e008  ca06202c 
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom
[detached]
$

Script done on Sun Feb 22 13:56:05 2004
