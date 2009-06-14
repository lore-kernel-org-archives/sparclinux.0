From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 14 Jun 2009 12:40:51 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <4A34EFD3.7040108@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
> David Miller wrote:
>> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
>> Date: Thu, 11 Jun 2009 18:32:04 +0200
>>
>>> tchebytchev:[~/linux/sparc-2.6] > git bisect start v2.6.29 v2.6.28 --
>>> drivers/scsi/qla2xxx/
>>> Checking out files: 100% (10708/10708), done.
>>> Switched to branch "master"
>>> Bisecting: 19 revisions left to test after this
>>> [8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx: Always
>>> serialize mailbox command execution.
>>>
>>> -> kernel boots
>>>
>>> tchebytchev:[~/linux/sparc-2.6] > git bisect good
>>> Bisecting: 9 revisions left to test after this
>>> [618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove
>>> interrupt request bit check in the response processing path in multiq
>>> mode.
>>>
>>> -> kernel doesn't boot
>>>
>>> tchebytchev:[~/linux/sparc-2.6] > git bisect bad
>>> Bisecting: 4 revisions left to test after this
>>> [b872ca4081c480e3d76443282ffd7f206321f50f] [SCSI] qla2xxx: Correct
>>> descriptions in flash manipulation routines.
>>> tchebytchev:[~/linux/sparc-2.6] >
>>>
>>> tchebytchev:[~/linux/sparc-2.6] > git bisect log
>>> # bad: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
>>> # good: [4a6908a3a050aacc9c3a2f36b276b46c0629ad91] Linux 2.6.28
>>> git-bisect start 'v2.6.29' 'v2.6.28' '--' 'drivers/scsi/qla2xxx/'
>>> # good: [8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx:
>>> # Always serialize mailbox command execution.
>>> git-bisect good 8eca3f39c4b11320787f7b216f63214aee8415a9
>>> # bad: [618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove
>>> # interrupt request bit check in the response processing path in multiq
>>> # mode.
>>> git-bisect bad 618a752319503a64d1b66615e8ea2a0e7edaf914
>>> tchebytchev:[~/linux/sparc-2.6] >
>>>
>>>     I'm investigating...
>>
>> Keep going :-)
>>
>> You need to keep building and going "git bisect bad" or "git bisect
>> good" until it tells you the final guilty commit.
>>
>> I assume you understand this and are just giving a status report
>> mid-way in your task, but I wanted to be sure. :-)
>=20
>     David, I know. But I have no time to complete this work until this=20
> week-end (I cannot reboot workstation I use for tests).

	All bisection...

tchebytchev:[~/linux/sparc-2.6] > git bisect log
# bad: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
# good: [4a6908a3a050aacc9c3a2f36b276b46c0629ad91] Linux 2.6.28
git-bisect start 'v2.6.29' 'v2.6.28' '--' 'drivers/scsi/qla2xxx/'
# good: [8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx:=20
Always serialize mailbox command execution.
git-bisect good 8eca3f39c4b11320787f7b216f63214aee8415a9
# bad: [618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove=20
interrupt request bit check in the response processing path in multiq mode.
git-bisect bad 618a752319503a64d1b66615e8ea2a0e7edaf914
# good: [b872ca4081c480e3d76443282ffd7f206321f50f] [SCSI] qla2xxx:=20
Correct descriptions in flash manipulation routines.
git-bisect good b872ca4081c480e3d76443282ffd7f206321f50f
# good: [3c01b4f9fbb43fc911acd33ea7a14ea7a4f9866b] [SCSI] qla2xxx: Add=20
checks for a valid fcport in dev-loss-tmo/terminate_rport_io callbacks.
git-bisect good 3c01b4f9fbb43fc911acd33ea7a14ea7a4f9866b
# bad: [7f977ddd0eedfd5aac7865794f220f65aae8f361] [SCSI] qla2xxx: fix=20
Kernel Panic with Qlogic 2472 Card.
git-bisect bad 7f977ddd0eedfd5aac7865794f220f65aae8f361
# good: [f9932deb9900789ee0b5739c118f850d62e3b9b1] [SCSI] qla2xxx:=20
Update version number to 8.03.00-k2.
git-bisect good f9932deb9900789ee0b5739c118f850d62e3b9b1
tchebytchev:[~/linux/sparc-2.6] >

Git bisect view --stat returns :

commit 7f977ddd0eedfd5aac7865794f220f65aae8f361
Author: Shyam_Iyer@Dell.com <Shyam_Iyer@Dell.com>
Date:   Thu Feb 5 20:12:37 2009 +0530

     [SCSI] qla2xxx: fix Kernel Panic with Qlogic 2472 Card.

     Kernel Panic is observed with a Qlogic 2472 Card is plugged into the
     system and the qla2xxx driver is loaded:

     QLogic Fibre Channel HBA Driver: 8.02.01.02.11.0-k9
     vendor=8086 device410
     qla2xxx 0000:05:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
     qla2xxx 0000:05:00.0: Found an ISP2432, irq 40, iobase
     0xffffc2001091c000
     qla2xxx 0000:05:00.0: Configuring PCI space...
     qla2xxx 0000:05:00.0: setting latency timer to 64
     qla2xxx 0000:05:00.0: Configure NVRAM parameters...
     BUG: unable to handle kernel NULL pointer dereference at
     0000000000000000
     IP: [<ffffffff8036319a>] strncpy+0x5/0x1e
     PGD 7c564067 PUD 78d8c067 PMD 0
     Oops: 0000 [1] SMP
     last sysfs file:
