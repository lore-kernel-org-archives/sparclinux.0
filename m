Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF5C433B4
	for <sparclinux@archiver.kernel.org>; Sat,  8 May 2021 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71C0613C0
	for <sparclinux@archiver.kernel.org>; Sat,  8 May 2021 08:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhEHIHO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 8 May 2021 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIHO (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 8 May 2021 04:07:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EEC061574
        for <sparclinux@vger.kernel.org>; Sat,  8 May 2021 01:06:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 82so14962378yby.7
        for <sparclinux@vger.kernel.org>; Sat, 08 May 2021 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6A5tSBw2lQ9VwV8ravEhSr3GGgI8pYktJsKtsL6zJGE=;
        b=HYXfLP87c2WSUZTILIsC53Gh40kJE6xScpSjQYxnnQEw4qJEz1p56IZ6iu9jhy1dta
         g9PPcBu+yjkeHqolAb1rZMRBtmGVd889h4u+ZTcmDjws4urFvdAI5bX2LE9ICz/uhcfE
         av1dpjEfcUt/cOXju8JmcdGGBsGUOiquSIhZirQf8flf9fwDO3msQZsvletQWiibUkyb
         QIwLCnq8+26OXsbSBTYykGWOFYKqqllKLfPZqIi0q1cSxzMTteyKA9l3F5XC0uj/2eTR
         mKDP6mbl/cUd7Dd/mdnIYzuT+/5xgWkq22W7tdpCcjtZcZ7RbjPlYx4iyYDlIO/d/YAP
         jOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6A5tSBw2lQ9VwV8ravEhSr3GGgI8pYktJsKtsL6zJGE=;
        b=KvMtf3NwfT7wN2E1j+kTy7Qy/HAAiFs6xSwYvBzpS4RPtDmtMJJWUFdlQ/SlKdfi48
         Q7RNMzXUNrEhkvQ30o5LJlOMyJglXI63ATYnHoJLCluiQFuR8t7wLMO/XttTL+SE6flf
         RRQh7hE+cwM47S0QwGfVYI9lURCryBqr+WWKqXoDayatmcvHCl9GMdnya7oSikXKp8t1
         zp1E45oJ5RX9eHBri2dKcp2oyA/OkweblIcH0U5GTpQTT55d2dkZj84tl01oHcRCwRYu
         UVrYwOpbH2Uf7ahdLB/4lCgCpI3mdoYTZFkjanEq7HGTeVct9Saj+lF2aBaqpBmx68Vf
         OkIw==
X-Gm-Message-State: AOAM5321SNsSJZK5nLzBsC1t0RbE5pQyHH00XYU34J6EHMZ7boYiIbWl
        mxO13wgw6cq+GZC/DGi7LX0GbzC0MM+S8K0aSR2D2KeEe6k=
X-Google-Smtp-Source: ABdhPJwmx5yn9SWtsevKXg9la3/CAxgZb+W3bYsRsVC5D1cVjw5cDzXuCJrfNis04/MIq4xnb0TrcM71zlfNdIzYswI=
X-Received: by 2002:a25:641:: with SMTP id 62mr19080690ybg.101.1620461171508;
 Sat, 08 May 2021 01:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <520.1620350498@sss.pgh.pa.us> <CADxRZqyzbEo6kiC_DD6y9sFOtVJ4z8Ss+raccv8sy-XXdjzQHw@mail.gmail.com>
 <33336.1620396305@sss.pgh.pa.us> <34248.1620397342@sss.pgh.pa.us> <43932.1620408571@sss.pgh.pa.us>
In-Reply-To: <43932.1620408571@sss.pgh.pa.us>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 8 May 2021 11:06:00 +0300
Message-ID: <CADxRZqxiQxUjs8g25i3FmxA3dRJ0dbaennUfLghovumpA0J7SA@mail.gmail.com>
Subject: Re: [cfarm-admins] gcc202 is occasionally returning EIO from fdatasync(2)
To:     Tom Lane <tgl@sss.pgh.pa.us>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     GCC Compile Farm administrators 
        <cfarm-admins@lists.tetaneutral.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        strace development discussions <strace-devel@lists.strace.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

So, I took a retrospective view on logs from my running ldoms...

Summary:
- it does not tied to specific filesystem, as gcc202 /home was ext4
earlier and currently live on xfs (migrated recently)
- strace test suite (futex in logs) seems a good candidate to try to
catch the issue with sunvdc
- it does not tied to specific LDOM configuration, some ldoms live on
raw zfs volumes (gcc202), some ldoms have its disk devices living in a
files on zfs  filesystem (ttip, buildd)

I'm still going to make tests/checks with xfstests, strace and
stress-ng trying to catch the issue.

Detailed logs:

deimos == management / control LDOM
cfgcc == gcc202
ttip == my test sparc64 ldom

sysadmin@deimos:/var/log/vntsd/cfgcc$ grep -c blk_update *
console-log:8
console-log.0:20
console-log.1:13
console-log.2:1
console-log.3:0
console-log.4:1
console-log.5:1
sysadmin@deimos:/var/log/vntsd/cfgcc$ ls -l
total 70103
-rw-r-----   1 root     root       90002 May  7 23:05 console-log
-rw-r-----   1 root     root      185171 May  3 19:26 console-log.0
-rw-r-----   1 root     root     28291781 Apr  3 23:19 console-log.1
-rw-r-----   1 root     root     4157903 Mar  4 23:03 console-log.2
-rw-r-----   1 root     root      605083 Jan 29 20:51 console-log.3
-rw-r-----   1 root     root      522874 Dec 30 22:40 console-log.4
-rw-r-----   1 root     root     1641315 Dec  4 23:09 console-log.5

from console-log.5:
[    0.000056] Linux version 5.9.0-3-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.0-17) 10.2.0,
GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian 5.9.9-1
(2020-11-19)
[101790.136672] sunvdc: vdc_tx_trigger() failure, err=-11
[101790.136746] blk_update_request: I/O error, dev vdiska, sector
2174003304 op 0x1:(WRITE) flags 0x107000 phys_seg 18 prio class 0
[101790.136764] Buffer I/O error on dev dm-0, logical block 268449293,
lost async page write
[101790.136786] Buffer I/O error on dev dm-0, logical block 268449294,
lost async page write
[101790.136796] Buffer I/O error on dev dm-0, logical block 268449295,
lost async page write
[101790.136806] Buffer I/O error on dev dm-0, logical block 268449296,
lost async page write
[101790.136816] Buffer I/O error on dev dm-0, logical block 268449297,
lost async page write
[101790.136826] Buffer I/O error on dev dm-0, logical block 268449298,
lost async page write
[101790.136835] Buffer I/O error on dev dm-0, logical block 268449299,
lost async page write
[101790.136845] Buffer I/O error on dev dm-0, logical block 268449300,
lost async page write
[101790.136854] Buffer I/O error on dev dm-0, logical block 268449301,
lost async page write
[101790.136864] Buffer I/O error on dev dm-0, logical block 268449302,
lost async page write
[101790.136917] EXT4-fs error (device dm-0):
ext4_check_bdev_write_error:215: comm systemd-journal: Error while
async write back metadata
[101790.200384] Aborting journal on device dm-0-8.
[101790.257119] EXT4-fs (dm-0): Remounting filesystem read-only
[101790.257142] EXT4-fs error (device dm-0) in
ext4_reserve_inode_write:5667: Journal has aborted
[101790.257240] EXT4-fs error (device dm-0):
ext4_journal_check_start:83: Detected aborted journal
[101790.259239] EXT4-fs error (device dm-0):
ext4_journal_check_start:83: Detected aborted journal
[101790.287445] EXT4-fs error (device dm-0): ext4_dirty_inode:5869:
inode #8782187: comm systemd-journal: mark_inode_dirty error

