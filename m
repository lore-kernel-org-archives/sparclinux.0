Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794383492;
	b=ykiFzDTdru2nRoiI5AUxrDJJt3rj8jXQ1JR7tSHmzIpk8vgdKutV9TGnqL3SpNnwmUj+
	 dfZDKrwx6kB4CrX543JIhk9p3DdBGy/8f2OtkI09BVGhXuwiTyzf37Mxbc33Z4li7higL
	 JE4lwD1Upt9TvPAaw8vgh3FOLL3D2uFT5XGpgUWZuE+CM2FT3COVXs+bCDWWngkAiAP7G
	 gGDSpkwH3ahSLrfuUHwHEJagMJsQ/AC0kwKhVqoNFK77jjxyFDapy+aUrnDNHmEpsOmRd
	 JBI7B35mxJNCCEprNHx3Wd5/QqApcbLqUgASJ12vu+2QE36lSTKUUJ4+mS8E1/1d1Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LFEMjHMawTmVswvfRrvWbFxJOe74UcDMeDcBfOcyoV4=;
	b=QZTg/GDdqdncrJzOhKwyaG+XttW/BnMzjFpA9M4t1BB5oHhpG4XQfSpGsd7quGvnXOdv
	 b3i9ISEOUaUOv5eHiPomspYX7V1r6a0BOU68/NzwiJz3eKIshokVm1KloIwLU5jXbTib1
	 G8YEpK9vhUwt28iwZC7DQuS+r8wltiOeD6qeafNoLYXTBP0CwTNAn3wdCVfv6tk2VVH7g
	 bZbdnYFSS8vUWNEuRJXIi48muT1/lDpFGQWl/fqbTHu60ftht1JGpn2MlTY8UivGmQJY4
	 HKe+g+LI0DUoD2C0zrkEpHy4+aQEhFm4cftwxcB1WPsconQstEpVDAd+XWPD+/bCVmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=md4l3zAY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27279606A31C
	for <sparclinux@vger.kernel.org>; Wed, 11 Nov 2026 07:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27279606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=md4l3zAY
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c505186727fso207016066b.3
        for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 23:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794383490; cv=none;
        d=google.com; s=arc-20260327;
        b=CFTu3Yq7x298zOinrMlqmbflmhM6KIwB5PtUKYISqgLVhih+ZqmG08B54RERYyE4Rj
         rOQ2HorJXm20iMIVtGVV6BySTVWKpFP/jiyC5Pt9QQPokO8humFU6Nt42+RzYIkxfyIk
         BhZUJw4o0HBTkBoprmFfgz5Fx/Txc4aTitbal+8dxKwGeAR+5x5UkTFixcjD0j31fqNn
         C5VI7AEGRzAJu0/cukPqoxrQC4q+pX4Sz3nHz91bIafjGQJdpL8wIP3zL9bvkXqYB/JZ
         PLnqt2R1a1kln8JhyUDYT9pMNwxJp/usoN3LpQCPVu/MArl/tlhLa4xbpI/IPoxTzgH/
         mufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LFEMjHMawTmVswvfRrvWbFxJOe74UcDMeDcBfOcyoV4=;
        fh=B1/l84wGnNH44WavTeoUK9VxDL4mphdjB8CFNH7uGi0=;
        b=q0kWak0Q+brTIfzK+WZ4izrutsx8MuCT9QzRNhY1gVjhSrSEtRSACjSh9ZwmPTXdEV
         2ap7VNEQ/ocDjTwnpJpStGWWyQ44DLkz/3wII4EcrL8pTmXXQAkaShICD2+hXEZ1Ir7e
         CcQpNm0G+6YZTii48R0G0ppFt640+O4i8A1z31QKZnW1GD7CHqi2106Smbx407LV68kI
         PVcH7Cla7L7S/UPFEn02oLZM2tCsPg8oteLz4p3waMHyqrGrAW+dwQxd3cp1MPqp+a0A
         vRrOC0XkcYrIdlfZCoMlQsqku7619MWaFts6nwx/4ha9fL4nLObwy9qUcHuxyS48efBh
         bp1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794383490; x=1794988290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LFEMjHMawTmVswvfRrvWbFxJOe74UcDMeDcBfOcyoV4=;
        b=md4l3zAYv1zu9HhijK+oX3dpDB6YUSeOKHdEMKTuN7pX+J0HNpZQaAtuo3AKBkgH7s
         Xol8EfdG076x931RcDKNcJMSnMJqRR9zy2fns0x48pWylIn+nzYcFB3mqKrdNbi2xkgq
         W9FOovP9uE8OulDKq2Mr+k7s0oo6YxvtxoWjuUd8CwzVieGl9R+IqZ8ZhCK4zSe9dF7B
         vQpHxeF2Vo9uDifi6j0iiemE6/GzaxofZXrrz2bF5g9h7P/Bww+w1X27r7PK9XQa35eh
         70AF3W71JWv7eNXpZwiksuer5G6PZ1mIkog11t93J4zqczq1jX+HjywgfOx+nUnWwkf8
         bVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383490; x=1794988290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFEMjHMawTmVswvfRrvWbFxJOe74UcDMeDcBfOcyoV4=;
        b=DQxA8piH72pKod2w6BZdYG2xsTB2it4GsnrVyvgHW2VYVhNTqxVjOUGVtNZwpEx76I
         XwwKnlpJmcRk1cVdvUBbM6IJnzV3Z3cqsFwS4DSQyPixNrklQP8mFCXWuszmsE486Ick
         /IBiBx0FyDkX2VPsS0wM98AIvQdOwx2HNZtLfOujz9ynlsrps3Gy7UOfaWBvGKjnOGeH
         m5gftlXwSdWU5OydCCfcWfagO1nQqdt+EXm+lhCar2+gjX1GlzkD85Z1WOEgP6j+Vj/0
         DCDFQrEsVuhgsxTVJma/TYDMvYBQHe62h6xiuOgWhN127yjWsGN0/NzWv518kNUnFs2q
         uOZg==
