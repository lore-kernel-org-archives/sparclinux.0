From: Robert Reif <reif@earthlink.net>
Date: Sat, 18 Aug 2007 19:40:20 +0000
Subject: sparc32 SMP  debugging help needed
Message-Id: <46C74B24.7050000@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010503080204000906030204"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503080204000906030204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The latest UP git kernels have been stable for me on my ss20s so I
decided to try SMP to see how well that goes.  I tried two
systems: ss20 with 2 sm81s and an ss20 with one dual
125Mhz hypersparc.  The hypersparc system has issues
even with debian UP stable kernel but seemed better with current
git UP kernel.

I found lock warnings on both systems when running
current git SMP kernel.  Can anyone give me advice on how to
go about debugging these problems?

--------------010503080204000906030204
Content-Type: text/plain;
 name="BUG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BUG"

ss20 with two sm81s running debian stable and latest git kernel

Aug 18 14:40:33 ss20-1 kernel: BUG: rwlock wrong owner on CPU#0, dpkg/8732, fa69ce60
Aug 18 14:40:33 ss20-1 kernel: [f009f4d4 : __set_page_dirty+0x10c/0x124 ] 
                               [f009f624 : __block_commit_write+0x80/0xc0 ] 
                               [f009f6a4 : generic_commit_write+0x40/0x9c ] 
                               [fe6ea888 : ext3_ordered_commit_write+0xc4/0x104 [ext3] ] 
                               [f005a97c : generic_file_buffered_write+0x5d4/0x864 ] 
                               [f005b0cc : __generic_file_aio_write_nolock+0x4c0/0x508 ] 
                               [f005b178 : generic_file_aio_write+0x64/0xdc ] 
                               [fe6e5db8 : ext3_file_write+0x28/0xd0 [ext3] ] 
                               [f007b674 : do_sync_write+0x94/0xd0 ] 
                               [f007bea0 : vfs_write+0xa8/0x140 ] 
                               [f007c61c : sys_write+0x38/0x64 ] 
                               [f001570c : syscall_is_too_hard+0x3c/0x40 ] 
                               [500f2a00 : 0x500f2a08 ]

ss20 with single dual hypersparc 125 running debian stable and latest git kernel

Aug 18 15:28:54 ss20-2 kernel: BUG: rwlock wrong owner on CPU#0, swapper/0, fbc23280
Aug 18 15:28:54 ss20-2 kernel: [f005fe9c : test_clear_page_writeback+0x9c/0xd4 ] 
                               [f005936c : end_page_writeback+0x3c/0x70 ] 
                               [f00a130c : end_buffer_async_write+0x180/0x1c0 ] 
                               [f00a117c : end_bio_bh_io_sync+0x58/0x68 ] 
                               [f00a27cc : bio_endio+0x80/0x88 ] 
                               [f00df424 : __end_that_request_first+0x128/0x4dc ] 
                               [fe646eec : scsi_end_request+0x20/0xe4 [scsi_mod] ] 
                               [fe647168 : scsi_io_completion+0x148/0x430 [scsi_mod] ] 
                               [fe633328 : sd_rw_intr+0x2f4/0x328 [sd_mod] ] 
                               [fe641568 : scsi_finish_command+0x88/0x90 [scsi_mod] ] 
                               [f00de9c4 : blk_done_softirq+0x88/0xa4 ] 
                               [f003b7d8 : __do_softirq+0x64/0x118 ] 
                               [f003b8d8 : do_softirq+0x4c/0x5c ] 
                               [f00178a8 : handler_irq+0x120/0x148 ] 
                               [f00149e0 : patch_handler_irq+0x8/0x24 ] 
                               [f0018d74 : cpu_idle+0x34/0x38 ]


--------------010503080204000906030204--

