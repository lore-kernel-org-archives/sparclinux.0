From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 21 Sep 2017 10:03:34 +0000
Subject: 4.14.0-rc1 , possible circular locking dependency detected
Message-Id: <CADxRZqw9EOHGt716=7OfWMzsdFrODw2aaYcQ0ze7zQ5aaBum9Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Got in logs today on idle system:

Sep 20 19:04:33 kernel: XFS (vdiskb1): Unmounting Filesystem
Sep 21 07:05:32 kernel:
Sep 21 07:05:32 kernel: ===========================
Sep 21 07:05:32 kernel: WARNING: possible circular locking dependency detected
Sep 21 07:05:32 kernel: 4.14.0-rc1 #456 Not tainted
Sep 21 07:05:32 kernel: ------------------------------------------------------
Sep 21 07:05:32 kernel: kworker/u512:0/875 is trying to acquire lock:
Sep 21 07:05:32 kernel:  ((complete)&ret.event){+.+.}, at:
[<00000000009f4594>] wait_for_completion_io+0x14/0x40
Sep 21 07:05:32 kernel:
                        but task is already holding lock:
Sep 21 07:05:32 kernel:  (&ei->i_data_sem){++++}, at:
[<000000001008ba64>] ext4_map_blocks+0x244/0x6c0 [ext4]
Sep 21 07:05:32 kernel:
                        which lock already depends on the new lock.
Sep 21 07:05:32 kernel:
                        the existing dependency chain (in reverse order) is:
Sep 21 07:05:32 kernel:
                        -> #4 (&ei->i_data_sem){++++}:
Sep 21 07:05:32 kernel:        lock_acquire+0x1ec/0x220
Sep 21 07:05:32 kernel:        down_read+0x38/0x80
Sep 21 07:05:32 kernel:        ext4_map_blocks+0xf0/0x6c0 [ext4]
Sep 21 07:05:32 kernel:        ext4_mpage_readpages+0x214/0x760 [ext4]
Sep 21 07:05:32 kernel:        ext4_readpages+0x40/0x60 [ext4]
Sep 21 07:05:32 kernel:        __do_page_cache_readahead+0x26c/0x3a0
Sep 21 07:05:32 kernel:        filemap_fault+0x168/0x780
Sep 21 07:05:32 kernel:        ext4_filemap_fault+0x24/0x40 [ext4]
Sep 21 07:05:32 kernel:        __do_fault+0x18/0xe0
Sep 21 07:05:32 kernel:        __handle_mm_fault+0xb10/0xee0
Sep 21 07:05:32 kernel:        handle_mm_fault+0x26c/0x2e0
Sep 21 07:05:32 kernel:        do_sparc64_fault+0x454/0x820
Sep 21 07:05:32 kernel:        sparc64_realfault_common+0x10/0x20
Sep 21 07:05:32 kernel:        NGbzero_loop+0x0/0x38
Sep 21 07:05:32 kernel:        search_binary_handler+0x98/0x2c0
Sep 21 07:05:32 kernel:        do_execveat_common.isra.8+0x644/0x960
Sep 21 07:05:32 kernel:        SyS_execve+0x2c/0x40
Sep 21 07:05:32 kernel:        linux_sparc_syscall+0x34/0x44
Sep 21 07:05:32 kernel:
                        -> #3 (&ei->i_mmap_sem){++++}:
Sep 21 07:05:32 kernel:        lock_acquire+0x1ec/0x220
Sep 21 07:05:32 kernel:        down_read+0x38/0x80
Sep 21 07:05:32 kernel:        ext4_filemap_fault+0x1c/0x40 [ext4]
Sep 21 07:05:32 kernel:        __do_fault+0x18/0xe0
Sep 21 07:05:32 kernel:        __handle_mm_fault+0xb10/0xee0
Sep 21 07:05:32 kernel:        handle_mm_fault+0x26c/0x2e0
Sep 21 07:05:32 kernel:        do_sparc64_fault+0x454/0x820
Sep 21 07:05:32 kernel:        sparc64_realfault_common+0x10/0x20
Sep 21 07:05:32 kernel:        NGbzero_loop+0x0/0x38
Sep 21 07:05:32 kernel:        search_binary_handler+0x98/0x2c0
Sep 21 07:05:32 kernel:        do_execveat_common.isra.8+0x644/0x960
Sep 21 07:05:32 kernel:        SyS_execve+0x2c/0x40
Sep 21 07:05:32 kernel:        linux_sparc_syscall+0x34/0x44
Sep 21 07:05:32 kernel:
                        -> #2 (&mm->mmap_sem){++++}:
