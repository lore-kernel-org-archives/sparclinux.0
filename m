From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 25 May 2016 16:19:24 +0000
Subject: Re: booting sun sparc T5120 with "nosmp" kernel 4.5.4 causes OOPS in n2_crypto module
Message-Id: <CADxRZqysyGptB1FhuuC6qw7+4dAOp=9wSVPOtnPS5cDrm2ZOZg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqy0ftpM+QrEDHoXL7AAW383ae5OWOqR2Ts2sEB+oS8YRQ@mail.gmail.com>
In-Reply-To: <CADxRZqy0ftpM+QrEDHoXL7AAW383ae5OWOqR2Ts2sEB+oS8YRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 24, 2016 at 3:08 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> (re-sent in plain text)
>
> Hello!
>
> Tried to boot T5120 with "nosmp" kernel option, gives OOPS in n2_crypto module:


if anyone interested, got another "nosmp" OOPS, now in ext4 code:

May 25 19:11:17 nvg5120 systemd[1]:
dev-disk-by\x2duuid-aedded70\x2da52c\x2d4cd8\x2dabdd\x2dd1df88747046.device:
Dev dev-disk-by\x2duuid-aedded70\x2da52c\x2d4cd8\x2dabdd\x2dd1df8874
May 25 19:11:28 nvg5120 kernel: kernel BUG at
/build/linux-c06pcb/linux-4.5.4/mm/slab.c:2799!
May 25 19:11:28 nvg5120 kernel:               \|/ ____ \|/
                                              "@'/ .. \`@"
                                              /_| \__/ |_\
                                                 \__U_/
