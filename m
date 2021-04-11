Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2CC433B4
	for <sparclinux@archiver.kernel.org>; Sun, 11 Apr 2021 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FAC610C8
	for <sparclinux@archiver.kernel.org>; Sun, 11 Apr 2021 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhDKNFX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 11 Apr 2021 09:05:23 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:18642 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhDKNFX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 11 Apr 2021 09:05:23 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 09:05:22 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-09.nifty.com with ESMTP id 13BCsZrv005796
        for <sparclinux@vger.kernel.org>; Sun, 11 Apr 2021 21:54:35 +0900
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 13BCs7tp029971;
        Sun, 11 Apr 2021 21:54:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 13BCs7tp029971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618145647;
        bh=kYvj6hvm8jlmAX1g3RDq6TVy4tWUNVkGgzR+eUkJ8x4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGD8NwNcV2r3xxRTPTrzVmSaKiT75l2+jXUNOJhN158XwjYkyhJ2tiZKofoEFil0Y
         NTbjjvxJwaCEUdObEtXMH6+/ScBY8SuoopIGOo7QqZMEQod/JrOtITkEAAxbRvxLbR
         h8A1ydMSDOIr6k9mlie6QEEW3+uWsfiB546bvjU4wHrqVSQxD0I1/AtCQP8DBQUUjP
         EEhbrO5E7vwFIli9lweuVpmG0byeS7JFCdqIStjHN5ipNsSyOMcTvqjfc/aM+/w2nN
         0r+YtVxfGiHXfJuELcjo+FivaQeae5sMg/PcInsnEbHYsKNkUHpEoMlYwiYFj5oMh5
         PNlv/CJm2mW+g==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so1349645pjb.4;
        Sun, 11 Apr 2021 05:54:07 -0700 (PDT)
X-Gm-Message-State: AOAM530rs20a3S3+TEW6bqnIWp04z8Fua1FUCoUZxD7qKj9u2LvIvXOb
        odS7sDtRuoHg2ZPTYjZK7erGU65VM0z/PMGbVPQ=
X-Google-Smtp-Source: ABdhPJxLJpTl6hQzx5iKsr9iCxCNXh5RPfX81SkInh/0YW5yNK0RK/Eav/KW2FE1/KiGB8XNyq0wFOW9L+lEs0JyIcg=
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr23966534pjd.198.1618145646535;
 Sun, 11 Apr 2021 05:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210301145102.358960-1-masahiroy@kernel.org>
In-Reply-To: <20210301145102.358960-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Apr 2021 21:53:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHwnZKZBUc6O9ywyueiZ5MYeTx2XKsep0E+cWAeXNBRA@mail.gmail.com>
Message-ID: <CAK7LNASHwnZKZBUc6O9ywyueiZ5MYeTx2XKsep0E+cWAeXNBRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sparc: syscalls: switch to generic syscalltbl.sh
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Mar 1, 2021 at 11:51 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Many architectures duplicate similar shell scripts.
>
> This commit converts sparc to use scripts/syscalltbl.sh. This also
> unifies syscall_table_64.h and syscall_table_c32.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Could you check this series, please?

Thanks.
Masahiro




