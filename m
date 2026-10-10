Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFC29A309
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629153; cv=none; b=lrIg70+GipYiN7KSmxddNbQ3EEl5HvsRTm3DNKw0hbkrUVy0OYkofCfWYDUnl4n+ePyMxt/1LpAop6Ci9KyIsK3X3CcsuVDKZ4oqPmdAiLwkGDaFtFVv+G0OUnifw6gEE9nv+uWIecrjeCyfrCXFFHFHne6n5KJQefU8l9+v1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629153; c=relaxed/simple;
	bh=3vhvgxjhWM+Bze7kTPCaMoL7xQwWAsL9LYVUSMFjDVE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=sOcq/okKeOuX09q2FKbi0pEff5uWX3OwE5xrZWA+JM3KRrxpumCX7OjCMS7LeP+AhbK2FWI3av2rh+1Kx7SR5yCA9ImfD5Es1jqnzCUVEWBzSfF2UMIFAv1Ul6EVY+ICxDi5mQUfTJ0ZAX1Kc9bKwQlHZn1Lk5EZ5W9iUv/wbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JvUS7k5d; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JvUS7k5d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QT96TfhStGWOowNMO2hgwp3GhD5ue2ItCfoDDie4vhM=; t=1791629150; x=1792233950; 
	b=JvUS7k5d62vUtbULxxDlBge5F1bpUeAj2ebj3D4iws4GcYk6bt9Z8YZ6wBigLOcLkqRK+ZQEUPF
	WJUUv4/gqsFpUrByLnUnuh+fvJWTnDiApl3YNuO5moe5uQ1qgR8dyLF3bS0IU9l7vrs2QhzrLcgdL
	dhn3wSoWuYsl8DIZblIcrurXeQJJWho1eePC9Ba0HqwVCjZ7VqPQdAPdzY7g7QsEwnuuAwzxSId2P
	QUxLrKDkh+TIRoVKavfYK4hxvTAsC4ityx+Px1J2f0h5SAbF7by5OcQtIewpT+iG5el+nKio9DG+h
	BX5EBI+/EPnMF6GxcfBzXABRyS/NWt8cd8jA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xFUaK-00000003ag0-0O8V; Sat, 10 Oct 2026 12:45:48 +0200