May 25 19:11:28 nvg5120 kernel: ftp(3272): Kernel bad sw trap 5 [#1]
May 25 19:11:28 nvg5120 kernel: CPU: 0 PID: 3272 Comm: ftp Tainted: G
      W   E   4.5.0-2-sparc64-smp #1 Debian 4.5.4-1
May 25 19:11:28 nvg5120 kernel: task: ffff8003ef366bc0 ti:
ffff8003efce4000 task.ti: ffff8003efce4000
May 25 19:11:28 nvg5120 kernel: TSTATE: 0000004411e01600 TPC:
00000000005b5b20 TNPC: 00000000005b5b24 Y: 00002283    Tainted: G
  W   E
May 25 19:11:28 nvg5120 kernel: TPC: <cache_alloc_refill+0x520/0x620>
May 25 19:11:28 nvg5120 kernel: g0: 0000000000a57118 g1:
000000000000003d g2: 0000000000000000 g3: 000000000000000e
May 25 19:11:28 nvg5120 kernel: g4: ffff8003ef366bc0 g5:
ffff8003fe7f2000 g6: ffff8003efce4000 g7: 0000000000000000
May 25 19:11:28 nvg5120 kernel: o0: 0000000000a5c968 o1:
0000000000000aef o2: 0000000000000001 o3: ffff8003ef3fb000
May 25 19:11:28 nvg5120 kernel: o4: 00000000108c4ebc o5:
0000600008c83d70 sp: ffff8003efce6871 ret_pc: 00000000005b5b18
May 25 19:11:28 nvg5120 kernel: RPC: <cache_alloc_refill+0x518/0x620>
May 25 19:11:28 nvg5120 kernel: l0: ffff8003fe7f2000 l1:
0000000000001000 l2: 0000000000000000 l3: 0000000000000000
May 25 19:11:28 nvg5120 kernel: l4: 00005fffffc0cc50 l5:
0000000000000000 l6: ffff8003ef6b8000 l7: 0000000000008000
May 25 19:11:28 nvg5120 kernel: i0: ffff8003ef3d54a0 i1:
0000000002400440 i2: 0000000000000000 i3: 0000000000000001
May 25 19:11:28 nvg5120 kernel: i4: 0000dffc0141ac50 i5:
0000000000000000 i6: ffff8003efce6921 i7: 00000000005b6014
May 25 19:11:28 nvg5120 kernel: I7: <kmem_cache_alloc+0x1d4/0x220>
May 25 19:11:28 nvg5120 kernel: Call Trace:
May 25 19:11:28 nvg5120 kernel:  [00000000005b6014] kmem_cache_alloc+0x1d4/0x220
May 25 19:11:28 nvg5120 kernel:  [0000000010876dd0]
jbd2_alloc+0x110/0x160 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [000000001086be40]
do_get_write_access+0x220/0x520 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [000000001086c1b8]
jbd2_journal_get_write_access+0x78/0xc0 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [00000000108f8a40]
__ext4_journal_get_write_access+0x20/0x60 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c0e88]
ext4_reserve_inode_write+0x68/0xa0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c0eec]
ext4_mark_inode_dirty+0x2c/0x280 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c4ebc]
ext4_dirty_inode+0x3c/0x80 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000005fe87c]
__mark_inode_dirty+0x3c/0x420
May 25 19:11:28 nvg5120 kernel:  [0000000000607d60] generic_write_end+0xa0/0xe0
May 25 19:11:28 nvg5120 kernel:  [00000000108c37bc]
ext4_da_write_end+0xfc/0x300 [ext4]
May 25 19:11:28 nvg5120 kernel:  [0000000000559e5c]
generic_perform_write+0xfc/0x1a0
May 25 19:11:28 nvg5120 kernel:  [000000000055bb9c]
__generic_file_write_iter+0x11c/0x160
May 25 19:11:28 nvg5120 kernel:  [00000000108b58d8]
ext4_file_write_iter+0xd8/0x400 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000005ce354] new_sync_write+0x74/0xc0
May 25 19:11:28 nvg5120 kernel:  [00000000005ce3ec] __vfs_write+0x4c/0x60
May 25 19:11:28 nvg5120 kernel: Disabling lock debugging due to kernel taint
May 25 19:11:28 nvg5120 kernel: Caller[00000000005b6014]:
kmem_cache_alloc+0x1d4/0x220
May 25 19:11:28 nvg5120 kernel: Caller[0000000010876dd0]:
jbd2_alloc+0x110/0x160 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[000000001086be40]:
do_get_write_access+0x220/0x520 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[000000001086c1b8]:
jbd2_journal_get_write_access+0x78/0xc0 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108f8a40]:
__ext4_journal_get_write_access+0x20/0x60 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c0e88]:
ext4_reserve_inode_write+0x68/0xa0 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c0eec]:
ext4_mark_inode_dirty+0x2c/0x280 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c4ebc]:
ext4_dirty_inode+0x3c/0x80 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000005fe87c]:
__mark_inode_dirty+0x3c/0x420
May 25 19:11:28 nvg5120 kernel: Caller[0000000000607d60]:
generic_write_end+0xa0/0xe0
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c37bc]:
ext4_da_write_end+0xfc/0x300 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[0000000000559e5c]:
generic_perform_write+0xfc/0x1a0
May 25 19:11:28 nvg5120 kernel: Caller[000000000055bb9c]:
__generic_file_write_iter+0x11c/0x160
May 25 19:11:28 nvg5120 kernel: Caller[00000000108b58d8]:
ext4_file_write_iter+0xd8/0x400 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ce354]:
new_sync_write+0x74/0xc0
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ce3ec]: __vfs_write+0x4c/0x60
May 25 19:11:28 nvg5120 kernel: Caller[00000000005cf2b8]: vfs_write+0x78/0x180
May 25 19:11:28 nvg5120 kernel: Caller[00000000005d0058]: SyS_write+0x38/0xa0
May 25 19:11:28 nvg5120 kernel: Caller[0000000000406294]:
linux_sparc_syscall+0x34/0x44
May 25 19:11:28 nvg5120 kernel: Caller[ffff8001001c9f98]: 0xffff8001001c9f98
May 25 19:11:28 nvg5120 kernel: Instruction DUMP: 92102aef  7ff9c802
90122168 <91d02005> 91902000  106fff80  c206202c  c20e2080  80a06000
May 25 19:11:28 nvg5120 kernel: kernel BUG at
/build/linux-c06pcb/linux-4.5.4/mm/slab.c:2799!
May 25 19:11:28 nvg5120 kernel:               \|/ ____ \|/
                                              "@'/ .. \`@"
                                              /_| \__/ |_\
                                                 \__U_/