> ---
>
>  arch/sparc/include/asm/Kbuild            |  1 -
>  arch/sparc/kernel/syscalls/Makefile      | 19 ++++---------
>  arch/sparc/kernel/syscalls/syscalltbl.sh | 36 ------------------------
>  arch/sparc/kernel/systbls_32.S           |  4 +--
>  arch/sparc/kernel/systbls_64.S           |  8 ++++--
>  5 files changed, 12 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index aec20406145e..0b9d98ced34a 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
> -generated-y += syscall_table_c32.h
>  generic-y += export.h
>  generic-y += kvm_para.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
> index 283f64407b07..11424f1c8d9e 100644
> --- a/arch/sparc/kernel/syscalls/Makefile
> +++ b/arch/sparc/kernel/syscalls/Makefile
> @@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>
>  syscall := $(src)/syscall.tbl
>  syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +systbl := $(srctree)/scripts/syscalltbl.sh
>
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'       \
> @@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
>                    '$(syshdr_offset_$(basetarget))'
>
>  quiet_cmd_systbl = SYSTBL  $@
> -      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'       \
> -                  '$(systbl_abis_$(basetarget))'               \
> -                  '$(systbl_abi_$(basetarget))'                \
> -                  '$(systbl_offset_$(basetarget))'
> +      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
>
>  syshdr_abis_unistd_32 := common,32
>  $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
> @@ -29,23 +26,17 @@ syshdr_abis_unistd_64 := common,64
>  $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
>         $(call if_changed,syshdr)
>
> -systbl_abis_syscall_table_32 := common,32
> +$(kapi)/syscall_table_32.h: abis := common,32
>  $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
>         $(call if_changed,systbl)
>
> -systbl_abis_syscall_table_64 := common,64
> +$(kapi)/syscall_table_64.h: abis := common,64
>  $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
>         $(call if_changed,systbl)
>
> -systbl_abis_syscall_table_c32 := common,32
> -systbl_abi_syscall_table_c32 := c32
> -$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
> -       $(call if_changed,systbl)
> -
>  uapisyshdr-y           += unistd_32.h unistd_64.h
>  kapisyshdr-y           += syscall_table_32.h           \
> -                          syscall_table_64.h           \
> -                          syscall_table_c32.h
> +                          syscall_table_64.h
>
>  uapisyshdr-y   := $(addprefix $(uapi)/, $(uapisyshdr-y))
>  kapisyshdr-y   := $(addprefix $(kapi)/, $(kapisyshdr-y))
> diff --git a/arch/sparc/kernel/syscalls/syscalltbl.sh b/arch/sparc/kernel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index 77cf0143ba19..000000000000
> --- a/arch/sparc/kernel/syscalls/syscalltbl.sh
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -in="$1"
> -out="$2"
> -my_abis=`echo "($3)" | tr ',' '|'`
> -my_abi="$4"
> -offset="$5"
> -
> -emit() {
> -       t_nxt="$1"
> -       t_nr="$2"
> -       t_entry="$3"
> -
> -       while [ $t_nxt -lt $t_nr ]; do
> -               printf "__SYSCALL(%s, sys_nis_syscall, )\n" "${t_nxt}"
> -               t_nxt=$((t_nxt+1))
> -       done
> -       printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -       nxt=0
> -       if [ -z "$offset" ]; then
> -               offset=0
> -       fi
> -
> -       while read nr abi name entry compat ; do
> -               if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
> -                       emit $((nxt+offset)) $((nr+offset)) $compat
> -               else
> -                       emit $((nxt+offset)) $((nr+offset)) $entry
> -               fi
> -               nxt=$((nr+1))
> -       done
> -) > "$out"
> diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
> index ab9e4d57685a..3aaffa017706 100644
> --- a/arch/sparc/kernel/systbls_32.S
> +++ b/arch/sparc/kernel/systbls_32.S
> @@ -9,10 +9,10 @@
>   * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
>   */
>
> -#define __SYSCALL(nr, entry, nargs) .long entry
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)      __SYSCALL(nr, native)
> +#define __SYSCALL(nr, entry) .long entry
>         .data
>         .align 4
>         .globl sys_call_table
>  sys_call_table:
>  #include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
> -#undef __SYSCALL
> diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
> index a27394bf7d7f..398fe449dd34 100644
> --- a/arch/sparc/kernel/systbls_64.S
> +++ b/arch/sparc/kernel/systbls_64.S
> @@ -10,18 +10,20 @@
>   * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
>   */
>
> -#define __SYSCALL(nr, entry, nargs) .word entry
> +#define __SYSCALL(nr, entry) .word entry
>         .text
>         .align  4
>  #ifdef CONFIG_COMPAT
>         .globl sys_call_table32
>  sys_call_table32:
> -#include <asm/syscall_table_c32.h>     /* Compat syscalls */
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)      __SYSCALL(nr, compat)
> +#include <asm/syscall_table_32.h>      /* Compat syscalls */
> +#undef __SYSCALL_WITH_COMPAT
>  #endif /* CONFIG_COMPAT */
>
>         .align  4
>         .globl sys_call_table64, sys_call_table
>  sys_call_table64:
>  sys_call_table:
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)      __SYSCALL(nr, native)
>  #include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
> -#undef __SYSCALL
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
