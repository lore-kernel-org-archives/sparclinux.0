From: Christian Joensson <christian@j-son.org>
Date: Tue, 11 May 2004 10:28:55 +0000
Subject: 2.4.26 on UP sun4m: ksymoops for kernel NULL pointer dereference
Message-Id: <20040511122855.A11421@fw.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is on a single CPU sun4m SS20 system running Aurora SPARC Linux
1.0.

ksymoops 2.4.4 on sparc 2.4.26-0.1sparc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26-0.1sparc/ (default)
     -m /boot/System.map-2.4.26-0.1sparc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/esp.o) for esp
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module esp to a unique module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference in mna handler<1> at virtual address 00000001
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
mrtg(8126): Oops
PSR: 400000c6 PC: fe316458 NPC: fe31645c Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 7f454c46 g1: fac61e60 g2: 00000001 g3: 404000e1 g4: f00678e4 g5: 006f2e31 g6: f3106000 g7: 00000000
o0: 00000002 o1: 00000001 o2: 00000000 o3: f3107ec0 o4: f64686e0 o5: 00000004 sp: f3107b00 o7: f0050a44
l0: 404000c7 l1: 00000001 l2: fe316434 l3: 00000080 l4: 00000000 l5: 006f2e31 l6: f3106000 l7: f00599e8
i0: f3032200 i1: 00000002 i2: fe334c00 i3: f303a400 i4: 00000003 i5: 00000000 fp: f3107b68 i7: fe32d750
Caller[fe32d750]
Caller[f006852c]
Caller[f006a310]
Caller[f005d568]
Caller[f005d71c]
Caller[f005d9e0]
Caller[f005dea8]
Caller[f0050a44]
Caller[f0050e5c]
Caller[f00130bc]
Caller[50006494]
Instruction DUMP: 80a46000  0280001c  01000000 <d0044000> d2020000  80a24018  02800012  213f8c7b  a0142188 

>>PC;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <==>>O7;  f0050a44 <filp_open+2c/54>
>>I7;  fe32d750 <[ext3].text.start+86f0/eb4f>
Trace; fe32d750 <[ext3].text.start+86f0/eb4f>
Trace; f006852c <__mark_inode_dirty+3c/ac>
Trace; f006a310 <update_atime+70/80>
Trace; f005d568 <link_path_walk+a10/bb8>
Trace; f005d71c <path_walk+c/1c>
Trace; f005d9e0 <path_lookup+28/3c>
Trace; f005dea8 <open_namei+58/6a4>
Trace; f0050a44 <filp_open+2c/54>
Trace; f0050e5c <sys_open+34/b0>
Trace; f00130bc <syscall_is_too_hard+34/40>
Trace; 50006494 Before first symbol
Code;  fe31644c <[jbd]__kstrtab_journal_wipe+14/18>
00000000 <_PC>:
Code;  fe31644c <[jbd]__kstrtab_journal_wipe+14/18>
   0:   80 a4 60 00       cmp  %l1, 0
Code;  fe316450 <[jbd]__kstrtab_journal_blocks_per_page+0/28>
   4:   02 80 00 1c       be  74 <_PC+0x74> fe3164c0 <[jbd]__kstrtab_journal_bmap+0/18>
Code;  fe316454 <[jbd]__kstrtab_journal_blocks_per_page+4/28>
   8:   01 00 00 00       nop 
Code;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <==   c:   d0 04 40 00       ld  [ %l1 ], %o0   <==Code;  fe31645c <[jbd]__kstrtab_journal_blocks_per_page+c/28>
  10:   d2 02 00 00       ld  [ %o0 ], %o1
Code;  fe316460 <[jbd]__kstrtab_journal_blocks_per_page+10/28>
  14:   80 a2 40 18       cmp  %o1, %i0
Code;  fe316464 <[jbd]__kstrtab_journal_blocks_per_page+14/28>
  18:   02 80 00 12       be  60 <_PC+0x60> fe3164ac <[jbd]__kstrtab_journal_try_to_free_buffers+14/28>
Code;  fe316468 <[jbd]__kstrtab_journal_blocks_per_page+18/28>
  1c:   21 3f 8c 7b       sethi  %hi(0xfe31ec00), %l0
Code;  fe31646c <[jbd]__kstrtab_journal_blocks_per_page+1c/28>
  20:   a0 14 21 88       or  %l0, 0x188, %l0  ! fe31ed88 <_PC+0xfe31ed88> fc6351d4 <end+c3c4c9c/e09cb28>


3 warnings and 4 errors issued.  Results may not be reliable.

Kernel and log of build available at
ftp://ftp.j-son.org/pub/aurora/kernel-2.4.26 (with IP 81.224.25.111 if
dns does not work, which is probably my own fault and which I should
resolve any day real soon now :)

Related, or unrelated, I get this in dmesg:

svc: bad direction 268435456, dropping request
svc: bad direction 268435456, dropping request
svc: bad direction 268435456, dropping request
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)

Anyone?

Cheers,

/ChJ