May 25 19:11:28 nvg5120 kernel: rs:main Q:Reg(502): Kernel bad sw trap 5 [#2]
May 25 19:11:28 nvg5120 kernel: CPU: 0 PID: 502 Comm: rs:main Q:Reg
Tainted: G      D W   E   4.5.0-2-sparc64-smp #1 Debian 4.5.4-1
May 25 19:11:28 nvg5120 kernel: task: ffff8003efef8300 ti:
ffff8003efcd0000 task.ti: ffff8003efcd0000
May 25 19:11:28 nvg5120 kernel: TSTATE: 0000004411e01605 TPC:
00000000005b5b20 TNPC: 00000000005b5b24 Y: 00000000    Tainted: G
D W   E
May 25 19:11:28 nvg5120 kernel: TPC: <cache_alloc_refill+0x520/0x620>
May 25 19:11:28 nvg5120 kernel: g0: 000001000019aa28 g1:
000000000000003d g2: 0000000000000000 g3: 000000000000000e
May 25 19:11:28 nvg5120 kernel: g4: ffff8003efef8300 g5:
ffff8003fe7f2000 g6: ffff8003efcd0000 g7: 0000000000000f00
May 25 19:11:28 nvg5120 kernel: o0: 0000000000a5c968 o1:
0000000000000aef o2: 0000000000000001 o3: ffff8003ef3fb000
May 25 19:11:28 nvg5120 kernel: o4: 00000000108c4ebc o5:
ffff80000d111400 sp: ffff8003efcd2951 ret_pc: 00000000005b5b18
May 25 19:11:28 nvg5120 kernel: RPC: <cache_alloc_refill+0x518/0x620>
May 25 19:11:28 nvg5120 kernel: l0: ffff8003fe7f2000 l1:
000000000000004a l2: ffff800102b5e386 l3: 0000000000000000
May 25 19:11:28 nvg5120 kernel: l4: 00005fffffc0cc50 l5:
0000000000000000 l6: 0000000000000000 l7: 00000100001919f8
May 25 19:11:28 nvg5120 kernel: i0: ffff8003ef3d54a0 i1:
0000000002400440 i2: 0000000000000000 i3: ffff8003efcd3e98
May 25 19:11:28 nvg5120 kernel: i4: 0000dffc0141ac50 i5:
0000000000000000 i6: ffff8003efcd2a01 i7: 00000000005b6014
May 25 19:11:28 nvg5120 kernel: I7: <kmem_cache_alloc+0x1d4/0x220>
May 25 19:11:28 nvg5120 kernel: Call Trace:
May 25 19:11:28 nvg5120 kernel:  [00000000005b6014] kmem_cache_alloc+0x1d4/0x220
May 25 19:11:28 nvg5120 kernel:  [0000000010876dd0]
jbd2_alloc+0x110/0x160 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [000000001086be40]
do_get_write_access+0x220/0x520 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [000000001086c1b8]
jbd2_journal_get_write_access+0x78/0xc0 [jbd2]
May 25 19:11:28 nvg5120 kernel:  [00000000108f8a40]
__ext4_journal_get_write_access+0x20/0x60 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c0e88]
ext4_reserve_inode_write+0x68/0xa0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c0eec]
ext4_mark_inode_dirty+0x2c/0x280 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c4ebc]
ext4_dirty_inode+0x3c/0x80 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000005fe87c]
__mark_inode_dirty+0x3c/0x420
May 25 19:11:28 nvg5120 kernel:  [00000000005ea3f8]
generic_update_time+0x98/0xe0
May 25 19:11:28 nvg5120 kernel:  [00000000005ea560] file_update_time+0xa0/0x120
May 25 19:11:28 nvg5120 kernel:  [000000000055badc]
__generic_file_write_iter+0x5c/0x160
May 25 19:11:28 nvg5120 kernel:  [00000000108b58d8]
ext4_file_write_iter+0xd8/0x400 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000005ce354] new_sync_write+0x74/0xc0
May 25 19:11:28 nvg5120 kernel:  [00000000005ce3ec] __vfs_write+0x4c/0x60
May 25 19:11:28 nvg5120 kernel:  [00000000005cf2b8] vfs_write+0x78/0x180
May 25 19:11:28 nvg5120 kernel: Caller[00000000005b6014]:
kmem_cache_alloc+0x1d4/0x220
May 25 19:11:28 nvg5120 kernel: Caller[0000000010876dd0]:
jbd2_alloc+0x110/0x160 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[000000001086be40]:
do_get_write_access+0x220/0x520 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[000000001086c1b8]:
jbd2_journal_get_write_access+0x78/0xc0 [jbd2]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108f8a40]:
__ext4_journal_get_write_access+0x20/0x60 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c0e88]:
ext4_reserve_inode_write+0x68/0xa0 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c0eec]:
ext4_mark_inode_dirty+0x2c/0x280 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000108c4ebc]:
ext4_dirty_inode+0x3c/0x80 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000005fe87c]:
__mark_inode_dirty+0x3c/0x420
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ea3f8]:
generic_update_time+0x98/0xe0
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ea560]:
file_update_time+0xa0/0x120
May 25 19:11:28 nvg5120 kernel: Caller[000000000055badc]:
__generic_file_write_iter+0x5c/0x160
May 25 19:11:28 nvg5120 kernel: Caller[00000000108b58d8]:
ext4_file_write_iter+0xd8/0x400 [ext4]
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ce354]:
new_sync_write+0x74/0xc0
May 25 19:11:28 nvg5120 kernel: Caller[00000000005ce3ec]: __vfs_write+0x4c/0x60
May 25 19:11:28 nvg5120 kernel: Caller[00000000005cf2b8]: vfs_write+0x78/0x180
May 25 19:11:28 nvg5120 kernel: Caller[00000000005d0058]: SyS_write+0x38/0xa0
May 25 19:11:28 nvg5120 kernel: Caller[0000000000406294]:
linux_sparc_syscall+0x34/0x44
May 25 19:11:28 nvg5120 kernel: Caller[ffff800100256218]: 0xffff800100256218
May 25 19:11:28 nvg5120 kernel: Instruction DUMP: 92102aef  7ff9c802
90122168 <91d02005> 91902000  106fff80  c206202c  c20e2080  80a06000
May 25 19:11:28 nvg5120 kernel: ------------[ cut here ]------------
May 25 19:11:28 nvg5120 kernel: WARNING: CPU: 0 PID: 3272 at
/build/linux-c06pcb/linux-4.5.4/fs/ext4/ext4_jbd2.c:266
__ext4_handle_dirty_metadata+0x218/0x260 [ext4]()
May 25 19:11:28 nvg5120 kernel: Modules linked in: sg(E) n2_crypto(E)
n2_rng(E) rng_core(E) des_generic(E) autofs4(E) ext4(E) ecb(E)
crc16(E) mbcache(E) jbd2(E) crc32c_generic(E) dm
May 25 19:11:28 nvg5120 kernel: CPU: 0 PID: 3272 Comm: ftp Tainted: G
    D W   E   4.5.0-2-sparc64-smp #1 Debian 4.5.4-1
