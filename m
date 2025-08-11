Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9423B63F;
	Mon, 11 Aug 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909091; cv=none; b=nS8jJ1bbyw/8oCU26ag8h6OGNp1FEC1h1fVB/vcgIEx1LMLdmfiJzLlKptEWpEmy/t9y+TtBFcRzyixSG5ofT6R5uxTaxiLcRxFeWVQ7darYR3Dx4OGqCAtzOuMNAL9rU6rn62dTrUG5OpIlalHPSZqfdjFo0UKxj1cawHoMelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909091; c=relaxed/simple;
	bh=zD0IxrZXNI1tU7rJGVCmpIMkixcKHruwzlK8uvNAeqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=on2IxZ2r79nMvb+wa/rhTx5+HATBIHUGNf5Ei96MIyaMeKxNlB2NQ3WsO8757pveSCRbkbKvQYvd7O9QcLDqG/41wovAKfPO1YM3/4c9Tkh3eGG15T5zY6GITX56TmPTBLt81IZBlN3Y/Hddqoqi8mk5fSjGGCLPIkapvU8OM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=d8Dsk+ea; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="d8Dsk+ea"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=N2N/UD6+hI9V7NBGBn1EdvHUGHfwmrlh77J4G2dejaA=; t=1754909087;
	x=1755513887; b=d8Dsk+eanREIzUvtHomVi1sMWxrDViON6nkm/LghUzH+pe8oGW+TzcRTsOO6z
	5iGCFpZT5+Bw0hhz9g2IOkMHKxA+UVf3rD+ZL1+ebNnqQ0Dw/YEnBsWp13TUenn7WSryS+DYBJQCM
	0FEM3iiI2RCdK1k6hu7SYlN9rS1zdxASrwGbJutfgSBqNA4kDJ4WLHKOwJlI/jPh9wXWDCTTSBn1T
	zPjvuguSuCez4DjFMbaku8D39yuughNKsoJCdRn/n5+WSRYHpV9TIlILuE2vkX5mVImTxn0Pff0+4
	MLUS9Bp5C3xneO36ci5A3ry+4S6PuFBq2jjPR6p9Riizl06UfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ulQ18-000000029di-13CY; Mon, 11 Aug 2025 12:44:38 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ulQ17-00000002WoO-46n9; Mon, 11 Aug 2025 12:44:38 +0200
Message-ID: <2daaa0648e9bcca42bf7a76d90580725f44fb4bc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de, Meelis Roos
	 <mroos@linux.ee>
Date: Mon, 11 Aug 2025 12:44:36 +0200
In-Reply-To: <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
							 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
							 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
						 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
					 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
				 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
			 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
		 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
	 <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2025-08-11 at 00:20 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> On Sun, 2025-08-10 at 11:52 +0200, John Paul Adrian Glaubitz wrote:
> > On Sat, 2025-08-09 at 08:42 +0200, John Paul Adrian Glaubitz wrote:
> > > Let me know if you have more suggestions to test. I can also provide =
you with full
> > > access to this Netra 240 if you send me your public SSH key in a priv=
ate mail.
> >=20
> > I have narrowed it down to a regression between v6.3 and v6.4 now.
> >=20
> > The bug can be reproduced with the sparc64_defconfig on a Sun Netra 240=
 by setting
