From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 22 Sep 2019 08:37:30 +0000
Subject: Re: [sparc64] pktcdvd: setup of pktcdvd device failed
Message-Id: <CADxRZqxLoOSbtFd=n_1JMBrkdx67no0qJDUZUOr+UQ9qHiTdDg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz_TF7jyGtbg9cVSnCGh2VzfCoRGBdCU_yE_v1cveq1Pg@mail.gmail.com>
 <c02d0e0c-e468-003f-6b66-8592a987cbf8@kernel.dk>
In-Reply-To: <c02d0e0c-e468-003f-6b66-8592a987cbf8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, Sep 20, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/20/19 4:27 AM, Anatoly Pugachev wrote:
> > Hello!
> >
> > Getting the following call trace on boot on sparc64 ldom/machine with
> > current git kernel:
> >
> > ...
> > [   13.352975] aes_sparc64: Using sparc64 aes opcodes optimized AES
> > implementation
> > [   13.428002] ------------[ cut here ]------------
> > [   13.428081] WARNING: CPU: 21 PID: 586 at
> > drivers/block/pktcdvd.c:2597 pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
> > [   13.428147] Attempt to register a non-SCSI queue
> > [   13.428184] Modules linked in: pktcdvd libdes cdrom aes_sparc64
> > n2_rng md5_sparc64 sha512_sparc64 rng_core sha256_sparc64 flash
> > sha1_sparc64 ip_tables x_tables ipv6 crc_ccitt nf_defrag_ipv6 autofs4
> > ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy
> > async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear
> > md_mod crc32c_sparc64
> > [   13.428452] CPU: 21 PID: 586 Comm: pktsetup Not tainted
> > 5.3.0-10169-g574cc4539762 #1234
> > [   13.428507] Call Trace:
> > [   13.428542]  [00000000004635c0] __warn+0xc0/0x100
> > [   13.428582]  [0000000000463634] warn_slowpath_fmt+0x34/0x60
> > [   13.428626]  [000000001045b244] pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
> > [   13.428674]  [000000001045ccf4] pkt_ctl_ioctl+0x94/0x220 [pktcdvd]
> > [   13.428724]  [00000000006b95c8] do_vfs_ioctl+0x628/0x6e0
> > [   13.428764]  [00000000006b96c8] ksys_ioctl+0x48/0x80
> > [   13.428803]  [00000000006b9714] sys_ioctl+0x14/0x40
> > [   13.428847]  [0000000000406294] linux_sparc_syscall+0x34/0x44
> > [   13.428890] irq event stamp: 4181
> > [   13.428924] hardirqs last  enabled at (4189): [<00000000004e0a74>]
> > console_unlock+0x634/0x6c0
> > [   13.428984] hardirqs last disabled at (4196): [<00000000004e0540>]
> > console_unlock+0x100/0x6c0
> > [   13.429048] softirqs last  enabled at (3978): [<0000000000b2e2d8>]
> > __do_softirq+0x498/0x520
> > [   13.429110] softirqs last disabled at (3967): [<000000000042cfb4>]
> > do_softirq_own_stack+0x34/0x60
> > [   13.429172] ---[ end trace 2220ca468f32967d ]---
> > [   13.430018] pktcdvd: setup of pktcdvd device failed
> > [   13.455589] des_sparc64: Using sparc64 des opcodes optimized DES
> > implementation
> > [   13.515334] camellia_sparc64: Using sparc64 camellia opcodes
> > optimized CAMELLIA implementation
> > [   13.522856] pktcdvd: setup of pktcdvd device failed
> > [   13.529327] pktcdvd: setup of pktcdvd device failed
> > [   13.532932] pktcdvd: setup of pktcdvd device failed
> > [   13.536165] pktcdvd: setup of pktcdvd device failed
> > [   13.539372] pktcdvd: setup of pktcdvd device failed
> > [   13.542834] pktcdvd: setup of pktcdvd device failed
> > [   13.546536] pktcdvd: setup of pktcdvd device failed
> > [   15.431071] XFS (dm-0): Mounting V5 Filesystem
>
> Someone is running pktsetup to set up a device, at boot time. The device
> being passed in doesn't support pass-through commands.
>
> I believe there are two questions here:
>
> 1) Why is pktsetup being called? I don't expect anyone to use pktcdvd
>    anymore.
>
> 2) Given #1, what kind of device is being passed in?
>
> Do  you have some ancient funky init scripts?

Jens,

this is debian unstable (sid) sparc64 LDOM (read sparc virtual
machine) installation, nothing funky is done,
except of install of udftools (contains /usr/sbin/pktsetup) and was
installed for udf_test/mkudffs test/check for grub.git).

udftools package installs /lib/udev/rules.d/80-pktsetup.rules with a content:

# cat /lib/udev/rules.d/80-pktsetup.rules
# Create and remove packet writing device for each optical block device
ACTION="add", SUBSYSTEM="block", ENV{ID_CDROM}="1",
RUN+="/usr/sbin/pktsetup %E{MAJOR}:%E{MINOR}"
ACTION="remove", SUBSYSTEM="block", ENV{ID_CDROM}="1",
RUN+="/usr/sbin/pktsetup -d %E{MAJOR}:%E{MINOR}"

as well (unpacked) initrd has some udev hooks:

unpacked_initrd# find . -type f | xargs egrep "pkt(setup|cdvd)"
./usr/lib/udev/rules.d/50-udev-default.rules:KERNEL="pktcdvd[0-9]*",
GROUP="cdrom"
./usr/lib/udev/rules.d/50-udev-default.rules:KERNEL="pktcdvd", GROUP="cdrom"
./usr/lib/modules/5.3.0-10169-g574cc4539762/modules.order:kernel/drivers/block/pktcdvd.ko

I believe (which counts as number of message "setup of pktcdvd device
failed" appears in dmesg) pktsetup tries to setup /dev/vdiskd*
devices, which is virtual cdrom attached with iso file:

# lsblk -if -o NAME,FSTYPE,LABEL,RM
NAME           FSTYPE      LABEL                RM
vdiska         ext3                              0
|-vdiska1      ext3                              0
|-vdiska2      ext4                              0
|-vdiska3                                        0
`-vdiska4      swap        swapvol1              0
vdiskb                                           0
`-vdiskb1      xfs                               0
vdiskc         LVM2_member                       0
`-ttipvg1-vol1 xfs                               0
vdiskd         iso9660     Debian 9.0 sparc64 n  1
|-vdiskd1      iso9660     Debian 9.0 sparc64 n  1
|-vdiskd2      iso9660     Debian 9.0 sparc64 n  1
|-vdiskd3      iso9660     Debian 9.0 sparc64 n  1
|-vdiskd4      iso9660     Debian 9.0 sparc64 n  1
|-vdiskd5      iso9660     Debian 9.0 sparc64 n  1
|-vdiskd6      iso9660     Debian 9.0 sparc64 n  1
`-vdiskd7      iso9660     Debian 9.0 sparc64 n  1
vdiske                                           0
|-vdiske1      ext3                              0
|-vdiske2                                        0
`-vdiske3                                        0


PS: since it's debian unstable system, it has pretty fresh userspace
and my recently compiled git kernel (as well current debian unstable
kernel is 5.2.x already)
