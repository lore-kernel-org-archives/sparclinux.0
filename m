From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 18 May 2020 18:18:25 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200518181825.GM23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
 <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
 <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
 <20200517221346.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200517221346.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, David Miller <davem@davemloft.net>, arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, May 17, 2020 at 11:13:47PM +0100, Al Viro wrote:

> 	Is virtio-blk-pci more resilent to lost interrupt bug introduced in 
> "sun4u: update PCI topology to include simba PCI bridges"?  I hadn't tried
> it yet (reverted to the last working mainline qemu commit for now); IDE
> definitely is screwed by that - both the Linux and NetBSD drivers, actually.
> 
> 	A 50Mb worth of wget(1) is more than enough to trigger that crap;
> 
> commit 063833a6ec
> Merge: d634fc0499 bcf9e2c2f2
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Thu Oct 19 18:42:51 2017 +0100
> 
>     Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging
> 
> hangs, d634fc0499 works, bcf9e2c2f2 hangs.
> 
> I hadn't looked into details (the branch itself is only two commits long, but it
> incorporates an openbios update - 35 commits there, some obviously pci- and
> sun4u-related), but it's really easy to reproduce - -m 1024 and -hda <image>
> are probably the only relevant arguments.  Even dd if=/dev/sda of=/dev/null bsdm
> is often enough to hang it, so I rather doubt that networking (e1000 on pciB,
> FWIW, with tap for backend) has anything to do with that.

	FWIW, virtio-blk-pci does appear to be much more resilent; I hadn't been
able to reproduce hangs on that, while mounting identical fs from pata_cmd64x
and doing the same aptitude dist-upgrade --download-only ended up with