=20
/sys/devices/pci0000:00/0000:00:1d.1/usb6/6-2/6-2:1.1/input/input4/event
     4/dev
     CPU 1
     Modules linked in: qla2xxx(+) squashfs usb_storage scsi_transport_fc
     scsi_tgt parport_pc parport arc4 ecb crypto_blkcipher acpi_cpufreq fan
     loop nfs nfs_acl lockd sunrpc nls_iso8859_1 nls_cp437 ipv6 af_packet st
     sr_mod ide_disk ide_cd_mod ide_core cdrom usbhid hid ff_memless sg
     sd_mod crc_t10dif uhci_hcd mptsas mptscsih ehci_hcd mptbase
     scsi_transport_sas rtc_cmos rtc_core rtc_lib usbcore scsi_mod thermal
     bnx2 button processor thermal_sys hwmon edd
     Supported: Yes
     Pid: 4415, comm: insmod Not tainted 2.6.27.13-1-default #1
     RIP: 0010:[<ffffffff8036319a>] [<ffffffff8036319a>] strncpy+0x5/0x1e
     RSP: 0018:ffff88007b04fbc0 EFLAGS: 00010202
     RAX: 00000000000000b7 RBX: ffff88007b9641e0 RCX: ffff88007c1b2ad7
     RDX: 000000000000004f RSI: 0000000000000000 RDI: ffff88007c1b2ad7
     RBP: ffff88007c1b0620 R08: 0000000000000010 R09: 0000000100000000
     R10: 0000000000000046 R11: ffffffff803651c6 R12: ffff88007b074000
     R13: ffff88007b964000 R14: ffff88007c1b2ac6 R15: 0000000000000000
     FS: 00007f91a6c366f0(0000) GS:ffff88007dbeee40(0000)
     knlGS:0000000000000000
     CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
     CR2: 0000000000000000 CR3: 000000007bd7c000 CR4: 00000000000006e0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
     Process insmod (pid: 4415, threadinfo ffff88007b04e000, task
:    ffff880078586180)
     Stack: ffffffffa02d82c4 0000000000002432 ffff88007d385000
     ffff88007c1b0620
     ffff88007c1b0620 ffff88007c1b0000 ffff88007d385000 0000000000002432
     ffffffffa02dcb1e 0000000000002432 ffffc2001091c000 ffff88007c1b0620
     Call Trace:
     [<ffffffffa02d82c4>] qla24xx_nvram_config+0x385/0x6c2 [qla2xxx]
     [<ffffffffa02dcb1e>] qla2x00_initialize_adapter+0x169/0x383 [qla2xxx]
     [<ffffffffa02f2040>] qla2x00_probe_one+0x6bc/0x9c6 [qla2xxx]
     [<ffffffff8037346f>] pci_device_probe+0xb8/0x105
     [<ffffffff803e5a27>] really_probe+0xdd/0x1e5
     [<ffffffff803e5c14>] __driver_attach+0x46/0x6d
     [<ffffffff803e51e1>] bus_for_each_dev+0x44/0x78
     [<ffffffff803e4ac7>] bus_add_driver+0xef/0x235
     [<ffffffff803e5dd8>] driver_register+0xa2/0x11f
     [<ffffffff803736fd>] __pci_register_driver+0x5d/0x90
     [<ffffffffa0308126>] qla2x00_module_init+0x126/0x159 [qla2xxx]
     [<ffffffff80209041>] _stext+0x41/0x110
     [<ffffffff80260abd>] sys_init_module+0xa0/0x1ba
     [<ffffffff8020bfbb>] system_call_fastpath+0x16/0x1b
     [<00007f91a679b76a>] 0x7f91a679b76a
     Code: ff c1 41 39 c0 75 05 45 85 c0 75 bf 41 29 c0 44 89 c0 c3 31 d2 8a
     04 16 88 04 17 48 ff c2 84 c0 75 f3 48 89 f8 c3 48 89 f9 eb 10 <8a> 06
     3c 01 88 01 48 83 de ff 48 ff c1 48 ff ca 48 85 d2 75 eb
     RIP [<ffffffff8036319a>] strncpy+0x5/0x1e
     RSP <ffff88007b04fbc0>
     CR2: 0000000000000000
     ---[ end trace 829d7d78dfafb785 ]---

     The attached patch fixes the issue.

     Signed-off-by: Shyam Iyer <shyam_iyer@dell.com>
     Acked-by: Seokmann Ju <Seokmann.ju@qlogic.com>
     Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

  drivers/scsi/qla2xxx/qla_devtbl.h |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

	Regards,

	JKB
