Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B5C07E99
	for <sparclinux@archiver.kernel.org>; Mon,  5 Jul 2021 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66136194B
	for <sparclinux@archiver.kernel.org>; Mon,  5 Jul 2021 15:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGEPTj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 5 Jul 2021 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhGEPTj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 5 Jul 2021 11:19:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFDC061574;
        Mon,  5 Jul 2021 08:17:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so29654924ybe.2;
        Mon, 05 Jul 2021 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6BfvqL2TwWJutuMPMXBqQIKciTSZyE9YY2SXs3fguC0=;
        b=TleNc/ypyUph4YVB3S6G0b46yD6HIC4q6WhX8CNkcW4G8rlY5Npuj5eBOCWpzG2SRJ
         yn2hElZi9hBRY51QV+CJfczUHgGIMnTElaHJU04AtBDqJqC31j/7/olbi48vv7oI9uV1
         nsWMFJMXr3xxxzcUIaKTtKA4XGaBkQx6HckINr1QKdkARhKxfpCiWWAgUdKXBsasf+uq
         orHKIjwTgBu1FJLSGX+fI9SnySTICmgnkUCYO3asSRj7f4uWoOXk9mlebN82uE/TT5mW
         /ukv+nqBfhlu72rC6BlcMcUkyp/aLVKJAmXTsgorw16psJtJkyQmeTiOhkunapR7QDCk
         ujdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6BfvqL2TwWJutuMPMXBqQIKciTSZyE9YY2SXs3fguC0=;
        b=g1qnoo6Jh7nrLAV08yfOnWKs+NdvvAxXXHJVRi4ydjGvWnQbP1C/Fofu0Ms2LLi3XU
         vPz5so3ANhEjK/ZNf/nz1QD3nRSCeBGGspsBQVFA1az3Uhl88KREbjqblMarBTEGOGNy
         Xu7u1bfT8cRk6Sj4ispSHzxkophnkeoYrCcT+Nac7JHa9HfA1ZgtMzU4q9GpUJ1LWjEb
         QZSXKQtjQFMT65HfgSQEIOSRe5dNLNuXgGnxjM07EYGNN7i11ajW8Yd5VhtSEXN5cdOK
         bERcdIIitNddvKv2iWVwQvJA0p07xUlg/5pbcH7CQSI+RzGO8eL6tMq+98vUaCC33utH
         0Pgg==
X-Gm-Message-State: AOAM531EMK8Uska/dDh6Vvy/jXuYWYdJRMd1XBryLmMHIkFsy6L5Xp2U
        UTLidJdbW0xPm30JDCrJ/EkIDsLRA7EnbtVx6D6eJH0CZNk=
X-Google-Smtp-Source: ABdhPJzQVEAO+irznBeOZfwOKSJg059CWYpmum1cvzmYO6dzfhqSCJeMLCkRFeHa1gLBfGLWTsC5jBUHwVBoC3lhUA0=
X-Received: by 2002:a25:bc0f:: with SMTP id i15mr698571ybh.233.1625498220266;
 Mon, 05 Jul 2021 08:17:00 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 5 Jul 2021 18:16:49 +0300
Message-ID: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
Subject: [sparc64] locking/atomic, kernel OOPS on running stress-ng
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hello!

latest sparc64 git kernel produces the following OOPS on running stress-ng =
as :

$ stress-ng -v --mmap 1 -t 30s

kernel OOPS (console logs):