> > CONFIG_TRANSPARENT_HUGEPAGE=3Dy and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=
=3Dy. When testing
> > on a modern systemd-based distribution, it's also necessary to enable C=
Group support
> > as well as enable support for Sun partition tables with CONFIG_SUN_PART=
ITION=3Dy.
> >=20
> > Then it should be a matter of bisecting the commits between v6.3 and v6=
.4.
> >=20
> > I will do that within the next days as I'm currently a bit busy with ot=
her stuff.
>=20
> OK, it turns out it's reproducible on older kernels (but not as old as 4.=
19) as well.
> It's just much harder to trigger. I found a reproducer though and will tr=
y to find
> the problematic commit next.
>=20
> [50686.808389] BUG: Bad page map in process sshd-session  pte:00000002 pm=
d:01448000
> [50686.905701] addr:00000100000a0000 vm_flags:00000075 anon_vma:000000000=
0000000 mapping:fff000003c8ca4f8 index:50
> [50687.038425] file:sshd-session fault:filemap_fault mmap:ext4_file_mmap =
[ext4] read_folio:ext4_read_folio [ext4]
> [50687.170246] CPU: 0 PID: 37883 Comm: sshd-session Not tainted 6.3.0-2-s=
parc64 #1  Debian 6.3.11-1
> [50687.285751] Call Trace:
> [50687.317771] [<0000000000d660b0>] dump_stack+0x8/0x18
> [50687.382976] [<000000000064fd1c>] print_bad_pte+0x15c/0x200
> [50687.455024] [<0000000000650f84>] unmap_page_range+0x3e4/0xbe0
> [50687.530513] [<0000000000651cd8>] unmap_vmas+0xf8/0x1a0
> [50687.597993] [<000000000065e674>] exit_mmap+0xb4/0x360
> [50687.664331] [<00000000004647dc>] __mmput+0x3c/0x120
> [50687.728380] [<00000000004648f4>] mmput+0x34/0x60
> [50687.788999] [<000000000046b510>] do_exit+0x250/0xa00
> [50687.854194] [<000000000046bea4>] do_group_exit+0x24/0xa0
> [50687.923962] [<000000000046bf3c>] sys_exit_group+0x1c/0x40
> [50687.994875] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> [50688.071518] Disabling lock debugging due to kernel taint
> [50689.484196] Unable to handle kernel paging request at virtual address =
000c000002400000
> [50689.588368] tsk->{mm,active_mm}->context =3D 00000000001815a6
> [50689.661677] tsk->{mm,active_mm}->pgd =3D fff000000ae60000
> [50689.730374]               \|/ ____ \|/
>                              "@'/ .. \`@"
>                              /_| \__/ |_\
>                                 \__U_/
> [50689.923679] sshd-session(37883): Oops [#1]
> [50689.977420] CPU: 0 PID: 37883 Comm: sshd-session Tainted: G    B      =
        6.3.0-2-sparc64 #1  Debian 6.3.11-1
> [50690.112384] TSTATE: 0000008811001607 TPC: 00000000006510cc TNPC: 00000=
000006510d0 Y: 00000000    Tainted: G    B            =20
> [50690.261089] TPC: <unmap_page_range+0x52c/0xbe0>
> [50690.320650] g0: 00000000000004a8 g1: 000c000000000000 g2: 000000000000=
8800 g3: ffffffffffffffff
> [50690.435029] g4: fff0000001ef1280 g5: 0000000031200000 g6: fff0000001f0=
4000 g7: ffffffffffffffff
> [50690.549403] o0: 000c000002400a20 o1: 00000100000a4000 o2: 000000010004=
8290 o3: 0000000000000000
> [50690.663779] o4: 0000000000000001 o5: 000000000000000d sp: fff0000001f0=
6f61 ret_pc: 0000010000000000
> [50690.782728] RPC: <0x10000000000>
> [50690.825039] l0: 0000000100048290 l1: 000c000002400a20 l2: 00000100000a=
6000 l3: fff0000000950000
> [50690.939419] l4: 00000100000fc000 l5: fff000000196dc20 l6: fff0000001f0=
7938 l7: 00000000010f6fd0
> [50691.053798] i0: fff0000001f07aa8 i1: 0000000000002000 i2: 00000100000a=
4000 i3: fff0000008311b00
> [50691.168170] i4: 0000000000100000 i5: fff0000001448290 i6: fff0000001f0=
7081 i7: 0000000000651cd8
> [50691.282546] I7: <unmap_vmas+0xf8/0x1a0>
> [50691.332867] Call Trace:
> [50691.364891] [<0000000000651cd8>] unmap_vmas+0xf8/0x1a0
> [50691.432371] [<000000000065e674>] exit_mmap+0xb4/0x360
> [50691.498708] [<00000000004647dc>] __mmput+0x3c/0x120
> [50691.562759] [<00000000004648f4>] mmput+0x34/0x60
> [50691.623376] [<000000000046b510>] do_exit+0x250/0xa00
> [50691.688573] [<000000000046bea4>] do_group_exit+0x24/0xa0
> [50691.758340] [<000000000046bf3c>] sys_exit_group+0x1c/0x40
> [50691.829256] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> [50691.905886] Caller[0000000000651cd8]: unmap_vmas+0xf8/0x1a0
> [50691.979085] Caller[000000000065e674]: exit_mmap+0xb4/0x360
> [50692.051141] Caller[00000000004647dc]: __mmput+0x3c/0x120
> [50692.120911] Caller[00000000004648f4]: mmput+0x34/0x60
> [50692.187246] Caller[000000000046b510]: do_exit+0x250/0xa00
> [50692.258160] Caller[000000000046bea4]: do_group_exit+0x24/0xa0
> [50692.333645] Caller[000000000046bf3c]: sys_exit_group+0x1c/0x40
> [50692.410280] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
> [50692.492629] Caller[fff0000102ad4a74]: 0xfff0000102ad4a74
> [50692.562397] Instruction DUMP:
> [50692.562399]  ce762010=20
> [50692.601281]  02f47fa8=20
> [50692.632163]  c4362018=20
> [50692.663044] <c45c6008>
> [50692.693926]  86100011=20
> [50692.724808]  8e08a001=20
> [50692.755689]  8400bfff=20
> [50692.786569]  8779d402=20
> [50692.817451]  c458e018=20
>=20
> [50692.898656] Fixing recursive fault but reboot is needed!

So, I was able now to even reproduce it in kernel versions as early as 5.2:

[  122.085803] Unable to handle kernel NULL pointer dereference
[  122.160227] tsk->{mm,active_mm}->context =3D 000000000000009d
[  122.233502] tsk->{mm,active_mm}->pgd =3D fff0000231d14000
[  122.302118]               \|/ ____ \|/
[  122.302118]               "@'/ .. \`@"
[  122.302118]               /_| \__/ |_\
[  122.302118]                  \__U_/
[  122.495420] systemd(1): Oops [#1]
[  122.538874] CPU: 0 PID: 1 Comm: systemd Not tainted 5.2.0-3-sparc64 #1 D=
ebian 5.2.17-1
[  122.642957] TSTATE: 0000004411001601 TPC: 000000000061cd94 TNPC: 0000000=
00061cd98 Y: 00000000    Not tainted
[  122.772207] TPC: <vfs_getattr_nosec+0x34/0xc0>
[  122.830529] g0: 0000000000000000 g1: 00000000000007ff g2: 00000000000000=
00 g3: 00000000000007df
[  122.944902] g4: fff00002381771c0 g5: 0000000000000003 g6: fff00002381780=
00 g7: 0000000000000000
[  123.059275] o0: fff000023817be18 o1: 0000000000000000 o2: 00000000000000=
00 o3: fff000023817be18
[  123.173658] o4: 0000000000000000 o5: 0000000000000000 sp: fff000023817b3=
41 ret_pc: 000000000061cd7c
[  123.292611] RPC: <vfs_getattr_nosec+0x1c/0xc0>
[  123.350933] l0: 0000010000204010 l1: fff0000101600e28 l2: e4e45b5b8ae446=
28 l3: 0000000000000000
[  123.465311] l4: 0000000000000000 l5: 0000000000000000 l6: 00000000000000=
00 l7: fff0000100bff140
[  123.579692] i0: fff000023817bd50 i1: fff000023817be18 i2: 00000000000000=
01 i3: 0000000000000900
[  123.694060] i4: 0000000000000000 i5: fff00002320c1210 i6: fff000023817b3=
f1 i7: 000000000061ce48
[  123.808439] I7: <vfs_getattr+0x28/0x40>
[  123.858759] Call Trace:
[  123.890785]  [000000000061ce48] vfs_getattr+0x28/0x40
[  123.957123]  [000000000061cf64] vfs_statx+0x84/0xc0
[  124.021173]  [000000000061d918] sys_statx+0x38/0x60
[  124.085226]  [0000000000406154] linux_sparc_syscall+0x34/0x44
[  124.160708] Disabling lock debugging due to kernel taint
[  124.230481] Caller[000000000061ce48]: vfs_getattr+0x28/0x40
[  124.303680] Caller[000000000061cf64]: vfs_statx+0x84/0xc0
[  124.374593] Caller[000000000061d918]: sys_statx+0x38/0x60
[  124.445503] Caller[0000000000406154]: linux_sparc_syscall+0x34/0x44
[  124.527857] Caller[fff00001013fde40]: 0xfff00001013fde40
[  124.597621] Instruction DUMP:
[  124.597623]  c2264000=20
[  124.636505]  861027df=20
[  124.667386]  c45f6028=20
[  124.698267] <c458a050>
[  124.729148]  8408a401=20
[  124.760031]  83789403=20
[  124.790910]  c2264000=20
[  124.821801]  c207600c=20
[  124.852675]  80886800=20
[  124.883556]=20
[  124.954015] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[  125.054721] Press Stop-A (L1-A) from sun keyboard or send break
[  125.054721] twice on console to return to the boot prom
[  125.201103] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

On v5.6, I'm getting an interesting error mentioning D-cache parity errors:

[  125.743109] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000056bac=
c]
[  125.833511] TPC<bpf_check+0x18ec/0x3060>
[  127.909612] systemd-sysv-generator[1677]: SysV service '/etc/init.d/buil=
dd' lacks a native systemd unit file, automatically generating a unit file =
for compatibility.
[  128.104239] systemd-sysv-generator[1677]: Please update package to inclu=
de a native systemd unit file.
[  128.227312] systemd-sysv-generator[1677]: =E2=9A=A0 This compatibility l=
ogic is deprecated, expect removal soon. =E2=9A=A0
[  129.638144] Unable to handle kernel NULL pointer dereference
[  129.712528] tsk->{mm,active_mm}->context =3D 000000000000009e
[  129.785808] tsk->{mm,active_mm}->pgd =3D fff0000233d38000
[  129.854522]               \|/ ____ \|/
[  129.854522]               "@'/ .. \`@"
[  129.854522]               /_| \__/ |_\
[  129.854522]                  \__U_/
[  130.047827] systemd(1): Oops [#1]
[  130.091278] CPU: 0 PID: 1 Comm: systemd Tainted: G            E     5.6.=
0-2-sparc64 #1 Debian 5.6.14-2
[  130.213664] TSTATE: 0000009911001604 TPC: 00000000005506d8 TNPC: 0000000=
0005506dc Y: 00000000    Tainted: G            E   =20
[  130.361222] TPC: <bpf_prog_realloc+0x38/0xe0>
[  130.418486] g0: 0000000002000000 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000000000002
[  130.532867] g4: fff000023c178000 g5: 0000000000657300 g6: fff000023c1800=
00 g7: fff000023423e684
[  130.647245] o0: ffffffff00002000 o1: 0000000000000001 o2: fff0000234168f=
a0 o3: 0000000000000000
[  130.761617] o4: fff0000237761f80 o5: 0000000000000001 sp: fff000023c182f=
d1 ret_pc: 00000000005f2c84
[  130.880576] RPC: <__vfree+0x24/0x80>
[  130.927456] l0: ffffffffffffffff l1: 0000000000000001 l2: 00000000000004=
00 l3: 0000000002000000
[  131.041836] l4: 0000000000debc00 l5: 0000000000000100 l6: 00000000000000=
01 l7: fff000023c005e40
[  131.156213] i0: 000000010004e000 i1: 0000000000002000 i2: 0000000000100c=
c0 i3: fff0000237761300
[  131.270589] i4: 0000000000000001 i5: 0000000000000001 i6: fff000023c1830=
81 i7: 0000000000550a70
[  131.384963] I7: <bpf_patch_insn_single+0x70/0x1e0>
[  131.447862] Call Trace:
[  131.479889]  [0000000000550a70] bpf_patch_insn_single+0x70/0x1e0
[  131.558814]  [000000000055fe58] bpf_patch_insn_data+0x18/0x1c0
[  131.635442]  [000000000056bed8] bpf_check+0x1cf8/0x3060
[  131.704064]  [0000000000559778] bpf_prog_load+0x498/0x8e0
[  131.774975]  [0000000000559d10] __do_sys_bpf+0x150/0x1880
[  131.845890]  [000000000055b534] sys_bpf+0x14/0x560
[  131.908807]  [0000000000406154] linux_sparc_syscall+0x34/0x44
[  131.984281] Disabling lock debugging due to kernel taint
[  132.054051] Caller[0000000000550a70]: bpf_patch_insn_single+0x70/0x1e0
[  132.139832] Caller[000000000055fe58]: bpf_patch_insn_data+0x18/0x1c0
[  132.223325] Caller[000000000056bed8]: bpf_check+0x1cf8/0x3060
[  132.298811] Caller[0000000000559778]: bpf_prog_load+0x498/0x8e0
[  132.376588] Caller[0000000000559d10]: __do_sys_bpf+0x150/0x1880
[  132.454361] Caller[000000000055b534]: sys_bpf+0x14/0x560
[  132.524132] Caller[0000000000406154]: linux_sparc_syscall+0x34/0x44
[  132.606483] Caller[fff0000100995b38]: 0xfff0000100995b38
[  132.676247] Instruction DUMP:
[  132.676249]  c25e2020=20
[  132.715134]  92270009=20
[  132.746014]  bb326000=20
[  132.776895] <d05860e0>
[  132.807776]  400021a1=20
[  132.838657]  9210001d=20
[  132.869540]  80a22000=20
[  132.900422]  12400016=20
[  132.931303]  03003480=20
[  132.962184]=20
[  133.020246] systemd-journald[205]: Time jumped backwards, rotating. (Dro=
pped 1 similar message(s))
[  133.138938] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[  133.239608] Press Stop-A (L1-A) from sun keyboard or send break
[  133.239608] twice on console to return to the boot prom
[  133.385997] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

Searching for that error in the archives, yielded this report from 2018 [1]=
 which seems to have never
been addressed by David Miller.

@Anthony: Can you see any suspicious in the disassembled code that Meelis (=
CC'ed) posted?

Adrian

> [1] https://lore.kernel.org/all/a4391645-0c4f-bd99-7371-b0e2cb505542@linu=
x.ee/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