May 25 19:11:28 nvg5120 kernel: Call Trace:
May 25 19:11:28 nvg5120 kernel:  [00000000004669d0]
warn_slowpath_common+0x70/0xc0
May 25 19:11:28 nvg5120 kernel:  [0000000000466abc] warn_slowpath_null+0x1c/0x40
May 25 19:11:28 nvg5120 kernel:  [00000000108f8ed8]
__ext4_handle_dirty_metadata+0x218/0x260 [ext4]
May 25 19:11:28 nvg5120 kernel:  [0000000010901310]
ext4_mb_mark_diskspace_used+0x290/0x4e0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [0000000010902a10]
ext4_mb_new_blocks+0x370/0x600 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108f5518]
ext4_ext_map_blocks+0xc58/0x17a0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108bd0c8]
ext4_map_blocks+0x168/0x580 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108c174c]
ext4_writepages+0x60c/0xda0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [0000000000567eec] do_writepages+0x2c/0x60
May 25 19:11:28 nvg5120 kernel:  [000000000055af70]
__filemap_fdatawrite_range+0xb0/0x120
May 25 19:11:28 nvg5120 kernel:  [000000000055b03c] filemap_flush+0x1c/0x40
May 25 19:11:28 nvg5120 kernel:  [00000000108be004]
ext4_alloc_da_blocks+0x24/0xa0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000108b62f0]
ext4_release_file+0x90/0xe0 [ext4]
May 25 19:11:28 nvg5120 kernel:  [00000000005d0ff4] __fput+0x94/0x220
May 25 19:11:28 nvg5120 kernel:  [00000000005d120c] ____fput+0xc/0x20
May 25 19:11:28 nvg5120 kernel:  [0000000000483c60] task_work_run+0x80/0xc0
May 25 19:11:28 nvg5120 kernel: ---[ end trace 7aa1f0163177ee01 ]---
May 25 19:11:28 nvg5120 kernel: EXT4-fs:
ext4_mb_mark_diskspace_used:2987: aborting transaction: error 28 in
__ext4_handle_dirty_metadata
May 25 19:11:28 nvg5120 kernel: EXT4: jbd2_journal_dirty_metadata
failed: handle type 2 started at line 2754, credits 1/0, errcode -28
May 25 19:11:28 nvg5120 kernel: EXT4-fs error (device dm-0) in
ext4_writepages:2612: error 28