Sep 21 07:05:32 kernel:        lock_acquire+0x1ec/0x220
Sep 21 07:05:32 kernel:        __might_fault+0x64/0xa0
Sep 21 07:05:32 kernel:        filldir+0x8c/0x120
Sep 21 07:05:32 kernel:        dcache_readdir+0x40/0x160
Sep 21 07:05:32 kernel:        iterate_dir+0xbc/0x1e0
Sep 21 07:05:32 kernel:        SyS_getdents+0x48/0xe0
Sep 21 07:05:32 kernel:        linux_sparc_syscall+0x34/0x44
Sep 21 07:05:32 kernel:
                        -> #1 (&sb->s_type->i_mutex_key#11){++++}:
Sep 21 07:05:32 kernel:        generic_file_write_iter+0x1c/0x200
Sep 21 07:05:32 kernel:        do_iter_readv_writev+0x138/0x1a0
Sep 21 07:05:32 kernel:        do_iter_write+0x6c/0x1a0
Sep 21 07:05:32 kernel:        vfs_iter_write+0x28/0x40
Sep 21 07:05:32 kernel:        lo_write_bvec+0x5c/0xe0 [loop]
Sep 21 07:05:32 kernel:
                        -> #0 ((complete)&ret.event){+.+.}:
Sep 21 07:05:32 kernel:        __lock_acquire+0x1444/0x1a80
Sep 21 07:05:32 kernel:        lock_acquire+0x1ec/0x220
Sep 21 07:05:32 kernel:        wait_for_common_io.constprop.0+0x3c/0x160
Sep 21 07:05:32 kernel:        wait_for_completion_io+0x14/0x40
Sep 21 07:05:32 kernel:        submit_bio_wait+0x68/0x80
Sep 21 07:05:32 kernel:        blkdev_issue_zeroout+0x4c/0x80
Sep 21 07:05:32 kernel:        ext4_issue_zeroout+0x3c/0x60 [ext4]
Sep 21 07:05:32 kernel:        ext4_ext_zeroout+0xbc/0xe0 [ext4]
Sep 21 07:05:32 kernel:
ext4_ext_convert_to_initialized+0xf84/0x1060 [ext4]
Sep 21 07:05:32 kernel:        ext4_ext_map_blocks+0xcb8/0x1b80 [ext4]
Sep 21 07:05:32 kernel:        ext4_map_blocks+0x26c/0x6c0 [ext4]
Sep 21 07:05:32 kernel:        ext4_writepages+0xb5c/0x1300 [ext4]
Sep 21 07:05:32 kernel:        do_writepages+0x34/0xa0
Sep 21 07:05:32 kernel:        __writeback_single_inode+0x1bc/0x9a0
Sep 21 07:05:32 kernel:        writeback_sb_inodes+0x374/0x560
Sep 21 07:05:32 kernel:        __writeback_inodes_wb+0x54/0xc0
Sep 21 07:05:32 kernel:        wb_writeback+0x2a4/0x620
Sep 21 07:05:32 kernel:        wb_workfn+0x2f8/0x700
Sep 21 07:05:32 kernel:        process_one_work+0x424/0x7c0
Sep 21 07:05:32 kernel:        worker_thread+0x338/0x5a0
Sep 21 07:05:32 kernel:        kthread+0x150/0x180
Sep 21 07:05:32 kernel:        ret_from_fork+0x1c/0x2c
Sep 21 07:05:32 kernel:                  (null)
Sep 21 07:05:32 kernel:
                        other info that might help us debug this:
Sep 21 07:05:32 kernel: Chain exists of:
                          (complete)&ret.event --> &ei->i_mmap_sem -->
