Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B507E552;
	Sun,  7 Sep 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270001; cv=none; b=S38ShZ7Oad31KZVwwNSaBQ8ai9bmUTSNMztrPNG3uQOcmtyaJzUoDit8t9dSOV6iQL4VLxb5biuYTiC57SZl5WD5wH5FhW7DTr3oQ7VhOIXrHn8WtG7j0MBXTijE66XLVhI37dVo9+mcU4+7RNeQopcOlMVf+tTlzROBhM/q9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270001; c=relaxed/simple;
	bh=9tIlTI9O3Xa+d2w3d78TmCY1t3qK1h+cAjq4ybsegiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKB6twavSH2kGbzDwcqSpLHj0R7D/52SJMVwG6P4mk6kpEPnoQEPPgoO1YaJTRiC05hQkMe8YeCnJ1QN5OuZ0OEdKyS6yeN97soMa6dQ6R6Ib7WKCHPG4K3YjcPqm7fnVWL1GxdGQeoUENSK58iu9HQzrKQM84l6xXPpwl9p72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=npgghXvs; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="npgghXvs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vEU9EY89jo3fuUey+xc3EWIQOSTL4s9w9zivHP+tZ8A=; t=1757269998;
	x=1757874798; b=npgghXvs8AZhO9iBEz/QgZXO94jcLscLKGJJeebu/341e9lDvcPMMB7bP6nB3
	fvxq/LrvZ1MgM+mLWO7yaUZ2RLbdngc+3lLHicHh2pJjjsdDf7OPN9Wl7EK/dW2T/Dp4lMdmp1OBn
	Ma154bcTQZtkNB2lJhpqumgcUR+7uD2CPot0NRay7GRG1Jf+BBVwWQL48/MLt8S3El9oGjZdJuIlt
	WfOl6ZNME8M6bax8gDELxGdB+ov+YyYC1RWsTz9/yhHZL/qOdM8LG3XYTI7j6Vp698yZ7qQGrMYRg
	0YBO/yIDqhGbW4Qusn6MjFV0HVBvUFsNnqmoNP+E1TeKA60a1g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvKCR-00000002P1w-3mk9; Sun, 07 Sep 2025 20:33:15 +0200