[   27.276719] Unable to handle kernel NULL pointer dereference
[   27.276782] tsk->{mm,active_mm}->context =3D 00000000000003cb
[   27.276818] tsk->{mm,active_mm}->pgd =3D fff800003a2a0000
[   27.276853]               \|/ ____ \|/
[   27.276853]               "@'/ .. \`@"
[   27.276853]               /_| \__/ |_\
[   27.276853]                  \__U_/
[   27.276927] stress-ng(928): Oops [#1]
[   27.276961] CPU: 0 PID: 928 Comm: stress-ng Tainted: G            E
    5.13.0-rc1-00111-g8e6a4b3afe64 #257
[   27.277021] TSTATE: 0000009911001603 TPC: 000000000044f3c4 TNPC:
000000000044f3c8 Y: 00000000    Tainted: G            E
[   27.277084] TPC: <pmdp_invalidate+0x24/0xc0>
[   27.277129] g0: 0000000000000000 g1: 3d0000004d800653 g2:
0000000000000000 g3: 0006000000000000
[   27.277180] g4: fff80000370a9c00 g5: fff8000229666000 g6:
fff8000047404000 g7: 0000000000090014
[   27.277231] o0: 0000000000000001 o1: 0000000000000000 o2:
fff80000370aa4b8 o3: 0000000000000000
[   27.277283] o4: 2ec9091000000000 o5: 0000000000f86c00 sp:
fff8000047406ec1 ret_pc: 00000000004d197c
[   27.277337] RPC: <lock_acquire+0x1bc/0x200>
[   27.277377] l0: 000000000119b1c0 l1: 0000000000000000 l2:
0000000001205e48 l3: 81123ddb8627a322
[   27.277432] l4: c269484aab0b613a l5: 000000000148f800 l6:
ffffffff7c8086d1 l7: 0000000001204788
[   27.277487] i0: fff8000043c9ce40 i1: fff8000104800000 i2:
fff80000424d9048 i3: bd0000004d800653
[   27.277540] i4: 3d0000004d800653 i5: bd0000004d800653 i6:
fff8000047406f71 i7: 000000000069e4ac
[   27.277593] I7: <__split_huge_pmd_locked+0x1ec/0x5e0>
[   27.277639] Call Trace:
[   27.277662] [<000000000069e4ac>] __split_huge_pmd_locked+0x1ec/0x5e0
[   27.277708] [<000000000069ff48>] __split_huge_pmd+0x288/0x2e0
[   27.277751] [<00000000006a0638>] split_huge_pmd_address+0x78/0xa0
[   27.277797] [<00000000006a0780>] vma_adjust_trans_huge+0x120/0x160
[   27.277843] [<000000000065ac70>] __vma_adjust+0x1d0/0xb00
[   27.277887] [<000000000065bfb0>] __split_vma+0xf0/0x180
[   27.277927] [<0000000000675704>] madvise_behavior+0x224/0x2a0
[   27.277972] [<0000000000677418>] do_madvise+0x478/0x600
[   27.278011] [<0000000000677778>] sys_madvise+0x18/0x40
[   27.278050] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[   27.278100] Disabling lock debugging due to kernel taint
[   27.278112] Caller[000000000069e4ac]: __split_huge_pmd_locked+0x1ec/0x5e=
0
[   27.278130] Caller[000000000069ff48]: __split_huge_pmd+0x288/0x2e0
[   27.278146] Caller[00000000006a0638]: split_huge_pmd_address+0x78/0xa0
[   27.278161] Caller[00000000006a0780]: vma_adjust_trans_huge+0x120/0x160
[   27.278177] Caller[000000000065ac70]: __vma_adjust+0x1d0/0xb00
[   27.278191] Caller[000000000065bfb0]: __split_vma+0xf0/0x180
[   27.278208] Caller[0000000000675704]: madvise_behavior+0x224/0x2a0
[   27.278222] Caller[0000000000677418]: do_madvise+0x478/0x600
[   27.278237] Caller[0000000000677778]: sys_madvise+0x18/0x40
[   27.278253] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
[   27.278267] Caller[00000100000bd02c]: 0x100000bd02c
[   27.278281] Instruction DUMP:
[   27.278285]  ba10001b
[   27.278295]  8210001c
[   27.278304]  84102000
[   27.278313] <c3f0901d>
[   27.278321]  80a0401d
[   27.278330]  22600004
[   27.278338]  d05e2040
[   27.278346]  106ffffa
[   27.278354]  fa5e8000
[   27.278363]

tried to bisect this OOPS, but was unable to find the latest commit
id, without cherry-pick:

linux-2.6$ git describe
v5.13-rc1-111-gb9b12978a8e9

linux-2.6$ make
  CC      kernel/bounds.s
In file included from ./include/linux/atomic.h:87,
                 from ./include/asm-generic/bitops/lock.h:5,
                 from ./arch/sparc/include/asm/bitops_64.h:52,
                 from ./arch/sparc/include/asm/bitops.h:5,
                 from ./include/linux/bitops.h:32,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:20,
                 from ./arch/sparc/include/asm/bug.h:25,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/asm-generic/atomic-long.h: In function =E2=80=98atomic_long_add_r=
eturn=E2=80=99:
./include/asm-generic/atomic-long.h:59:9: error: implicit declaration
of function =E2=80=98atomic64_add_return=E2=80=99; did you mean =E2=80=98at=
omic64_dec_return=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
   59 |  return atomic64_add_return(i, v);
      |         ^~~~~~~~~~~~~~~~~~~
      |         atomic64_dec_return
./include/asm-generic/atomic-long.h: In function =E2=80=98atomic_long_fetch=
_add=E2=80=99:
./include/asm-generic/atomic-long.h:83:9: error: implicit declaration
of function =E2=80=98atomic64_fetch_add=E2=80=99; did you mean =E2=80=98ato=
mic64_fetch_dec=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
   83 |  return atomic64_fetch_add(i, v);
      |         ^~~~~~~~~~~~~~~~~~
      |         atomic64_fetch_dec


$ git bisect log
# bad: [3dbdb38e286903ec220aaf1fb29a8d94297da246] Merge branch
'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start '3dbdb38e2869' 'v5.13' 'mm/'
# bad: [a6eaf3850cb171c328a8b0db6d3c79286a1eba9d] Merge tag
'sched-urgent-2021-06-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad a6eaf3850cb171c328a8b0db6d3c79286a1eba9d
# bad: [31e798fd6f0ff0acdc49c1a358b581730936a09a] Merge tag
'media/v5.14-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 31e798fd6f0ff0acdc49c1a358b581730936a09a
# bad: [9840cfcb97fc8b6aa7b36cec3cc3fd763f14052e] Merge tag
'arm64-upstream' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 9840cfcb97fc8b6aa7b36cec3cc3fd763f14052e
# good: [b89c07dea16137696d0f2d479ef665ef7c1022ab] Merge tags
'objtool-urgent-2021-06-28' and 'objtool-core-2021-06-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good b89c07dea16137696d0f2d479ef665ef7c1022ab
# bad: [8e4d7a78f08a788a839bd88a2710ba7a71a86e24] Merge tag
'x86-cleanups-2021-06-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 8e4d7a78f08a788a839bd88a2710ba7a71a86e24
# good: [adf3c31e18b765ea24eba7b0c1efc076b8ee3d55] sched/doc: Update
the CPU capacity asymmetry bits
git bisect good adf3c31e18b765ea24eba7b0c1efc076b8ee3d55
# bad: [a15286c63d113d4296c58867994cd266a28f5d6d] Merge tag
'locking-core-2021-06-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad a15286c63d113d4296c58867994cd266a28f5d6d
# good: [c7b5fd6faa1dc6cdc721a978d9d122cd31bbd7b1] locking/atomic:
mips: move to ARCH_ATOMIC
git bisect good c7b5fd6faa1dc6cdc721a978d9d122cd31bbd7b1
# bad: [b8e00abe7d9fe21dd13609e2e3a707e38902b105] locking/lockdep:
Reduce LOCKDEP dependency list
git bisect bad b8e00abe7d9fe21dd13609e2e3a707e38902b105
# good: [9efbb355831014ca004d241db8ede182c019b9bf] locking/atomic:
riscv: move to ARCH_ATOMIC
git bisect good 9efbb355831014ca004d241db8ede182c019b9bf

$ git desc b8e00abe7d9fe21dd13609e2e3a707e38902b105
v5.13-rc1-115-gb8e00abe7d9f
$ git desc 9efbb355831014ca004d241db8ede182c019b9bf
v5.13-rc1-108-g9efbb3558310

$ git log --oneline 9efbb3558310..b8e00abe7d9f
b8e00abe7d9f (refs/bisect/bad) locking/lockdep: Reduce LOCKDEP dependency l=
ist
fab6216fafdd locking/lockdep,doc: Improve readability of the block matrix
bccf1ec369ac locking/atomics: atomic-instrumented: simplify ifdeffery
3c1885187bc1 locking/atomic: delete !ARCH_ATOMIC remnants
b9b12978a8e9 (HEAD) locking/atomic: xtensa: move to ARCH_ATOMIC
ff5b4f1ed580 locking/atomic: sparc: move to ARCH_ATOMIC
8c6417551309 locking/atomic: sh: move to ARCH_ATOMIC

so ff5b4f1ed580 does not compile without cherry-picking
bccf1ec369ac... and booting to this kernel (ff5b4f1ed580 +
bccf1ec369ac) introduces stress-ng OOPS (shown above)

Can someone please look at this commit ids?
Thanks!

PS: kernel config
https://github.com/mator/sparc64-dmesg/blob/master/config-5.13.0.gz