&ei->i_data_sem
Sep 21 07:05:32 kernel:  Possible unsafe locking scenario:
Sep 21 07:05:32 kernel:        CPU0                    CPU1
Sep 21 07:05:32 kernel:        ----                    ----
Sep 21 07:05:32 kernel:   lock(&ei->i_data_sem);
Sep 21 07:05:32 kernel:                                lock(&ei->i_mmap_sem);
Sep 21 07:05:32 kernel:                                lock(&ei->i_data_sem);
Sep 21 07:05:32 kernel:   lock((complete)&ret.event);
Sep 21 07:05:32 kernel:
                         *** DEADLOCK ***
Sep 21 07:05:32 kernel: 6 locks held by kworker/u512:0/875:
Sep 21 07:05:32 kernel:  #0:  ("writeback"){+.+.}, at:
[<000000000048b854>] process_one_work+0x234/0x7c0
Sep 21 07:05:32 kernel:  #1:  ((&(&wb->dwork)->work)){+.+.}, at:
[<000000000048b854>] process_one_work+0x234/0x7c0
Sep 21 07:05:32 kernel:  #2:  (&type->s_umount_key#30){++++}, at:
[<0000000000661bcc>] trylock_super+0xc/0x60
Sep 21 07:05:32 kernel:  #3:  (&sbi->s_journal_flag_rwsem){.+.+}, at:
[<00000000005d2d54>] do_writepages+0x34/0xa0
Sep 21 07:05:32 kernel:  #4:  (jbd2_handle){++++}, at:
[<0000000010030994>] start_this_handle+0x334/0x400 [jbd2]
Sep 21 07:05:32 kernel:  #5:  (&ei->i_data_sem){++++}, at:
[<000000001008ba64>] ext4_map_blocks+0x244/0x6c0 [ext4]
Sep 21 07:05:32 kernel:
                        stack backtrace:
Sep 21 07:05:32 kernel: CPU: 16 PID: 875 Comm: kworker/u512:0 Not
tainted 4.14.0-rc1 #456
Sep 21 07:05:32 kernel: Workqueue: writeback wb_workfn (flush-254:0)
Sep 21 07:05:32 kernel: Call Trace:
Sep 21 07:05:32 kernel:  [00000000004cea84] print_circular_bug+0x3c4/0x400
Sep 21 07:05:32 kernel:  [00000000004cf90c] check_prev_add+0x16c/0xa60
Sep 21 07:05:32 kernel:  [00000000004d3a24] __lock_acquire+0x1444/0x1a80
Sep 21 07:05:32 kernel:  [00000000004d4c0c] lock_acquire+0x1ec/0x220
Sep 21 07:05:32 kernel:  [00000000009f445c]
wait_for_common_io.constprop.0+0x3c/0x160
Sep 21 07:05:32 kernel:  [00000000009f4594] wait_for_completion_io+0x14/0x40
Sep 21 07:05:32 kernel:  [000000000077ac88] submit_bio_wait+0x68/0x80
Sep 21 07:05:32 kernel:  [000000000079340c] blkdev_issue_zeroout+0x4c/0x80
Sep 21 07:05:32 kernel:  [000000001008b7fc] ext4_issue_zeroout+0x3c/0x60 [ext4]
Sep 21 07:05:32 kernel:  [000000001006ab9c] ext4_ext_zeroout+0xbc/0xe0 [ext4]
Sep 21 07:05:32 kernel:  [0000000010071ca4]
ext4_ext_convert_to_initialized+0xf84/0x1060 [ext4]
Sep 21 07:05:32 kernel:  [0000000010074a58]
ext4_ext_map_blocks+0xcb8/0x1b80 [ext4]
Sep 21 07:05:32 kernel:  [000000001008ba8c] ext4_map_blocks+0x26c/0x6c0 [ext4]
Sep 21 07:05:32 kernel:  [000000001009143c] ext4_writepages+0xb5c/0x1300 [ext4]
Sep 21 07:05:32 kernel:  [00000000005d2d54] do_writepages+0x34/0xa0
Sep 21 07:05:32 kernel:  [0000000000698ddc] __writeback_single_inode+0x1bc/0x9a0


What could be done to help fix this issue?

Thanks.