from console-log.4:
[    0.000057] Linux version 5.9.0-4-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.0-19) 10.2.0,
GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian 5.9.11-1
(2020-11-27)
[493284.878035] futex_wake_op: futex tries to shift op by -518; fix this program
[493287.765631] sunvdc: vdc_tx_trigger() failure, err=-11
[493287.765704] blk_update_request: I/O error, dev vdiska, sector
1049830096 op 0x1:(WRITE) flags 0x3000 phys_seg 2 prio class 0
[493287.765736] Buffer I/O error on dev dm-0, logical block 127927642,
lost async page write
[493287.765760] Buffer I/O error on dev dm-0, logical block 127927643,
lost async page write
[493287.765787] EXT4-fs error (device dm-0):
ext4_check_bdev_write_error:215: comm strace: Error while async write
back metadata
[493289.006197] Aborting journal on device dm-0-8.
[493289.006244] EXT4-fs error (device dm-0) in ext4_evict_inode:249:
Journal has aborted
[493289.006248] EXT4-fs error (device dm-0) in ext4_evict_inode:249:
Journal has aborted
[493289.222338] EXT4-fs error (device dm-0):
ext4_journal_check_start:83: Detected aborted journal
[493289.222409] EXT4-fs (dm-0): Remounting filesystem read-only

