Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329183515E6
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649447; cv=none; b=ryKVpahQ2ylue6ZiDZzGp629ogV1D+7W1Zp6e/CrYc+quUPHjMQOGi8UyMk1lPUK9ryglLJz30S8dDCSZHqU7Nj+2VlOUqTmdiYvxLYRRK01XFOPoaOoZX6xYRWCyS8qjHxP6yVM1xfucbu4Sb2Rh62CJCiMyupaMzs2DYXjgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649447; c=relaxed/simple;
	bh=B0zoZwAa197Qiu6EPq6sTBOVsGhakJwSzicCfc15b7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQKwzdfaxBUniHIUKtZrJTGdC4r6InNGgctxuMrlLAk0OAqT4Orj7pjzlSbQ4DZs4LaH6eahPEk+RUOziSrluD9Kr9XESWWw5OMD+/Lm65ny5lF4/0bQTpfgoQA/u/M63kJGNnNgkTmkFcySn8gj/9V4Mc6/zhio1TYe3dBAU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Jo7m50pX; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Jo7m50pX"
Message-ID: <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791649442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0zoZwAa197Qiu6EPq6sTBOVsGhakJwSzicCfc15b7I=;
	b=Jo7m50pXzs5ooCReOwnfrbatSTol/VBkvKDDNPNwX73lN/JInl+lYoZ0emB0EL0tE3NHp4
	7dXGXCwzJF6OMqcBCqzg+oxEURHtSDj7b7p7bhvBM1MexuHgyoY7HApZEKhIDp+7iXXUZ+
	fIavsWF31ZNF82+h1hqBf3QQ2j9hUrQ=
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 18:24:00 +0200
In-Reply-To: <b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NY8ZjBS2IfGXBA8000M+"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-NY8ZjBS2IfGXBA8000M+
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


