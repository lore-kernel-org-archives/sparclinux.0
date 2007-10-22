From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 22 Oct 2007 23:10:34 +0000
Subject: LTP results on 2.6.23 sparc32
Message-Id: <20071022231034.GA17612@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's a summary of the Linux Test Project run on
the latest sparc git tree. I'm focussing on the blocking
tests first, but it's slow going.

Test systems:
palantir9	SS20, 2x ROSS Hypersparc, 320MB
palantir13	SS10, 2x SuperSparc II, 128MB

Kernel:
2.6.23-mph4 SMP from the sparc-2.6.git tree. Last commit:
4fa4d23fa20de67df919030c1216295664866ad7 Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6

LTP version: ltp-full-20070930
Command run: ./runltplite.sh -p -l ltplite-211007.log

Summary:
Total Tests: 759
Total Failures: 16
2 tests block the test run from completing on SS20: mkdir09 and rename14
On SS10 pipe04 also blocked completion.


Blocking tests:
---------------
1) mkdir09

In SMP mode, the process threads end up in state D (Uninterruptible sleep).
With the same kernel in UP mode (with num_cpus=0), the test always
succeeds.
Could someone with a SPARC64 try this test?

Typical ps output in SMP mode:
palantir13:/opt# ps -luopendev
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
5 S  1001   468   464  0  80   0 -  2331 -      ?        00:00:00 sshd
0 S  1001   469   468  2  80   0 -   960 -      pts/0    00:00:06 bash
0 S  1001   564   469  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   565   564  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   566   564  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   567   564  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   568   564  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   569   564  0  80   0 -   405 -      pts/0    00:00:00 mkdir09
1 D  1001   570   564  1  80   0 -   405 -      pts/0    00:00:01 mkdir09
palantir13:/opt# ps sa
  UID   PID   PENDING   BLOCKED   IGNORED    CAUGHT STAT TTY        TIME COMMAND
    0   459  00000000  00000000  00000002  00002000 Ss   ttyS0      0:00 /bin/lo
    0   460  00000000  00080000  00324004  7b883efb S    ttyS0      0:00 -bash
 1001   469  00000000  00080000  00324004  7b883efb Ss   pts/0      0:06 -bash
 1001   564  00000000  00000000  00004000 <7ff2beff S+   pts/0      0:00 ./mkdir
 1001   565  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:00 ./mkdir
 1001   566  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:00 ./mkdir
 1001   567  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:00 ./mkdir
 1001   568  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:00 ./mkdir
 1001   569  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:00 ./mkdir
 1001   570  00004000  00000000  00000000 <7ffafeff D+   pts/0      0:01 ./mkdir

The 2nd ps shows that main thread (564) has send a SIGTERM to all other threads,
but they are blocked on something. No further investigation done on this yet.


2) rename14

Running this test causes the following console output:
EXT3-fs warning (device sdb4): ext3_rename: Deleting old file (162881), 2, error=-2
EXT3-fs warning (device sdb4): ext3_rename: Deleting old file (162881), 2, error=-2
EXT3-fs warning (device sdb4): ext3_rename: Deleting old file (162881), 2, error=-2
EXT3-fs warning (device sdb4): ext3_rename: Deleting old file (162881), 2, error=-2
EXT3-fs warning (device sdb4): ext3_unlink: Deleting nonexistent file (162885), 0

and corrupts the FS. Looks like a endian problem in ext3.
Issue being discussed here:
http://article.gmane.org/gmane.comp.file-systems.ext4/3772


3) pipe04

Not investigated yet:

palantir13:~# kernel BUG at mm/highmem.c:196!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
pipe04(3665): Kernel bad trap [#1]
PSR: 400010c0 PC: f006b010 NPC: f006b014 Y: 00000000    Not tainted
PC: <kunmap_high+0xac/0xd8>
%G: 000000c4 400010e7  f01f5084 f01f5078  0054d000 f14ba000  f0a82000 f076fdd8
%O: 00000023 f01c9cc0  000000c4 efb4a9ec  00000000 00000000  f0a83c90 f006b008
RPC: <kunmap_high+0xa4/0xd8>
%L: 00000074 f06f90c0  f019aea4 00000002  00000080 00000000  f0a82000 efb49002
%I: f06f90c0 00000003  fcfe1000 f0224000  00000090 f00f8b70  f0a83cf8 f0087da0
Caller[f0087da0]: pipe_read+0x24c/0x47c
Caller[f0081998]: do_sync_read+0xac/0xe4
Caller[f0081a6c]: vfs_read+0x9c/0xcc
Caller[f0081c84]: sys_read+0x38/0x64
Caller[f001541c]: syscall_is_too_hard+0x3c/0x40
Caller[00010ce8]: 0x10cf0
Instruction DUMP: 921020ce  7ffead1e  01000000 <91d02005> 7fff1ac6  81e80000  82184005  80a00001  10bfffec 
note: pipe04[3665] exited with preempt_count 1
BUG: scheduling while atomic: pipe04/0x04000001/3665
[f019a9cc : cond_resched+0x40/0x48 ] [f0038704 : put_files_struct+0xa4/0xec ] [f0038f98 : do_exit+0x184/0x8f0 ] [f00166f8 : die_if_kernel+0x13c/0x148 ] [f0016754 : do_hw_interrupt+0x50/0x8c ] [f00146a0 : bad_trap_handler+0x28/0x30 ] [f006b008 : kunmap_high+0xa4/0xd8 ] [f0087da0 : pipe_read+0x24c/0x47c ] [f0081998 : do_sync_read+0xac/0xe4 ] [f0081a6c : vfs_read+0x9c/0xcc ] [f0081c84 : sys_read+0x38/0x64 ] [f001541c : syscall_is_too_hard+0x3c/0x40 ] [00010ce8 : 0x10cf0 ] 
BUG: soft lockup - CPU#2 stuck for 11s! [pan:3668]
PSR: 400000c3 PC: f019c0f4 NPC: f019c0ec Y: 00000012    Tainted: G      D
PC: <_spin_trylock_bh+0x40/0x70>
%G: 00000000 00000002  000000ff f0965720  f0abe1d0 efffe000  f0af0000 00000040
%O: f02241a0 f14559e0  efffffc3 00000000  00000001 00000007  f0af1d18 f006b04c
RPC: <kmap_high+0x10/0x234>
%L: f098ade0 f0081aa0  f0085f98 00000040  00000080 00000000  f0af0000 00000006
%I: f071fea0 efffefc3  00000001 80808080  f0224000 00000008  f0af1db0 f0085b5c

-- 
Martin
