From: Bob Breuer <breuerr@mc.net>
Date: Sat, 11 Feb 2006 19:58:18 +0000
Subject: sparc32-smp: rwlock wrong owner
Message-Id: <43EE4251.1040302@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Running the previously posted SMP patch with 2.6.16-rc1-git4 on dual
SuperSPARC II's, it eventually died during updatedb:

BUG: rwlock wrong owner on CPU#0, pdflush/31, faeaeb48
[f0197518 : _write_unlock_irqrestore+0x8/0x1c ]
[f00639a8 : test_set_page_writeback+0xc8/0x12c ]
[f0083a30 : __block_write_full_page+0x104/0x418 ]
[f00a820c : mpage_writepages+0x25c/0x3e8 ]
[f006329c : do_writepages+0x40/0x74 ]
[f00a66f4 : __sync_single_inode+0x44/0x234 ]
[f00a6958 : __writeback_single_inode+0x74/0x17c ]
[f00a6c4c : sync_sb_inodes+0x1ec/0x30c ]
[f00a6e54 : writeback_inodes+0xe8/0xfc ]
[f006302c : wb_kupdate+0xc4/0x158 ]
[f0063b2c : __pdflush+0xe4/0x1c4 ]
[f0063c34 : pdflush+0x28/0x38 ]
[f004f768 : kthread+0xa8/0xc0 ]
[f001964c : kernel_thread+0x34/0x50 ]
[f004f790 : keventd_create_kthread+0x10/0x50 ]
Kernel panic - not syncing: bad locking


Any ideas on how to track this down?  Could it be a buggy rwlock
function, or something else?

The only spinlock and rwlock changes I've made are at the end of the
patch in:
  http://marc.theaimsgroup.com/?l=linux-sparc&m3822757706953&w=2

Bob