from console-log.2:
[    0.000060] Linux version 5.10.0-3-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian
5.10.13-1 (2021-02-06)
[220118.794680] sunvdc: vdc_tx_trigger() failure, err=-11
[220118.794744] blk_update_request: I/O error, dev vdiskc, sector
789205200 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio class 0

from console-log.1:
[    0.000061] Linux version 5.10.0-4-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
5.10.19-1+sparc64 (2021-03-07)
[395369.003918] futex_wake_op: futex tries to shift op by -518; fix this program
[505723.531540] sunvdc: vdc_tx_trigger() failure, err=-11
[505723.531613] blk_update_request: I/O error, dev vdiskc, sector
1833122064 op 0x1:(WRITE) flags 0x1000 phys_seg 1 prio class 0
[505723.547017] sunvdc: vdc_tx_trigger() failure, err=-11
[505723.547068] blk_update_request: I/O error, dev vdiskc, sector
1833239920 op 0x1:(WRITE) flags 0x1000 phys_seg 1 prio class 0
[505723.562462] sunvdc: vdc_tx_trigger() failure, err=-11
[505723.562513] blk_update_request: I/O error, dev vdiskc, sector
1833284832 op 0x1:(WRITE) flags 0x1000 phys_seg 1 prio class 0
[505723.567732] XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x6d433110 len 8 error 5
[564991.789167] futex_atomic_op_inuser: 2 callbacks suppressed
[564991.789176] futex_wake_op: futex tries to shift op by -849; fix this program

[    0.000061] Linux version 5.10.0-4-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
5.10.19-1+sparc64 (2021-03-07)
[606538.865338] sunvdc: vdc_tx_trigger() failure, err=-11
[606538.865412] blk_update_request: I/O error, dev vdiskc, sector
1760253248 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio class 0
[606538.869736] XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x68eb4d40 len 32 error 5
[728702.059059] sunvdc: vdc_tx_trigger() failure, err=-11
[728702.059131] blk_update_request: I/O error, dev vdiskc, sector
1137021984 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio class 0
[728702.215048] dm-0: writeback error on inode 1157860231, offset 0,
sector 1136988968

[    0.000061] Linux version 5.10.0-4-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
5.10.19-1+sparc64 (2021-03-07)
[1605065.277545] futex_wake_op: futex tries to shift op by -518; fix
this program
[1605090.203207] sunvdc: vdc_tx_trigger() failure, err=-11
[1605090.203295] blk_update_request: I/O error, dev vdiskc, sector
1087405072 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio class 0
[1605090.219790] sunvdc: vdc_tx_trigger() failure, err=-11
[1605090.219871] blk_update_request: I/O error, dev vdiskc, sector
1087405328 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio class 0
[1605090.235954] sunvdc: vdc_tx_trigger() failure, err=-11
[1605090.236016] blk_update_request: I/O error, dev vdiskc, sector
1074363797 op 0x1:(WRITE) flags 0x9800 phys_seg 4 prio class 0
[1605090.236059] XFS (dm-0): log I/O error -5
[1605090.236086] XFS (dm-0): xfs_do_force_shutdown(0x2) called from
line 1196 of file fs/xfs/xfs_log.c. Return address = 0000000076933e51
[1605090.236097] XFS (dm-0): Log I/O Error Detected. Shutting down filesystem
[1605090.236106] XFS (dm-0): Please unmount the filesystem and rectify
the problem(s)
[1605090.609638] dm-0: writeback error on inode 547115109, offset 0,
sector 547205784
[1605090.609657] dm-0: writeback error on inode 35621093, offset 0,
sector 35703240
[1605090.609707] dm-0: writeback error on inode 1085975733, offset 0,
sector 1085987480
[1605090.628900] dm-0: writeback error on inode 575365206, offset 0,
sector 575365272
[1605090.628952] dm-0: writeback error on inode 547115099, offset 0,
sector 547144576
[1605090.628977] dm-0: writeback error on inode 35621096, offset 0,
sector 35621672
[1605090.629000] dm-0: writeback error on inode 547115112, offset 0,
sector 547144600
[1605090.629038] dm-0: writeback error on inode 1085975738, offset 0,
sector 1085975808


[567060.440416] futex_wake_op: futex tries to shift op by -518; fix this program
[606538.865338] sunvdc: vdc_tx_trigger() failure, err=-11
[606538.865412] blk_update_request: I/O error, dev vdiskc, sector
1760253248 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio class 0
[606538.869736] XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x68eb4d40 len 32 error 5
[728702.059059] sunvdc: vdc_tx_trigger() failure, err=-11
[728702.059131] blk_update_request: I/O error, dev vdiskc, sector
1137021984 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio class 0
[728702.215048] dm-0: writeback error on inode 1157860231, offset 0,
sector 1136988968

