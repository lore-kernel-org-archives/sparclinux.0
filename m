From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 11 Jun 2009 16:32:04 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <4A313184.6000602@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 29 May 2009 11:58:54 +0200
>=20
>> BERTRAND Jo=EBl a =E9crit :
>>>     Hello,
>>>     I have made some minor modifications in bbc_i2c driver to add en en=
try
>>>     in /proc directory. ALl mofications have been made against 2.6.29.4
>>>     but I haven't verified that this kernel was bootable.
>>>     I have built my own bbc_i2c driver as a module. 2.6.29.4 kernel han=
gs
>>>     just after qla2xxx initialization. I don't think that this driver t=
ry
>>>     to upload firmware. This firmware is built into the kernel.
>>> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>>> # CONFIG_STANDALONE is not set
>>> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>>> CONFIG_FW_LOADER=3Dy
>>> CONFIG_FIRMWARE_IN_KERNEL=3Dy
>>> CONFIG_EXTRA_FIRMWARE=3D"ql2200_fw.bin"
>>> CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
>>> Root rayleigh:[/lib/firmware] > ls
>>> edgeport emi62 keyspan_pda ql2100_fw.bin ql2300_fw.bin ql2400_fw.bin
>>> emi26     ess    korg         ql2200_fw.bin  ql2322_fw.bin  yamaha
>>> Root rayleigh:[/lib/firmware] >
>>> Configuration:
>>> Blade 2000, 2 GB, 2*UIII+/900, Creator3D, internal NIC + 2*3Com NIC.
>>>     Is it a known trouble ?
>> 	Nobody ? I have tried 2.6.29.1 with exactly the same bug. 2.6.28.7
>> 	worked fine.
>=20
> I just did a scan over the driver changes for qla2xxx from 2.6.28
> and 2.6.29 and they were very extensive and complicated.
>=20
> What we need to do to narrow this down is do a GIT bisect.  I hope
> that you have a GIT tree handy and can do this?
>=20
> Luckily it's pretty easy to only bisect through the qla2xxx changes.
>=20
> Once you have a tree checked out, start like this:
>=20
> bash$ git bisect start v2.6.29 v2.6.28 -- drivers/scsi/qla2xxx/
>=20
> Configure and build that kernel, see if it shows the bug.
>=20
> If the bug is there go into the GIT tree and say:
>=20
> bash$ git bisect bad
>=20
> else if the bug is not there say:
>=20
> bash$ git bisect good
>=20
> Rebuild and retest.  Repeat this process of testing and then
> running "git bisect good" or "git bisect bad" until the guilty
> changeset is found.  At most you'll need to do this 6 times.
>=20
> Post the result here.

tchebytchev:[~/linux/sparc-2.6] > git bisect start v2.6.29 v2.6.28 --=20
drivers/scsi/qla2xxx/
Checking out files: 100% (10708/10708), done.
Switched to branch "master"
Bisecting: 19 revisions left to test after this
[8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx: Always=20
serialize mailbox command execution.

-> kernel boots

tchebytchev:[~/linux/sparc-2.6] > git bisect good
Bisecting: 9 revisions left to test after this
[618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove=20
interrupt request bit check in the response processing path in multiq mode.

-> kernel doesn't boot

tchebytchev:[~/linux/sparc-2.6] > git bisect bad
Bisecting: 4 revisions left to test after this
[b872ca4081c480e3d76443282ffd7f206321f50f] [SCSI] qla2xxx: Correct=20
descriptions in flash manipulation routines.
tchebytchev:[~/linux/sparc-2.6] >

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
tchebytchev:[~/linux/sparc-2.6] >

	I'm investigating...

	Regards,

	JKB