Received: from dynamic-077-183-246-238.77.183.pool.telefonica.de ([77.183.246.238] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xFUaJ-00000002ipF-3de7; Sat, 10 Oct 2026 12:45:48 +0200
Message-ID: <b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
Subject: Mount crashes with SIGILL on v240 on for-next
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: Stian Halseth <stian@itx.no>, Imre Kaloz <kaloz@kernel.org>, Andreas
 Larsson <andreas@gaisler.com>, Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 12:45:47 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

I just booted Andreas' for-next branch on a V240 causing the mount
command to crash with SIGILL. I think I've seen this before:

[   42.327479] hid-generic 0003:413C:2106.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [Dell Dell QuietKey Keyboard] on usb-0001:00:0a.0-1/input0
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... done.
Begin: Will now check root file system ... fsck from util-linux 2.42.4
[/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2=20
/dev/sda2: clean, 2028114/8871936 files, 27597228/35467[   43.259718] -----=
-------[ ftrace bug ]------------
312 blocks
done[   43.334910] ftrace faulted on unknown error=20
.
[   43.334915] [<00000000102ee004>] 0x102ee004
[   43.465739] Initializing ftrace call sites
[   43.519487] ftrace record flags: 2000000
[   43.570955]  (0)   =20
[   43.570955]  expected tramp: f854d0
[   43.645302] ------------[ cut here ]------------
[   43.705920] WARNING: kernel/trace/ftrace.c:2278 at ftrace_bug+0x2f4/0x32=
8, CPU#0: modprobe/131
[   43.819259] Modules linked in: crc16 mbcache jbd2 hid_generic usbhid hid=
 sr_mod sd_mod cdrom ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_a=
li libata sym53c8xx scsi_transport_spi usbcore tg3
scsi_mod libphy scsi_common usb_common mdio_bus
[   44.105327] CPU: 0 UID: 0 PID: 131 Comm: modprobe Not tainted 7.3.0-rc1+=
 #1 VOLUNTARY=20
[   44.209473] Call Trace:
[   44.241493] [<00000000004356ec>] dump_stack+0x8/0x18
[   44.306688] [<0000000000477448>] __warn+0xe8/0x160
[   44.369595] [<00000000004294d0>] warn_slowpath_fmt+0x34/0x74
[   44.443937] [<000000000042b0dc>] ftrace_bug+0x2f4/0x328
[   44.512563] [<0000000000578220>] ftrace_process_locs+0x420/0x620
[   44.591482] [<000000000057c87c>] ftrace_module_init+0x3c/0x80
[   44.666969] [<000000000051a544>] load_module+0x1bc4/0x23c0
[   44.739026] [<000000000051af9c>] init_module_from_file+0x9c/0x120
[   44.819089] [<000000000051b24c>] sys_finit_module+0x1cc/0x320
[   44.894577] [<0000000000406194>] linux_sparc_syscall+0x34/0x44
[   44.971222] ---[ end trace 0000000000000000 ]---
[   45.073228]               \|/ ____ \|/
[   45.073228]               "@'/ .. \`@"
[   45.073228]               /_| \__/ |_\
[   45.073228]                  \__U_/
[   45.266666] mount(130): Kernel illegal instruction [#1]
[   45.335350] CPU: 0 UID: 0 PID: 130 Comm: mount Tainted: G        W      =
     7.3.0-rc1+ #1 VOLUNTARY=20
[   45.456591] Tainted: [W]=3DWARN
[   45.495469] TSTATE: 0000009911001606 TPC: 00000000102ee384 TNPC: 0000000=
0102ee388 Y: 00000000    Tainted: G        W         =20
[   45.645312] TPC: <ext4_get_group_desc+0x4/0x100 [ext4]>
[   45.714138] g0: 0000000000000001 g1: 000000000000043b g2: fff0000008d440=
00 g3: 00000000c2020000
[   45.828514] g4: fff0000007bcd800 g5: 0000000000bc5c34 g6: fff0000007d600=
00 g7: 0000000000020000
[   45.942891] o0: fff0000008d45800 o1: 0000000000000000 o2: 00000000000000=
09 o3: 0000000000001000
[   46.057267] o4: fff0000008d45800 o5: fff0000008d44000 sp: fff0000007d670=
11 ret_pc: 00000000103615fc
[   46.176223] RPC: <ext4_fill_super+0x1b9c/0x3000 [ext4]>
[   46.244941] l0: 0000000000000000 l1: 0000000000000011 l2: fff0000008d443=
f8 l3: 0000000000000000
[   46.359317] l4: fff0000008d44000 l5: 00000000103acc00 l6: fff00000088084=
00 l7: 0000000000000000
[   46.473689] i0: fff0000008d44000 i1: fff00000001a8e40 i2: 00000000000000=
00 i3: fff0000008d45800
[   46.588067] i4: 0000000000000001 i5: 0000000000020000 i6: fff0000007d671=
81 i7: 00000000007b8e6c
[   46.702443] I7: <get_tree_bdev_flags+0x10c/0x1c0>
[   46.764200] Call Trace:
[   46.796220] [<00000000007b8e6c>] get_tree_bdev_flags+0x10c/0x1c0
[   46.875144] [<00000000007b8f34>] get_tree_bdev+0x14/0x40
[   46.944915] [<000000001034e254>] ext4_get_tree+0x14/0x40 [ext4]
[   47.022794] [<00000000007b5840>] vfs_get_tree+0x20/0x120
[   47.092568] [<00000000007e292c>] fc_mount+0xc/0xa0
[   47.155468] [<00000000007e8c54>] path_mount+0x4b4/0xac0
[   47.224089] [<00000000007e9814>] sys_mount+0xf4/0x1a0
[   47.290430] [<0000000000406194>] linux_sparc_syscall+0x34/0x44
[   47.367059] Disabling lock debugging due to kernel taint
[   47.436829] Caller[00000000007b8e6c]: get_tree_bdev_flags+0x10c/0x1c0
[   47.521465] Caller[00000000007b8f34]: get_tree_bdev+0x14/0x40
[   47.596955] Caller[000000001034e254]: ext4_get_tree+0x14/0x40 [ext4]
[   47.680552] Caller[00000000007b5840]: vfs_get_tree+0x20/0x120
[   47.756040] Caller[00000000007e292c]: fc_mount+0xc/0xa0
[   47.824662] Caller[00000000007e8c54]: path_mount+0x4b4/0xac0
[   47.899010] Caller[00000000007e9814]: sys_mount+0xf4/0x1a0
[   47.971063] Caller[0000000000406194]: linux_sparc_syscall+0x34/0x44
[   48.053415] Caller[000001000008fea8]: 0x1000008fea8
[   48.117461] Instruction DUMP:
[   48.117465]  c4286105=20
[   48.156348]  96102000=20
[   48.187229]  94102009=20
[   48.218112] <bc325c4f>
[   48.248992]  7c02dc45=20
[   48.279874]  901221d8=20
[   48.310764]  106fffaa=20
[   48.341636]  ba103fea=20
[   48.372517]  03040e21=20
[   48.403398]=20
Killed
Failed to mount /dev/sda2 as root file system.


BusyBox v1.38.0 (Debian 1:1.38.0-3) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs)=20

Anyone have any clue?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