[    0.000061] Linux version 5.10.0-4-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
5.10.19-1+sparc64 (2021-03-07)
[52078.670379] process 'fixes_3_2/fpcsrc/packages/fpmake' started with
executable stack
[84700.481814] sunvdc: vdc_tx_trigger() failure, err=-11
[84700.481875] blk_update_request: I/O error, dev vdiskc, sector
1726087232 op 0x1:(WRITE) flags 0x800 phys_seg 9 prio class 0
[84700.674742] dm-0: writeback error on inode 1727211665, offset 0,
sector 1726052552



from console-log:

[3086382.281890] futex_wake_op: futex tries to shift op by -518; fix
this program
[3141976.195280] sunvdc: vdc_tx_trigger() failure, err=-11
[3141976.195444] blk_update_request: I/O error, dev vdiskc, sector
63150848 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio class 0
[3141976.377290] dm-0: writeback error on inode 32556699, offset 0,
sector 63117832
[3151124.220995] futex_atomic_op_inuser: 14 callbacks suppressed
[3151124.221001] futex_wake_op: futex tries to shift op by -849; fix
this program
...
[3151605.377426] futex_wake_op: futex tries to shift op by -518; fix
this program
[3253624.278367] sunvdc: vdc_tx_trigger() failure, err=-11
[3253624.278443] blk_update_request: I/O error, dev vdiskc, sector
159273120 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio class 0
[3253624.371989] dm-0: writeback error on inode 2148294407, offset 0,
sector 159239256
[3253918.135035] sunvdc: vdc_tx_trigger() failure, err=-11
[3253918.135105] blk_update_request: I/O error, dev vdiskc, sector
157618896 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio class 0
[3253918.226523] dm-0: writeback error on inode 155142134, offset 0,
sector 157584576
[3254125.590955] sunvdc: vdc_tx_trigger() failure, err=-11
[3254125.591023] blk_update_request: I/O error, dev vdiskc, sector
657284672 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio class 0
[3254125.606031] XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x272d5640 len 32 error 5


May 07 03:26:45 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:26:45 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 159273120 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio
class 0
May 07 03:31:39 gcc202 kernel: dm-0: writeback error on inode
2148294407, offset 0, sector 159239256
May 07 03:31:39 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:31:39 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 157618896 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio
class 0
May 07 03:35:06 gcc202 kernel: dm-0: writeback error on inode
155142134, offset 0, sector 157584576
May 07 03:35:06 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:35:06 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 657284672 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio
class 0
May 07 03:35:06 gcc202 kernel: XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x272d5640 len 32 error 5


[    0.000060] Linux version 5.10.0-6-sparc64-smp
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
5.10.28-1 (2021-04-09)
May 07 11:21:40 gcc202 kernel: xfs filesystem being mounted at /home
supports timestamps until 2038 (0x7fffffff)
May 07 21:50:54 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 21:50:54 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 1764819232 op 0x1:(WRITE) flags 0x1000 phys_seg 2 prio
class 0
May 07 21:50:54 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 21:50:54 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 1764819328 op 0x1:(WRITE) flags 0x1000 phys_seg 8 prio
class 0
May 07 21:50:54 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 21:50:54 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 1764821440 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio
class 0
May 07 21:50:54 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 21:50:54 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 1764824576 op 0x1:(WRITE) flags 0x1000 phys_seg 2 prio
class 0
May 07 21:50:54 gcc202 kernel: XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x6930f920 len 32 error 5



from another LDOM :
[    0.000070] Linux version 5.12.0-rc3 (mator@ttip) (gcc (Debian
10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
#199 SMP Mon Mar 15 13:04:24 MSK 2021
[ 6008.263499] run fstests generic/323 at 2021-03-20 19:58:13
[ 6008.874269] XFS (vdiskb1): Mounting V5 Filesystem
[ 6008.886915] XFS (vdiskb1): Ending clean mount
[ 6008.888990] xfs filesystem being mounted at /1/testvol supports
timestamps until 2038 (0x7fffffff)
[ 6112.836409] sunvdc: vdc_tx_trigger() failure, err=-11
[ 6112.836548] blk_update_request: I/O error, dev vdiskb, sector
1097992 op 0x0:(READ) flags 0x0 phys_seg 8 prio class 0

and I was unable to reproduce to reproduce it with simply run
"xfstests-dev$./check generic/323"

and there's quite occasional almost same blk_update errors on another
ldom (buildd - debian sid build)