X-Forwarded-Encrypted: i=1; AL+hErGDDEtvh9tsyce7ntuMDpMy1ESASuRRSGhlLcIfbWyK0pk3S0Xvii7RA0WiZhnlAs3hb+wXcveuuJWg@vger.kernel.org
X-Gm-Message-State: APuU4Z9xeOgbyNCId35/fQDhv+dD8VGvK6QsQC0Yhk52nptOn8ltp7nr
	Tghg67snYXSmT2CSDX//X3oOSxPKWAkq540qOMHq3TBhdQBG1Gl0Ou89G4lfMwNRpWTr1iv7kuu
	2Dfg0RzDyLXNpHqXUK8Ob3LfcLg/7KJ8=
X-Gm-Gg: AYBFou1BDF14hUJPyTiRuZTzdYd+cESjig41cWTc1KlLb4JKcmuyZcLc5+Rti97gkqN
	zFAL0MoOyHb6gK17qguSSX0vFc9zKRB2bVthyGz2PisgyiL3WGzriOTtFb/blbeCmJIAGJzcW3n
	QeDE/Z5v8j248Z+zqNePA3cyT1ANrSAI6ZvaJ4vZKmhxw6gzXxmLOnRSFeipk+VaREEB6O9cJ5v
	hP0YGQoMSg8JljKoz5Vpv6xPKocNxpL2Q6pZ507Pqe8E0vKRc4MC2bgUueIaksBvVNFkj2/nNU+
	TNPhsagFQ5Yl1xdTE/vjARSr4SHvhEr80SbhKCmuj1JeI+yKu9atP5d3HOktDoWqoFhPc3mxWDy
	DvSBSQYy/UxKa6HhPuE9wLCXFlM5uEukhGJg865RiWZZvM9tyxfPpbn5EIaglpNXh2D65wA==
X-Received: by 2002:a17:906:f596:b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c5066d0bb14mr114825966b.43.1794383490428; Tue, 10 Nov 2026
 23:51:30 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com> <20261105-tonyk-syscall_table-v9-12-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-12-8d1275885d9c@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Nov 2026 08:51:18 +0100
