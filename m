From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 21 Sep 2015 07:38:26 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <CACVXFVNe5TrYr9gPrR4ggtg1cSbCcNt4_=vkBsGOv3fKocCzPg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
	<CACVXFVN2fgG_rLTMby=bY+1sWzoGryKq_aCU2S0=chAX9MUvog@mail.gmail.com>
	<alpine.LRH.2.20.1509211024110.530@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1509211024110.530@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>

On Mon, Sep 21, 2015 at 3:26 PM, Meelis Roos <mroos@linux.ee> wrote:
>> On Tue, Sep 15, 2015 at 3:06 AM, Meelis Roos <mroos@linux.ee> wrote:
>> > This is 4.3.0-rc1 on Sun E220R (dual-CPU sparc64). Sometimes it boots,
>> > sometimes it fails to boot with looping errors and finally a watchdog
>> > timeout. This console log from a failure. Config is below.
>> >
> [...]
>> > [   90.956986] netconsole: network logging started
>> > [   91.011243] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-09-14 12:31:56 UTC (1442233916)?   91.636785] scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
>> > [   91.732863] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
>> > [   91.826592] scsi target0:0:0: Beginning Domain Validation
>> > [   91.894554] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
>> > [   91.983049] scsi target0:0:0: Domain Validation skipping write tests
>> > [   92.058187] scsi target0:0:0: Ending Domain Validation
>> > [   93.590588] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
>> > [   93.686649] scsi target0:0:6: Beginning Domain Validation
>> > [   93.753328] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
>> > [   93.836962] scsi target0:0:6: Domain Validation skipping write tests
>> > [   93.912162] scsi target0:0:6: Ending Domain Validation
>> > [   96.317514] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
>> > [   96.408799] sd 0:0:0:0: [sda] Write Protect is off
>> > [   96.465258] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
>> > [   96.527504] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
>> > [   96.641946]  sda: sda1 sda2 sda3 sda4
>> > [   96.688204] kworker/u4:0 (570) used greatest stack depth: 9104 bytes left
>> > [   96.709472] sd 0:0:0:0: [sda] Attached SCSI disk
>> > [   98.020598] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
>> > [   98.112011] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
>> > [   98.227702] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
>> > [   98.318525] VFS: Mounted root (ext4 filesystem) readonly on device 259:262144.
>> > [   98.436651] devtmpfs: mounted
>> > Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
>> > g??????ɹ?????ѥ???H?   99.248602] stty (586) used greatest stack depth: 8216 bytes left
>> > [   99.484619] tput (590) used greatest stack depth: 8088 bytes left
>> > [info] Using makefile-style concurrent boot in runlevel S.
>> > [  100.116965] ps (660) used greatest stack depth: 7728 bytes left
>> > unparseable line (c! /dev/autofs 0600 - - - 10:235)
>> > unparseable line (c! /dev/fuse 0600 - - - 10:229)
>> > unparseable line (c! /dev/cuse 0600 - - - 10:203)
>> > unparse[  100.356492] random: udevd urandom read with 18 bits of entropy available
>> > able line (c! /dev/loop-control 0600 - - - 10:237)
>> > unparseable line (c! /dev/net/tun 0600 - - - 10:200)
>> > unparseable line (c! /dev/uhid 0600 - - - 10:239)
>> > [....] Starting the hotplug events dispatcher: udevdstarting version 218
>> > [ ok .
>> > [....] Synthesizing the initial hotplug events...[ ok done.
>> > [  101.056708] hwclock (716) used greatest stack depth: 7608 bytes left
>> > [....] Waiting f[  101.148930] sd 0:0:0:0: Attached scsi generic sg0 type 0
>> > [  101.212727] scsi 0:0:6:0: Attached scsi generic sg1 type 5
>> > or [  101.281691] PCI: Enabling device: (0000:00:01.1), cmd 2
>> > [  101.289700] sr 0:0:6:0: [sr0] scsi-1 drive
>> > [  101.289710] cdrom: Uniform CD-ROM driver Revision: 3.20
>> > [  101.348345] sr 0:0:6:0: Attached scsi CD-ROM sr0
>> > [  101.393029] cdrom_id (726) used greatest stack depth: 7456 bytes left
>> > [  101.587083] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
>> > /d[  101.678086] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:c7:a3:81
>> > ev to be fully populated...[ ok done.
>> > [....] Setting preliminary keymap...[ ok done.
>> > [....] Activating swap...[  104.354886] Adding 1582392k swap on /dev/sda4.  Priority:-1 extents:1 across:1582392k
>> > [ ok done.
>> > [  104.582832] EXT4-fs (sda2): re-mounted. Opts: (null)
>> > [....] Checking root file system...fsck from util-linux 2.26.2
>> > /dev/sda2: clean, 134168/2142112 files, 1452575/8558628 blocks
>> > [ ok   104.917474] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
>> > 25hdone.
>> > [....] Activating lvm and md swap...[ ok done.
>> > [....] Checking file systems...fsck from util-linux 2.26.2
>> > /dev/sda1: clean, 40/48192 files, 43342/96390 blocks
>> > [ ok done.
>> > [....] Cleaning up temporary files... /tmp[ ok .
>> > [  106.370834] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.
>>
>> Akinobu found there is one race between CPU hotplug and add_disk, maybe
>> you can try the patch in the following link to see if it can fix your issue.
>>
>>                  https://lkml.org/lkml/2015/7/18/99
>
> What version is it against? Does not compile against 4.3-rc1:
>
>   CC      block/blk-mq-sysfs.o
> block/blk-mq-sysfs.c: In function ‘blk_mq_unregister_disk’:
> block/blk-mq-sysfs.c:401:3: error: ‘struct request_queue’ has no member named ‘mq_sysfs_init_done’
>   q->mq_sysfs_init_done = false;

I guess the patch is applied mistakenly because 'mq_sysfs_init_done' is just
introduced from this patch.

>    ^
> block/blk-mq-sysfs.c: In function ‘blk_mq_register_disk’:
> block/blk-mq-sysfs.c:452:4: error: ‘struct request_queue’ has no member named ‘mq_sysfs_init_done’
>    q->mq_sysfs_init_done = true;
>     ^
> block/blk-mq-sysfs.c: In function ‘blk_mq_sysfs_unregister’:
> block/blk-mq-sysfs.c:465:8: error: ‘struct request_queue’ has no member named ‘mq_sysfs_init_done’
>   if (!q->mq_sysfs_init_done)
>         ^
> block/blk-mq-sysfs.c: In function ‘blk_mq_sysfs_register’:
> block/blk-mq-sysfs.c:477:8: error: ‘struct request_queue’ has no member named ‘mq_sysfs_init_done’
>   if (!q->mq_sysfs_init_done)
>         ^
> scripts/Makefile.build:258: recipe for target 'block/blk-mq-sysfs.o' failed
>
>
> --
> Meelis Roos (mroos@linux.ee)



-- 
Ming Lei