...
Note: Using 'Download Only' mode, no other actions will be performed.
Do you want to continue? [Y/n/?] y
Get: 1 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl-modules-5.30 all 5.30.2-1 [2,806 kB]
Get: 2 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libperl5.30 sparc64 5.30.2-1 [3,388 kB]
Get: 3 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl sparc64 5.30.2-1 [290 kB]
Get: 4 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl-base sparc64 5.30.2-1 [1,427 kB]
Get: 5 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libsystemd0 sparc64 245.5-3 [309 kB]
Get: 6 http://ftp.ports.debian.org/debian-ports sid/main sparc64 udev sparc64 245.5-3 [1,356 kB]
Get: 7 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libudev1 sparc64 245.5-3 [153 kB]
[ 1472.613660] ata2: lost interrupt (Status 0x58)
[ 1472.615124] ata1: lost interrupt (Status 0x50)
[ 1472.615812] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1472.616515] ata1.00: failed command: WRITE DMA
[ 1472.617145] ata1.00: cmd ca/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 dma 49152 out
[ 1472.617145]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1472.618229] ata1.00: status: { DRDY }
[ 1472.618743] ata1: soft resetting link
[ 1472.779489] ata1.00: configured for UDMA/33
[ 1472.781211] ata1: EH complete
[ 1477.977424] ata2.00: qc timeout (cmd 0xa0)
[ 1477.977897] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[ 1483.353324] ata2.00: qc timeout (cmd 0xa0)
[ 1483.353697] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[ 1483.354453] ata2.00: limiting speed to UDMA/33:PIO3
[ 1488.729323] ata2.00: qc timeout (cmd 0xa0)
[ 1488.730255] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[ 1488.731320] ata2.00: disabled
[ 1503.333388] ata1: lost interrupt (Status 0x50)
[ 1503.333838] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1503.334309] ata1.00: failed command: WRITE DMA EXT
[ 1503.334647] ata1.00: cmd 35/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 dma 155648 out
[ 1503.334647]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1503.335494] ata1.00: status: { DRDY }
[ 1503.335858] ata1: soft resetting link
[ 1503.494764] ata1.00: configured for UDMA/33
[ 1503.495313] ata1: EH complete
[ 1534.041532] ata1: lost interrupt (Status 0x50)
[ 1534.042043] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1534.042627] ata1.00: failed command: WRITE DMA
[ 1534.042969] ata1.00: cmd ca/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 dma 49152 out
[ 1534.042969]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1534.043902] ata1.00: status: { DRDY }
[ 1534.044306] ata1: soft resetting link
[ 1534.202625] ata1.00: configured for UDMA/33
[ 1534.203119] ata1: EH complete
[ 1564.761561] ata1: lost interrupt (Status 0x50)
[ 1564.762351] ata1.00: limiting speed to UDMA/25:PIO4
[ 1564.762831] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1564.763388] ata1.00: failed command: WRITE DMA EXT
[ 1564.763790] ata1.00: cmd 35/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 dma 155648 out
[ 1564.763790]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1564.764784] ata1.00: status: { DRDY }
[ 1564.765470] ata1: soft resetting link
[ 1564.926509] ata1.00: configured for UDMA/25
[ 1564.927516] ata1: EH complete
[ 1575.001438] INFO: task jbd2/sda2-8:143 blocked for more than 120 seconds.
[ 1575.002273]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1575.002755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1575.003323] jbd2/sda2-8     D    0   143      2 0x07000000
[ 1575.003867] Call Trace:
[ 1575.004228]  [0000000000b10834] schedule+0x54/0x100
[ 1575.004598]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1575.004922]  [00000000007a6ac4] rq_qos_wait+0xc4/0x160
[ 1575.009472]  [00000000007b5274] wbt_wait+0x74/0xe0
[ 1575.009832]  [00000000007a6760] __rq_qos_throttle+0x20/0x40
[ 1575.010191]  [00000000007975f0] blk_mq_make_request+0xf0/0x5a0
[ 1575.010558]  [000000000078b418] generic_make_request+0x98/0x2e0
[ 1575.010923]  [000000000078b6b8] submit_bio+0x58/0x200
[ 1575.011245]  [000000000067f100] submit_bh_wbc+0x1c0/0x200
[ 1575.011583]  [000000000067f91c] submit_bh+0x1c/0x40
[ 1575.012627]  [0000000010167d7c] jbd2_journal_commit_transaction+0x69c/0x1740 [jbd2]
[ 1575.013300]  [000000001016d530] kjournald2+0x90/0x220 [jbd2]
[ 1575.013706]  [000000000048913c] kthread+0xdc/0x120
[ 1575.014012]  [0000000000405fa4] ret_from_fork+0x1c/0x2c
[ 1575.014565]  [0000000000000000] 0x0
[ 1575.014888] INFO: task http:1294 blocked for more than 120 seconds.
[ 1575.015287]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1575.015728] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1575.016208] http            D    0  1294   1283 0x208000105000000
[ 1575.016616] Call Trace:
[ 1575.016803]  [0000000000b10834] schedule+0x54/0x100
[ 1575.017289]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1575.017654]  [00000000007a6ac4] rq_qos_wait+0xc4/0x160
[ 1575.018011]  [00000000007b5274] wbt_wait+0x74/0xe0
[ 1575.018328]  [00000000007a6760] __rq_qos_throttle+0x20/0x40
[ 1575.018677]  [00000000007975f0] blk_mq_make_request+0xf0/0x5a0
[ 1575.019047]  [000000000078b418] generic_make_request+0x98/0x2e0
[ 1575.019421]  [000000000078b6b8] submit_bio+0x58/0x200
[ 1575.019825]  [00000000101dcf64] ext4_io_submit+0x44/0x60 [ext4]
[ 1575.020249]  [00000000101c0108] ext4_writepages+0x508/0xc20 [ext4]
[ 1575.020634]  [00000000005b0790] do_writepages+0x30/0xe0
[ 1575.021000]  [00000000005a7618] __filemap_fdatawrite_range+0xb8/0x100
[ 1575.021542]  [00000000005a76bc] filemap_flush+0x1c/0x40
[ 1575.021944]  [00000000101bce24] ext4_alloc_da_blocks+0x24/0x80 [ext4]
[ 1575.022387]  [00000000101abf30] ext4_release_file+0x90/0xe0 [ext4]
[ 1575.022777]  [000000000063d1cc] __fput+0xac/0x280
[ 1595.481559] ata1: lost interrupt (Status 0x50)
[ 1595.482352] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1595.483223] ata1.00: failed command: WRITE DMA
[ 1595.483799] ata1.00: cmd ca/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 dma 49152 out
[ 1595.483799]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1595.485513] ata1.00: status: { DRDY }
[ 1595.489629] ata1: soft resetting link
[ 1595.650743] ata1.00: configured for UDMA/25
[ 1595.651259] ata1: EH complete
[ 1626.201466] ata1: lost interrupt (Status 0x50)
[ 1626.202778] ata1.00: limiting speed to PIO4
[ 1626.203678] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1626.205103] ata1.00: failed command: WRITE DMA EXT
[ 1626.206127] ata1.00: cmd 35/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 dma 155648 out
[ 1626.206127]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1626.208832] ata1.00: status: { DRDY }
[ 1626.209856] ata1: soft resetting link
[ 1626.370839] ata1.00: configured for PIO4
[ 1626.371357] ata1: EH complete
[ 1656.921546] ata1: lost interrupt (Status 0x58)
[ 1656.922076] ata1.00: limiting speed to PIO3
[ 1656.922390] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1656.922837] ata1.00: failed command: WRITE MULTIPLE
[ 1656.923190] ata1.00: cmd c5/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 pio 49152 out
[ 1656.923190]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1656.924057] ata1.00: status: { DRDY }
[ 1656.924441] ata1: soft resetting link
[ 1657.082383] ata1.00: configured for PIO3
[ 1657.082940] ata1: EH complete
[ 1687.641729] ata1: lost interrupt (Status 0x58)
[ 1687.642217] ata1.00: limiting speed to PIO0
[ 1687.642526] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1687.642963] ata1.00: failed command: WRITE MULTIPLE EXT
[ 1687.643336] ata1.00: cmd 39/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 pio 155648 out
[ 1687.643336]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1687.644276] ata1.00: status: { DRDY }
[ 1687.644649] ata1: soft resetting link
[ 1687.802485] ata1.00: configured for PIO0
[ 1687.802946] ata1: EH complete
[ 1695.833443] INFO: task jbd2/sda2-8:143 blocked for more than 241 seconds.
[ 1695.834181]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1695.834915] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1695.835667] jbd2/sda2-8     D    0   143      2 0x07000000
[ 1695.836230] Call Trace:
[ 1695.836537]  [0000000000b10834] schedule+0x54/0x100
[ 1695.837186]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1695.837753]  [00000000007a6ac4] rq_qos_wait+0xc4/0x160
[ 1695.838244]  [00000000007b5274] wbt_wait+0x74/0xe0
[ 1695.838717]  [00000000007a6760] __rq_qos_throttle+0x20/0x40
[ 1695.839247]  [00000000007975f0] blk_mq_make_request+0xf0/0x5a0
[ 1695.839811]  [000000000078b418] generic_make_request+0x98/0x2e0
[ 1695.840366]  [000000000078b6b8] submit_bio+0x58/0x200
[ 1695.840841]  [000000000067f100] submit_bh_wbc+0x1c0/0x200
[ 1695.841561]  [000000000067f91c] submit_bh+0x1c/0x40
[ 1695.842111]  [0000000010167d7c] jbd2_journal_commit_transaction+0x69c/0x1740 [jbd2]
[ 1695.842851]  [000000001016d530] kjournald2+0x90/0x220 [jbd2]
[ 1695.843392]  [000000000048913c] kthread+0xdc/0x120
[ 1695.843860]  [0000000000405fa4] ret_from_fork+0x1c/0x2c
[ 1695.844355]  [0000000000000000] 0x0
[ 1695.844707] INFO: task http:1294 blocked for more than 241 seconds.
[ 1695.845478]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1695.846180] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1695.846905] http            D    0  1294   1283 0x208000105000000
[ 1695.847500] Call Trace:
[ 1695.847786]  [0000000000b10834] schedule+0x54/0x100
[ 1695.848272]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1695.848757]  [00000000007a6ac4] rq_qos_wait+0xc4/0x160
[ 1695.849477]  [00000000007b5274] wbt_wait+0x74/0xe0
[ 1695.850000]  [00000000007a6760] __rq_qos_throttle+0x20/0x40
[ 1695.850557]  [00000000007975f0] blk_mq_make_request+0xf0/0x5a0
[ 1695.851107]  [000000000078b418] generic_make_request+0x98/0x2e0
[ 1695.851650]  [000000000078b6b8] submit_bio+0x58/0x200
[ 1695.852214]  [00000000101dcf64] ext4_io_submit+0x44/0x60 [ext4]
[ 1695.852837]  [00000000101c0108] ext4_writepages+0x508/0xc20 [ext4]
[ 1695.853638]  [00000000005b0790] do_writepages+0x30/0xe0
[ 1695.854162]  [00000000005a7618] __filemap_fdatawrite_range+0xb8/0x100
[ 1695.854765]  [00000000005a76bc] filemap_flush+0x1c/0x40
[ 1695.855316]  [00000000101bce24] ext4_alloc_da_blocks+0x24/0x80 [ext4]
[ 1695.855973]  [00000000101abf30] ext4_release_file+0x90/0xe0 [ext4]
[ 1695.856568]  [000000000063d1cc] __fput+0xac/0x280
[ 1695.857152] INFO: task kworker/0:3:1295 blocked for more than 120 seconds.
[ 1695.857878]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1695.858550] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1695.859262] kworker/0:3     D    0  1295      2 0x01000000
[ 1695.860238] Workqueue: events ata_scsi_dev_rescan [libata]
[ 1695.860828] Call Trace:
[ 1695.861273]  [0000000000b10834] schedule+0x54/0x100
[ 1695.861814]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1695.862295]  [000000000079a33c] blk_mq_get_tag+0x11c/0x2c0
[ 1695.862826]  [0000000000794e28] blk_mq_get_request+0xc8/0x3a0
[ 1695.863294]  [000000000079514c] blk_mq_alloc_request+0x4c/0xa0
[ 1695.863686]  [00000000007896f0] blk_get_request+0x30/0xe0
[ 1695.864093]  [000000001003bd14] __scsi_execute+0x34/0x1a0 [scsi_mod]
[ 1695.864544]  [0000000010034c6c] scsi_vpd_inquiry+0x6c/0xc0 [scsi_mod]
[ 1695.865018]  [0000000010034dec] scsi_get_vpd_buf+0x4c/0x80 [scsi_mod]
[ 1695.865640]  [0000000010035afc] scsi_attach_vpd+0x3c/0x180 [scsi_mod]
[ 1695.866099]  [00000000100402f8] scsi_rescan_device+0x18/0xa0 [scsi_mod]
[ 1695.866568]  [00000000100a6620] ata_scsi_dev_rescan+0x80/0xe0 [libata]
[ 1695.867009]  [0000000000482eb4] process_one_work+0x194/0x480
[ 1695.867392]  [00000000004832e4] worker_thread+0x144/0x540
[ 1695.867759]  [000000000048913c] kthread+0xdc/0x120
[ 1695.868095]  [0000000000405fa4] ret_from_fork+0x1c/0x2c
[ 1718.361472] ata1: lost interrupt (Status 0x58)
[ 1718.362753] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1718.364199] ata1.00: failed command: WRITE MULTIPLE
[ 1718.365436] ata1.00: cmd c5/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 pio 49152 out
[ 1718.365436]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1718.368421] ata1.00: status: { DRDY }
[ 1718.369510] ata1: soft resetting link
[ 1718.530645] ata1.00: configured for PIO0
[ 1718.531608] ata1: EH complete
[ 1749.081528] ata1: lost interrupt (Status 0x58)
[ 1749.082016] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1749.082490] ata1.00: failed command: WRITE MULTIPLE EXT
[ 1749.082861] ata1.00: cmd 39/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 pio 155648 out
[ 1749.082861]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1749.083785] ata1.00: status: { DRDY }
[ 1749.084186] ata1: soft resetting link
[ 1749.242344] ata1.00: configured for PIO0
[ 1749.242776] ata1: EH complete
[ 1779.801525] ata1: lost interrupt (Status 0x58)
[ 1779.802194] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1779.802933] ata1.00: failed command: WRITE MULTIPLE
[ 1779.803424] ata1.00: cmd c5/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 pio 49152 out
[ 1779.803424]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1779.804678] ata1.00: status: { DRDY }
[ 1779.805327] ata1: soft resetting link
[ 1779.966461] ata1.00: configured for PIO0
[ 1779.968232] sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age38s
[ 1779.969221] sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
[ 1779.969921] sd 0:0:0:0: [sda] tag#0 Add. Sense: Unaligned write command
[ 1779.971038] sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 00 23 9b 0c 00 00 60 00
[ 1779.971722] blk_update_request: I/O error, dev sda, sector 2333452 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
[ 1779.972504] EXT4-fs warning (device sda2): ext4_end_bio:347: I/O error 10 writing to inode 130691 starting block 291693)
[ 1779.973770] ata1: EH complete
[ 1810.521509] ata1: lost interrupt (Status 0x58)
[ 1810.522165] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1810.522895] ata1.00: failed command: WRITE MULTIPLE EXT
[ 1810.523415] ata1.00: cmd 39/00:30:0c:7b:23/00:01:00:00:00/e0 tag 0 pio 155648 out
[ 1810.523415]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1810.524696] ata1.00: status: { DRDY }
[ 1810.525363] ata1: soft resetting link
[ 1810.686255] ata1.00: configured for PIO0
[ 1810.686951] sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age37s
[ 1810.687809] sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
[ 1810.688449] sd 0:0:0:0: [sda] tag#0 Add. Sense: Unaligned write command
[ 1810.689213] sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 00 23 7b 0c 00 01 30 00
[ 1810.689966] blk_update_request: I/O error, dev sda, sector 2325260 op 0x1:(WRITE) flags 0x0 phys_seg 3 prio class 0
[ 1810.690901] EXT4-fs warning (device sda2): ext4_end_bio:347: I/O error 10 writing to inode 130696 starting block 290695)
[ 1810.692093] ata1: EH complete
[ 1841.253842] ata1: lost interrupt (Status 0x58)
[ 1841.254522] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1841.255276] ata1.00: failed command: WRITE MULTIPLE
[ 1841.255781] ata1.00: cmd c5/00:78:d4:61:49/00:00:00:00:00/e0 tag 0 pio 61440 out
[ 1841.255781]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1841.257269] ata1.00: status: { DRDY }
[ 1841.257820] ata1: soft resetting link
[ 1841.418388] ata1.00: configured for PIO0
[ 1841.418961] ata1: EH complete
[ 1871.973375] ata1: lost interrupt (Status 0x58)
[ 1871.973863] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1871.974338] ata1.00: failed command: WRITE MULTIPLE
[ 1871.974727] ata1.00: cmd c5/00:a0:8c:0e:3b/00:00:00:00:00/e0 tag 0 pio 81920 out
[ 1871.974727]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1871.975707] ata1.00: status: { DRDY }
[ 1871.976096] ata1: soft resetting link
[ 1872.134384] ata1.00: configured for PIO0
[ 1872.134988] ata1: EH complete
[ 1902.681573] ata1: lost interrupt (Status 0x58)
[ 1902.682340] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1902.683115] ata1.00: failed command: WRITE MULTIPLE
[ 1902.683674] ata1.00: cmd c5/00:78:d4:61:49/00:00:00:00:00/e0 tag 0 pio 61440 out
[ 1902.683674]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1902.685158] ata1.00: status: { DRDY }
[ 1902.689610] ata1: soft resetting link
[ 1902.850306] ata1.00: configured for PIO0
[ 1902.850767] ata1: EH complete
[ 1933.401429] ata1: lost interrupt (Status 0x58)
[ 1933.401961] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1933.402474] ata1.00: failed command: WRITE MULTIPLE
[ 1933.402878] ata1.00: cmd c5/00:a0:8c:0e:3b/00:00:00:00:00/e0 tag 0 pio 81920 out
[ 1933.402878]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[ 1933.403875] ata1.00: status: { DRDY }
[ 1933.404289] ata1: soft resetting link
[ 1933.562384] ata1.00: configured for PIO0
[ 1933.562869] ata1: EH complete
[ 1937.497217] INFO: task jbd2/sda2-8:143 blocked for more than 120 seconds.
[ 1937.497777]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1937.498257] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1937.498777] jbd2/sda2-8     D    0   143      2 0x03000000
[ 1937.499174] Call Trace:
[ 1937.499400]  [0000000000b10834] schedule+0x54/0x100
[ 1937.499746]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1937.500100]  [0000000000b1108c] bit_wait_io+0xc/0x80
[ 1937.500450]  [0000000000b10c80] __wait_on_bit+0x60/0x100
[ 1937.500815]  [0000000000b10d9c] out_of_line_wait_on_bit+0x7c/0xa0
[ 1937.501357]  [000000000067d6d0] __wait_on_buffer+0x30/0x40
[ 1937.501796]  [00000000101685d4] jbd2_journal_commit_transaction+0xef4/0x1740 [jbd2]
[ 1937.502330]  [000000001016d530] kjournald2+0x90/0x220 [jbd2]
[ 1937.502728]  [000000000048913c] kthread+0xdc/0x120
[ 1937.503061]  [0000000000405fa4] ret_from_fork+0x1c/0x2c
[ 1937.503407]  [0000000000000000] 0x0
[ 1937.503658] INFO: task kworker/u2:2:1138 blocked for more than 120 seconds.
[ 1937.504096]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1937.504544] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1937.505128] kworker/u2:2    D    0  1138      2 0x05000000
[ 1937.505677] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work [ext4]
[ 1937.506109] Call Trace:
[ 1937.506306]  [0000000000b10834] schedule+0x54/0x100
[ 1937.506643]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1937.507007]  [0000000000b1108c] bit_wait_io+0xc/0x80
[ 1937.507361]  [0000000000b10c80] __wait_on_bit+0x60/0x100
[ 1937.507717]  [0000000000b10d9c] out_of_line_wait_on_bit+0x7c/0xa0
[ 1937.508150]  [0000000010166138] do_get_write_access+0x2f8/0x440 [jbd2]
[ 1937.508587]  [0000000010166300] jbd2_journal_get_write_access+0x80/0xa0 [jbd2]
[ 1937.509203]  [000000001019c400] __ext4_journal_get_write_access+0x20/0x60 [ext4]
[ 1937.509812]  [00000000101bf824] ext4_reserve_inode_write+0x84/0xc0 [ext4]
[ 1937.510301]  [00000000101bfa48] ext4_mark_inode_dirty+0x28/0x1e0 [ext4]
[ 1937.510766]  [000000001019ce74] __ext4_ext_dirty.isra.0+0x54/0xa0 [ext4]
[ 1937.511234]  [00000000101a66c8] ext4_ext_map_blocks+0x828/0x17c0 [ext4]
[ 1937.511699]  [00000000101bb638] ext4_map_blocks+0xd8/0x6a0 [ext4]
[ 1937.512134]  [00000000101a882c] ext4_convert_unwritten_extents+0x14c/0x200 [ext4]
[ 1937.512706]  [00000000101a894c] ext4_convert_unwritten_io_end_vec+0x6c/0x100 [ext4]
[ 1937.513388]  [00000000101dca00] ext4_end_io_rsv_work+0xe0/0x1c0 [ext4]
[ 1937.513853] INFO: task http:1294 blocked for more than 120 seconds.
[ 1937.514287]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1937.514735] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1937.515277] http            D    0  1294   1283 0x208000103000000
[ 1937.515732] Call Trace:
[ 1937.515925]  [0000000000b10834] schedule+0x54/0x100
[ 1937.516254]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1937.516586]  [0000000000b1108c] bit_wait_io+0xc/0x80
[ 1937.516924]  [0000000000b10c80] __wait_on_bit+0x60/0x100
[ 1937.517426]  [0000000000b10d9c] out_of_line_wait_on_bit+0x7c/0xa0
[ 1937.517897]  [0000000010166138] do_get_write_access+0x2f8/0x440 [jbd2]
[ 1937.518346]  [0000000010166300] jbd2_journal_get_write_access+0x80/0xa0 [jbd2]
[ 1937.518855]  [000000001019c400] __ext4_journal_get_write_access+0x20/0x60 [ext4]
[ 1937.519369]  [00000000101bf824] ext4_reserve_inode_write+0x84/0xc0 [ext4]
[ 1937.519883]  [00000000101bfa48] ext4_mark_inode_dirty+0x28/0x1e0 [ext4]
[ 1937.520365]  [00000000101c3c6c] ext4_dirty_inode+0x4c/0x80 [ext4]
[ 1937.520755]  [000000000066fe30] __mark_inode_dirty+0x130/0x340
[ 1937.521307]  [00000000101c38ec] ext4_setattr+0x50c/0x840 [ext4]
[ 1937.521744]  [000000000065c8c4] notify_change+0x384/0x560
[ 1937.522093]  [0000000000677104] utimes_common.isra.0+0xc4/0x1a0
[ 1937.522469]  [00000000006772e0] do_utimes+0x100/0x180
[ 1937.522799] INFO: task kworker/0:3:1295 blocked for more than 120 seconds.
[ 1937.523233]       Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[ 1937.523685] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1937.524186] kworker/0:3     D    0  1295      2 0x02000000
[ 1937.524633] Workqueue: events ata_scsi_dev_rescan [libata]
[ 1937.525100] Call Trace:
[ 1937.525348]  [0000000000b10834] schedule+0x54/0x100
[ 1937.525703]  [0000000000b10bf4] io_schedule+0x14/0x40
[ 1937.526040]  [000000000079a33c] blk_mq_get_tag+0x11c/0x2c0
[ 1937.526394]  [0000000000794e28] blk_mq_get_request+0xc8/0x3a0
[ 1937.526766]  [000000000079514c] blk_mq_alloc_request+0x4c/0xa0
[ 1937.527186]  [00000000007896f0] blk_get_request+0x30/0xe0
[ 1937.527581]  [000000001003bd14] __scsi_execute+0x34/0x1a0 [scsi_mod]
[ 1937.528022]  [0000000010034c6c] scsi_vpd_inquiry+0x6c/0xc0 [scsi_mod]
[ 1937.528485]  [0000000010034dec] scsi_get_vpd_buf+0x4c/0x80 [scsi_mod]
[ 1937.528938]  [0000000010034e30] scsi_update_vpd_page+0x10/0x60 [scsi_mod]
[ 1937.529530]  [0000000010035b90] scsi_attach_vpd+0xd0/0x180 [scsi_mod]
[ 1937.529988]  [00000000100402f8] scsi_rescan_device+0x18/0xa0 [scsi_mod]
[ 1937.530489]  [00000000100a6620] ata_scsi_dev_rescan+0x80/0xe0 [libata]
[ 1937.530906]  [0000000000482eb4] process_one_work+0x194/0x480
[ 1937.531270]  [00000000004832e4] worker_thread+0x144/0x540
[ 1937.531618]  [000000000048913c] kthread+0xdc/0x120

... at which point I killed the damn thing.  Unpingable, doesn't react to serial
console (the output is obviously there, the input doesn't reach shell, at the
very least).  That was on current debian kernel (5.6.0-based), but the mainline
5.7-rc1 behaves the same way.  qemu is (yesterday) mainline:

commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9 (HEAD -> master, origin/master, origin/HEAD)
Merge: 66706192de 9ecaf5ccec
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri May 15 19:51:16 2020 +0100

    Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging

and anything since bcf9e2c2f2 exhibits that behaviour.  qemu arguments:
../qemu1/build/sparc64-softmmu/qemu-system-sparc64 \
        -hda sid.img \
        -drive id=hd,if=none,file=foo.raw,format=raw \
        -device virtio-blk-pci,bus=pciB,drive=hd \
        -netdev tap,ifname=tap4,script=no,downscript=no,id=net \
        -device e1000,bus=pciB,netdev=net \
        -nographic -m 1024
foo.raw and sid.img have the same contents (sid.img is qcow2 - might or might not
cause enough timing differences to trigger whatever's happening).

Looks like something got screwed in PCI interrupt routing in that sun4u branch back in
2017.  If you have any suggestions on debugging that, I'd be glad to help; I'm not
familiar with openbios guts, though ;-/