X-Gm-Features: AclHuK9CC8htHdABEClpUnIw4kUNRCRbcWaYA_peZjxEX-MI6234hqDvVucRruU
Message-ID: <CA+=Fv5QBnNipJH5SKKV0iiPc1CQz+6f8dGzsRoKt1riMNxxOOg@mail.gmail.com>
Subject: Re: [PATCH v9 12/15] alpha: Use the common syscall table
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Thu, Nov 5, 2026 at 9:06=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Remove some of the duplicated code by using the common syscall number
> table.
>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/syscalls/Makefile    | 14 +++++++---
>  arch/alpha/kernel/syscalls/syscall.tbl | 49 ----------------------------=
------
>  arch/alpha/kernel/systbls.S            |  1 +
>  3 files changed, 11 insertions(+), 53 deletions(-)
>
> diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/sysc=
alls/Makefile
> index b265e4bc16c2..03099daff6b9 100644
> --- a/arch/alpha/kernel/syscalls/Makefile
> +++ b/arch/alpha/kernel/syscalls/Makefile
> @@ -7,17 +7,23 @@ $(shell mkdir -p $(uapi) $(kapi))
>  syscall :=3D $(src)/syscall.tbl
>  syshdr :=3D $(srctree)/scripts/syscallhdr.sh
>  systbl :=3D $(srctree)/scripts/syscalltbl.sh
> +systbl_common :=3D $(srctree)/scripts/syscall_common.tbl
> +abis :=3D common,__clone3
>
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr $< $@
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr \
> +                  --common-tbl $(systbl_common) --common-offset 110 \
> +                  --abis $(abis) $< $@
>
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) \
> +                  --common-tbl $(systbl_common) --common-offset 110 \
> +                  --abis $(abis) $< $@
>
> -$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
> +$(uapi)/unistd_32.h: $(syscall) $(systbl_common) $(syshdr) FORCE
>         $(call if_changed,syshdr)
>
> -$(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
> +$(kapi)/syscall_table.h: $(syscall) $(systbl_common) $(systbl) FORCE
>         $(call if_changed,systbl)
>
>  uapisyshdr-y           +=3D unistd_32.h
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 59eb066a40bf..7066a3920899 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -463,52 +463,3 @@
>  532    common  getppid                         sys_getppid
>  # all other architectures have common numbers for new syscall, alpha
>  # is the exception.
> -534    common  pidfd_send_signal               sys_pidfd_send_signal
> -535    common  io_uring_setup                  sys_io_uring_setup
> -536    common  io_uring_enter                  sys_io_uring_enter
> -537    common  io_uring_register               sys_io_uring_register
> -538    common  open_tree                       sys_open_tree
> -539    common  move_mount                      sys_move_mount
> -540    common  fsopen                          sys_fsopen
> -541    common  fsconfig                        sys_fsconfig
> -542    common  fsmount                         sys_fsmount
> -543    common  fspick                          sys_fspick
> -544    common  pidfd_open                      sys_pidfd_open
> -545    common  clone3                          __sys__clone3
> -546    common  close_range                     sys_close_range
> -547    common  openat2                         sys_openat2
> -548    common  pidfd_getfd                     sys_pidfd_getfd
> -549    common  faccessat2                      sys_faccessat2
> -550    common  process_madvise                 sys_process_madvise
> -551    common  epoll_pwait2                    sys_epoll_pwait2
> -552    common  mount_setattr                   sys_mount_setattr
> -553    common  quotactl_fd                     sys_quotactl_fd
> -554    common  landlock_create_ruleset         sys_landlock_create_rules=
et
> -555    common  landlock_add_rule               sys_landlock_add_rule
> -556    common  landlock_restrict_self          sys_landlock_restrict_sel=
f
> -# 557 reserved for memfd_secret
> -558    common  process_mrelease                sys_process_mrelease
> -559    common  futex_waitv                     sys_futex_waitv
> -560    common  set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
> -561    common  cachestat                       sys_cachestat
> -562    common  fchmodat2                       sys_fchmodat2
> -563    common  map_shadow_stack                sys_map_shadow_stack
> -564    common  futex_wake                      sys_futex_wake
> -565    common  futex_wait                      sys_futex_wait
> -566    common  futex_requeue                   sys_futex_requeue
> -567    common  statmount                       sys_statmount
> -568    common  listmount                       sys_listmount
> -569    common  lsm_get_self_attr               sys_lsm_get_self_attr
> -570    common  lsm_set_self_attr               sys_lsm_set_self_attr
> -571    common  lsm_list_modules                sys_lsm_list_modules
> -572    common  mseal                           sys_mseal
> -573    common  setxattrat                      sys_setxattrat
> -574    common  getxattrat                      sys_getxattrat
> -575    common  listxattrat                     sys_listxattrat
> -576    common  removexattrat                   sys_removexattrat
> -577    common  open_tree_attr                  sys_open_tree_attr
> -578    common  file_getattr                    sys_file_getattr
> -579    common  file_setattr                    sys_file_setattr
> -580    common  listns                          sys_listns
> -581    common  rseq_slice_yield                sys_rseq_slice_yield
> -582    common  fchroot                         sys_fchroot
> diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
> index 68f3e4f329eb..9a67d29f7818 100644
> --- a/arch/alpha/kernel/systbls.S
> +++ b/arch/alpha/kernel/systbls.S
> @@ -7,6 +7,7 @@
>
>  #include <asm/unistd.h>
>
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, n=
ative)
>  #define __SYSCALL(nr, entry) .quad entry
>         .data
>         .align 3
>
> --
> 2.56.0
>

This also needs an adjustment when combined with my Alpha for-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git
  branch: for-next

Following d38895ba9330 ("alpha: dispatch system calls from C"), Alpha
uses sys_clone3 directly. The ABI selection should therefore be:

  abis :=3D common,clone3

rather than common,__clone3. The removal of the old table entries
also conflicts because the clone3 entry has changed.

For testing, I skipped patch 11, removed the entries from 534 onward
as intended here, and selected common,clone3.

With those adjustments, full GENERIC SMP and DP264 UP builds passed
using GCC 14.2.1. The generated syscall numbers are unchanged.
Comparing the native dispatch entries shows only patch 10's intended
change at syscall 560; clone3 remains sys_clone3.

The only build warning was the previously observed saved_config
COMMON-symbol warning. I have not runtime-tested this combination.

Thanks,
Magnus