Received: from dynamic-089-012-071-066.89.12.pool.telefonica.de ([89.12.71.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvKCR-00000003Hm5-2mkt; Sun, 07 Sep 2025 20:33:15 +0200
Message-ID: <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Yznaga
	 <anthony.yznaga@oracle.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactcode.com>
Date: Sun, 07 Sep 2025 20:33:14 +0200
In-Reply-To: <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
			 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
		 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
	 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
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

On Sun, 2025-09-07 at 19:49 +0200, John Paul Adrian Glaubitz wrote:
> Michael suggested switching to the generic copy_{to,from}_user code offli=
st
> to verify this:
>=20
> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index c305486501dc..cd1a96a918b3 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
> @@ -687,7 +687,7 @@ cheetah_tlb_fixup:
>         stw     %g2, [%g1 + %lo(tlb_type)]
> =20
>         /* Patch copy/page operations to cheetah optimized versions. */
> -       call    cheetah_patch_copyops
> +       call    generic_patch_copyops
>          nop
>         call    cheetah_patch_copy_page
>          nop
>=20
> The kernel still crashes, even when using the generic code.
>=20
> So, this particular issue is not rooted in the U3_copy_{to,from}_user cod=
e.

Replacing "call cheetah_patch_copy_page" with a nop doesn't help either:

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index c305486501dc..ed859bae5175 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -689,7 +689,7 @@ cheetah_tlb_fixup:
        /* Patch copy/page operations to cheetah optimized versions. */
        call    cheetah_patch_copyops
         nop
-       call    cheetah_patch_copy_page
+        nop
         nop
        call    cheetah_patch_cachetlbops
         nop

[  140.207051] systemd-sysv-generator[1037]: SysV service '/etc/init.d/buil=
dd' lacks a native systemd unit file, automatically generating a unit file =
for compatibility.
[  140.401791] systemd-sysv-generator[1037]: Please update package to inclu=
de a native systemd unit file.
[  140.525028] systemd-sysv-generator[1037]: =E2=9A=A0 This compatibility l=
ogic is deprecated, expect removal soon. =E2=9A=A0
[  147.718747] systemd-sysv-generator[1093]: SysV service '/etc/init.d/buil=
dd' lacks a native systemd unit file, automatically generating a unit file =
for compatibility.
[  147.913402] systemd-sysv-generator[1093]: Please update package to inclu=
de a native systemd unit file.
[  148.036530] systemd-sysv-generator[1093]: =E2=9A=A0 This compatibility l=
ogic is deprecated, expect removal soon. =E2=9A=A0
[  149.208409] Unable to handle kernel NULL pointer dereference
[  149.282820] tsk->{mm,active_mm}->context =3D 00000000000000ab
[  149.356117] tsk->{mm,active_mm}->pgd =3D fff0000008830000
[  149.424819]               \|/ ____ \|/
[  149.424819]               "@'/ .. \`@"
[  149.424819]               /_| \__/ |_\
[  149.424819]                  \__U_/
[  149.618139] systemd(1): Oops [#1]
[  149.661684] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc4+ #=
16 NONE=20
[  149.758917] TSTATE: 0000004411001602 TPC: 00000000006260a4 TNPC: 0000000=
0006260a8 Y: ffffffff    Not tainted
[  149.888258] TPC: <bpf_patch_insn_data+0x204/0x2e0>
[  149.951255] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000000=
36 g3: fff0000012178b28
[  150.065638] g4: fff0000000236300 g5: fff000023e336000 g6: fff000000026c0=
00 g7: 0000000000000001
[  150.180010] o0: 0000000100880000 o1: 0000000000000000 o2: 00000000000000=
01 o3: 0000000000000001
[  150.294387] o4: fff00000046f42a0 o5: 0000000000000001 sp: fff000000026ef=
b1 ret_pc: 0000000000626058
[  150.413336] RPC: <bpf_patch_insn_data+0x1b8/0x2e0>
[  150.476236] l0: fff0000012178000 l1: 0000000100874048 l2: 00000000000000=
01 l3: 0000000100880000
[  150.590616] l4: 0000000100874068 l5: 0000000000000005 l6: 00000000000000=
00 l7: fff000001217e128
[  150.704994] i0: 0000000100874000 i1: 0000000000000004 i2: 00000000000000=
05 i3: 0000000000000002
[  150.819434] i4: 0000000100888000 i5: fff0000012178ae8 i6: fff000000026f0=
61 i7: 000000000064b0e8
[  150.933878] I7: <bpf_check+0x1988/0x34a0>
[  150.986575] Call Trace:
[  151.018687] [<000000000064b0e8>] bpf_check+0x1988/0x34a0
[  151.088456] [<000000000061bf2c>] bpf_prog_load+0x8ec/0xc80
[  151.160510] [<000000000061db44>] __sys_bpf+0xd04/0x25a0
[  151.229138] [<000000000061f9f8>] sys_bpf+0x18/0x60
[  151.292041] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[  151.368678] Disabling lock debugging due to kernel taint
[  151.438440] Caller[000000000064b0e8]: bpf_check+0x1988/0x34a0
[  151.513936] Caller[000000000061bf2c]: bpf_prog_load+0x8ec/0xc80
[  151.591704] Caller[000000000061db44]: __sys_bpf+0xd04/0x25a0
[  151.666051] Caller[000000000061f9f8]: sys_bpf+0x18/0x60
[  151.734676] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
[  151.817025] Caller[fff000010099b80c]: 0xfff000010099b80c
[  151.886791] Instruction DUMP:
[  151.886795]  326ffffa=20
[  151.925677]  c4004000=20
[  151.956558]  c25e2038=20
[  151.987440] <c4006118>
[  152.018326]  80a0a000=20
[  152.049204]  04400014=20
[  152.080083]  c2586100=20
[  152.110960]  8400bfff=20
[  152.141845]  8e00606c=20
[  152.172726]=20
[  152.223054] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[  152.323706] Press Stop-A (L1-A) from sun keyboard or send break
[  152.323706] twice on console to return to the boot prom
[  152.470098] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

Replacing all calls with nops already triggers crashes during boot:

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index c305486501dc..1e2737649d46 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -687,11 +687,11 @@ cheetah_tlb_fixup:
        stw     %g2, [%g1 + %lo(tlb_type)]
=20
        /* Patch copy/page operations to cheetah optimized versions. */
-       call    cheetah_patch_copyops
         nop
-       call    cheetah_patch_copy_page
         nop
-       call    cheetah_patch_cachetlbops
+        nop
+        nop
+        nop
         nop
=20
        ba,a,pt %xcc, tlb_fixup_done

[   42.061355] decompression failed with status 7
[   42.172976] SCSI subsystem initialized
[   42.254511] decompression failed with status 7
[   42.462903] Unable to handle kernel NULL pointer dereference
[   42.537392] tsk->{mm,active_mm}->context =3D 000000000000004d
[   42.610625] tsk->{mm,active_mm}->pgd =3D fff0000008954000
[   42.679246]               \|/ ____ \|/
[   42.679246]               "@'/ .. \`@"
[   42.679246]               /_| \__/ |_\
[   42.679246]                  \__U_/
[   42.872571] (udev-worker)(96): Oops [#1]
[   42.924111] CPU: 0 UID: 0 PID: 96 Comm: (udev-worker) Not tainted 6.17.0=
-rc4+ #14 NONE=20
[   43.029343] TSTATE: 0000000011001601 TPC: 0000000000f6875c TNPC: 0000000=
000f68760 Y: 00000000    Not tainted
[   43.158584] TPC: <strcmp+0x1c/0x60>
[   43.204430] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000000=
6f g3: 000000001001a130
[   43.318825] g4: fff000000873cd00 g5: fff000023e336000 g6: fff00000088c40=
00 g7: 000000001001a058
[   43.433291] o0: 00000009e2fc2857 o1: 0000000000000000 o2: 00000000000000=
01 o3: 0000000000000000
[   43.547667] o4: 0000000000000dc0 o5: 0000000000000dc0 sp: fff00000088c6f=
21 ret_pc: 00000000005a1fe4
[   43.666617] RPC: <trace_clock_local+0x4/0x20>
[   43.723797] l0: fff000000004c798 l1: 0000000000000001 l2: fff000000004c5=
10 l3: 0000000000000000
[   43.838177] l4: 0000000000000000 l5: 00000000014da748 l6: 00000000012a7e=
f8 l7: 0000000000000000
[   43.952553] i0: 0000000010076e97 i1: 0000000000000000 i2: 00000000015370=
f8 i3: 0000000000000000
[   44.066928] i4: 0000000000000000 i5: 0000000000000dc0 i6: fff00000088c6f=
d1 i7: 000000000053a2d0
[   44.181303] I7: <cmp_name+0x10/0x20>
[   44.228190] Call Trace:
[   44.260219] [<000000000053a2d0>] cmp_name+0x10/0x20
[   44.324268] [<0000000000a20dc0>] bsearch+0x20/0x60
[   44.387173] [<000000000053a45c>] find_exported_symbol_in_section+0x5c/0x=
c0
[   44.477532] [<000000000053ba50>] find_symbol+0xd0/0x160
[   44.546153] [<000000000053e76c>] load_module+0x1acc/0x22c0
[   44.618211] [<000000000053f16c>] init_module_from_file+0x6c/0xc0
[   44.697130] [<000000000053f3cc>] sys_finit_module+0x1ac/0x300
[   44.772618] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[   44.849248] Disabling lock debugging due to kernel taint
[   44.919018] Caller[000000000053a2d0]: cmp_name+0x10/0x20
[   44.988784] Caller[0000000000a20dc0]: bsearch+0x20/0x60
[   45.057412] Caller[000000000053a45c]: find_exported_symbol_in_section+0x=
5c/0xc0
[   45.153487] Caller[000000000053ba50]: find_symbol+0xd0/0x160
[   45.227831] Caller[000000000053e76c]: load_module+0x1acc/0x22c0
[   45.305604] Caller[000000000053f16c]: init_module_from_file+0x6c/0xc0
[   45.390244] Caller[000000000053f3cc]: sys_finit_module+0x1ac/0x300
[   45.471447] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
[   45.553799] Caller[fff000010470e2fc]: 0xfff000010470e2fc
[   45.623566] Instruction DUMP:
[   45.623569]  2240000b=20
[   45.662452]  b0102000=20
[   45.693333]  c40e0001=20
[   45.724211] <c60e4001>
[   45.755093]  80a08003=20
[   45.785978]  024ffffa=20
[   45.816857]  82006001=20
[   45.847737]  b0102001=20
[   45.878620]  b16567ff=20
[   45.909502]=20
[   63.467354] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   63.545187] rcu:     (detected by 0, t=3D5252 jiffies, g=3D-87, q=3D21 n=
cpus=3D1)
[   63.630966] rcu: All QSes seen, last rcu_sched kthread activity 5252 (42=
94906056-4294900804), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
[   63.792241] rcu: rcu_sched kthread starved for 5252 jiffies! g-87 f0x2 R=
CU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[   63.922625] rcu:     Unless rcu_sched kthread gets sufficient CPU time, =
OOM is now expected behavior.
[   64.040431] rcu: RCU grace-period kthread stack dump:
[   64.106766] task:rcu_sched       state:R  running task     stack:0     p=
id:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
[   64.272615] Call Trace:
[   64.304632] [<0000000000f8857c>] schedule+0x1c/0x180
[   64.369827] [<0000000000f8f61c>] schedule_timeout+0x5c/0xe0
[   64.443027] [<0000000000529550>] rcu_gp_fqs_loop+0x130/0x540
[   64.517372] [<000000000052e6f4>] rcu_gp_kthread+0x174/0x200
[   64.590571] [<00000000004aa700>] kthread+0xe0/0x280
[   64.654620] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   64.724391] [<0000000000000000>] 0x0
[   64.771284] rcu: Stack dump where RCU GP kthread last ran:
[   64.843343] CPU: 0 UID: 0 PID: 96 Comm: (udev-worker) Tainted: G      D =
            6.17.0-rc4+ #14 NONE=20
[   64.969158] Tainted: [D]=3DDIE
[   65.006896] TSTATE: 0000008080001606 TPC: 00000000007a0fa0 TNPC: 0000000=
0007a0fa4 Y: 00000000    Tainted: G      D           =20
[   65.156733] TPC: <count_memcg_events+0x100/0x200>
[   65.218489] g0: fff000023f804f78 g1: 00000000014e1f00 g2: 00000000014e63=
40 g3: 00000000014e2100
[   65.332869] g4: fff000000873cd00 g5: fff000023e336000 g6: fff00000088c40=
00 g7: fff000023f81c350
[   65.447243] o0: fff000000025a880 o1: 0000000000000000 o2: fff000000825a0=
c8 o3: 80000002026d6fb2
[   65.561617] o4: 0000000000000000 o5: 0000000000000000 sp: fff00000088c64=
91 ret_pc: 00000000007a0f94
[   65.680568] RPC: <count_memcg_events+0xf4/0x200>
[   65.741182] l0: 0000000000100073 l1: fff000023f804f38 l2: fff000023f804f=
78 l3: fff000023f804fb8
[   65.855563] l4: 0000000000000000 l5: 0000000000000005 l6: 00000000000000=
00 l7: 0000000000000008
[   65.969937] i0: fff000000025a880 i1: 000000000000000e i2: 00000000000000=
01 i3: fff0000008256820
[   66.084313] i4: 0000000000000001 i5: 00000000014f9000 i6: fff00000088c65=
41 i7: 0000000000722890
[   66.198686] I7: <handle_mm_fault+0x190/0x2e0>
[   66.255870] Call Trace:
[   66.287895] [<0000000000722890>] handle_mm_fault+0x190/0x2e0
[   66.362241] [<0000000000f92e00>] do_sparc64_fault+0x6c0/0xb20
[   66.437727] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
[   66.520077] [<0000000000562070>] exit_robust_list+0x10/0x120
[   66.594422] [<0000000000562710>] futex_exit_release+0x70/0xc0
[   66.669910] [<000000000047b48c>] exit_mm_release+0xc/0x40
[   66.740821] [<0000000000483ab8>] do_exit+0x198/0xb80
[   66.806014] [<0000000000484528>] make_task_dead+0x88/0x160
[   66.878070] [<0000000000428374>] die_if_kernel+0x260/0x26c
[   66.950126] [<0000000000f9271c>] unhandled_fault+0x88/0xac
[   67.022184] [<0000000000f92af0>] do_sparc64_fault+0x3b0/0xb20
[   67.097670] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
[   67.180022] [<0000000000f6875c>] strcmp+0x1c/0x60
[   67.241784] [<000000000053a2d0>] cmp_name+0x10/0x20
[   67.305833] [<0000000000a20dc0>] bsearch+0x20/0x60
[   67.368740] [<000000000053a45c>] find_exported_symbol_in_section+0x5c/0x=
c0

I assume that cheetah_patch_cachetlbops has to be invoked on UltraSPARC III
since there is other code depending on it. On the other hand, the TLB code
on UltraSPARC III was heavily overhauled in 2016 [1] which was also followe=
d
by a bug fix [2].

Chances are there are still bugs in the code introduced in [1].

Adrian

> [1] https://github.com/torvalds/linux/commit/a74ad5e660a9ee1d071665e7e8ad=
822784a2dc7f
> [2] https://github.com/torvalds/linux/commit/d3c976c14ad8af421134c428b0a8=
9ff8dd3bd8f8

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