On Sat, 2026-10-10 at 12:45 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> I just booted Andreas' for-next branch on a V240 causing the mount
> command to crash with SIGILL. I think I've seen this before:
>=20
> [=A0=A0 42.327479] hid-generic 0003:413C:2106.0001: input,hidraw0: USB
> HID v1.10 Keyboard [Dell Dell QuietKey Keyboard] on usb-0001:00:0a.0-
> 1/input0
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-
> top ... done.
> Begin: Running /scripts/local-premount ... done.
> Begin: Will now check root file system ... fsck from util-linux
> 2.42.4
> [/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2=20
> /dev/sda2: clean, 2028114/8871936 files, 27597228/35467[=A0=A0 43.259718]
> ------------[ ftrace bug ]------------
> 312 blocks
> done[=A0=A0 43.334910] ftrace faulted on unknown error=20
> .
> [=A0=A0 43.334915] [<00000000102ee004>] 0x102ee004
> [=A0=A0 43.465739] Initializing ftrace call sites
> [=A0=A0 43.519487] ftrace record flags: 2000000
> [=A0=A0 43.570955]=A0 (0)=A0=A0=A0=20
> [=A0=A0 43.570955]=A0 expected tramp: f854d0
> [=A0=A0 43.645302] ------------[ cut here ]------------
> [=A0=A0 43.705920] WARNING: kernel/trace/ftrace.c:2278 at
> ftrace_bug+0x2f4/0x328, CPU#0: modprobe/131
> [=A0=A0 43.819259] Modules linked in: crc16 mbcache jbd2 hid_generic
> usbhid hid sr_mod sd_mod cdrom ata_generic ohci_pci ehci_pci ehci_hcd
> ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi usbcore tg3
> scsi_mod libphy scsi_common usb_common mdio_bus
> [=A0=A0 44.105327] CPU: 0 UID: 0 PID: 131 Comm: modprobe Not tainted
> 7.3.0-rc1+ #1 VOLUNTARY=20
> [=A0=A0 44.209473] Call Trace:
> [=A0=A0 44.241493] [<00000000004356ec>] dump_stack+0x8/0x18
> [=A0=A0 44.306688] [<0000000000477448>] __warn+0xe8/0x160
> [=A0=A0 44.369595] [<00000000004294d0>] warn_slowpath_fmt+0x34/0x74
> [=A0=A0 44.443937] [<000000000042b0dc>] ftrace_bug+0x2f4/0x328
> [=A0=A0 44.512563] [<0000000000578220>] ftrace_process_locs+0x420/0x620
> [=A0=A0 44.591482] [<000000000057c87c>] ftrace_module_init+0x3c/0x80
> [=A0=A0 44.666969] [<000000000051a544>] load_module+0x1bc4/0x23c0
> [=A0=A0 44.739026] [<000000000051af9c>] init_module_from_file+0x9c/0x120
> [=A0=A0 44.819089] [<000000000051b24c>] sys_finit_module+0x1cc/0x320
> [=A0=A0 44.894577] [<0000000000406194>] linux_sparc_syscall+0x34/0x44
> [=A0=A0 44.971222] ---[ end trace 0000000000000000 ]---
> [=A0=A0 45.073228]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \|/ ____ \|/
> [=A0=A0 45.073228]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "@'/ .. \`@"
> [=A0=A0 45.073228]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /_| \__/ |_\
> [=A0=A0 45.073228]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \__=
U_/
> [=A0=A0 45.266666] mount(130): Kernel illegal instruction [#1]
> [=A0=A0 45.335350] CPU: 0 UID: 0 PID: 130 Comm: mount Tainted: G=A0=A0=A0=
=A0=A0=A0=A0
> W=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7.3.0-rc1+ #1 VOLUNTARY=20
> [=A0=A0 45.456591] Tainted: [W]=3DWARN
> [=A0=A0 45.495469] TSTATE: 0000009911001606 TPC: 00000000102ee384 TNPC:
> 00000000102ee388 Y: 00000000=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> [=A0=A0 45.645312] TPC: <ext4_get_group_desc+0x4/0x100 [ext4]>
> [=A0=A0 45.714138] g0: 0000000000000001 g1: 000000000000043b g2:
> fff0000008d44000 g3: 00000000c2020000
> [=A0=A0 45.828514] g4: fff0000007bcd800 g5: 0000000000bc5c34 g6:
> fff0000007d60000 g7: 0000000000020000
> [=A0=A0 45.942891] o0: fff0000008d45800 o1: 0000000000000000 o2:
> 0000000000000009 o3: 0000000000001000
> [=A0=A0 46.057267] o4: fff0000008d45800 o5: fff0000008d44000 sp:
> fff0000007d67011 ret_pc: 00000000103615fc
> [=A0=A0 46.176223] RPC: <ext4_fill_super+0x1b9c/0x3000 [ext4]>
> [=A0=A0 46.244941] l0: 0000000000000000 l1: 0000000000000011 l2:
> fff0000008d443f8 l3: 0000000000000000
> [=A0=A0 46.359317] l4: fff0000008d44000 l5: 00000000103acc00 l6:
> fff0000008808400 l7: 0000000000000000
> [=A0=A0 46.473689] i0: fff0000008d44000 i1: fff00000001a8e40 i2:
> 0000000000000000 i3: fff0000008d45800
> [=A0=A0 46.588067] i4: 0000000000000001 i5: 0000000000020000 i6:
> fff0000007d67181 i7: 00000000007b8e6c
> [=A0=A0 46.702443] I7: <get_tree_bdev_flags+0x10c/0x1c0>
> [=A0=A0 46.764200] Call Trace:
> [=A0=A0 46.796220] [<00000000007b8e6c>] get_tree_bdev_flags+0x10c/0x1c0
> [=A0=A0 46.875144] [<00000000007b8f34>] get_tree_bdev+0x14/0x40
> [=A0=A0 46.944915] [<000000001034e254>] ext4_get_tree+0x14/0x40 [ext4]
> [=A0=A0 47.022794] [<00000000007b5840>] vfs_get_tree+0x20/0x120
> [=A0=A0 47.092568] [<00000000007e292c>] fc_mount+0xc/0xa0
> [=A0=A0 47.155468] [<00000000007e8c54>] path_mount+0x4b4/0xac0
> [=A0=A0 47.224089] [<00000000007e9814>] sys_mount+0xf4/0x1a0
> [=A0=A0 47.290430] [<0000000000406194>] linux_sparc_syscall+0x34/0x44
> [=A0=A0 47.367059] Disabling lock debugging due to kernel taint
> [=A0=A0 47.436829] Caller[00000000007b8e6c]:
> get_tree_bdev_flags+0x10c/0x1c0
> [=A0=A0 47.521465] Caller[00000000007b8f34]: get_tree_bdev+0x14/0x40
> [=A0=A0 47.596955] Caller[000000001034e254]: ext4_get_tree+0x14/0x40
> [ext4]
> [=A0=A0 47.680552] Caller[00000000007b5840]: vfs_get_tree+0x20/0x120
> [=A0=A0 47.756040] Caller[00000000007e292c]: fc_mount+0xc/0xa0
> [=A0=A0 47.824662] Caller[00000000007e8c54]: path_mount+0x4b4/0xac0
> [=A0=A0 47.899010] Caller[00000000007e9814]: sys_mount+0xf4/0x1a0
> [=A0=A0 47.971063] Caller[0000000000406194]:
> linux_sparc_syscall+0x34/0x44
> [=A0=A0 48.053415] Caller[000001000008fea8]: 0x1000008fea8
> [=A0=A0 48.117461] Instruction DUMP:
> [=A0=A0 48.117465]=A0 c4286105=20
> [=A0=A0 48.156348]=A0 96102000=20
> [=A0=A0 48.187229]=A0 94102009=20
> [=A0=A0 48.218112] <bc325c4f>
> [=A0=A0 48.248992]=A0 7c02dc45=20
> [=A0=A0 48.279874]=A0 901221d8=20
> [=A0=A0 48.310764]=A0 106fffaa=20
> [=A0=A0 48.341636]=A0 ba103fea=20
> [=A0=A0 48.372517]=A0 03040e21=20
> [=A0=A0 48.403398]=20
> Killed
> Failed to mount /dev/sda2 as root file system.
>=20
>=20
> BusyBox v1.38.0 (Debian 1:1.38.0-3) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
>=20
> (initramfs)=20
>=20
> Anyone have any clue?
>=20

Tested for-next on Sun Fire V240, no issues here.

Haven't reproduced, so starting the guessing game.

My first bet is on a config diff, so will try Debian's config and see
if I can reproduce. I'm running a pretty lean Gentoo kernel config.

You're not running any out of tree patches in your current build?

Is this a problem only in Andreas' for-next branch, or does it also
crash with 7.3-rc6?

Any relation to https://github.com/sparclinux/issues/issues/29, does
this patch on top of for-next fix it? I never hit #29 in the first
place so not hitting it now doesn't prove anything.

Will report back if I reproduce and find something more concrete.

/Stian

--=-NY8ZjBS2IfGXBA8000M+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaspmoAAKCRDoeAEuJe36
VlvVAP93D95HhaL40v50RXNo0759MFWFNilHpENxQkPlhUMydwEA0BiWAlyir0Iv
sXPb8UI0/VdYMSyFqb8aQ92d/eupmAI=
=IkMK
-----END PGP SIGNATURE-----

--=-NY8ZjBS2IfGXBA8000M+--
