Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E85C433E0
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD02619C1
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCWRjr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:39:47 -0400
Received: from mout.web.de ([212.227.15.4]:58671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhCWRjo (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 23 Mar 2021 13:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616521177;
        bh=pPF9qSaogFKnLePKcOLqtf+F42lhUfbhc1CPaXMfENI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=huhOVqrdlduBGdYQB7MU638O9M+319cRJdhtM3+f/eA8mcyfuZyO9Byn2jXFW63Ub
         Up+jLtoi1nrgfJd8md5Ys3pC+trFcYpuckz0SMxf4ZsMqAURJoHlF44kK2C7GFovlB
         mNSZbOjNcuQOkn2uBOY4DXdyC6oy8fUxoEEt/oKA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([217.247.37.206]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnS3i-1ls3s71lj4-00haPn; Tue, 23
 Mar 2021 18:39:37 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <4938f0fa-e63f-2a4b-e607-512e06987885@web.de>
Date:   Tue, 23 Mar 2021 18:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323165721.GA14577@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TBpO/pN4vF4G/WbDvHX5uQ0h/8yXdVacVFB0jp9MK8dVOvLxV+d
 vTjhZvJ9MdC4axlwI3hbwIHe2TfB0pSi6b9Y32MVCcc/clKfsspBiLKimLmnmDNN2ccAFVV
 vRehyQzUIrHhXp4yDQEN/oRO7Lx7Ji375dqIaXnQd/WNe5T4Rtwtc11+PVVyYeAZQ4fyURd
 JJUNw8o2IsDRoBXxiBp5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W3M0m/pg2SY=:W7dIpIJdN/k9Cyp+D588fv
 fpME93qyqNa2D1ojwJ7A3mEa62l3DDLK1kJkCSrJObIAmbL2oPXZVwTeftpEMESb+lanyYpZx
 Uwnit0AJc0TUQvFaSz8g3BhjTPnRShX6fidxkfd6wfhgxeE5WNHGDitoaEYreorwbEd4YgNOz
 +aYI5+cLjhjKNfOpCV4X6PUIhn6Hw63lfqz3AWqbAWWdobzJDEubCQNMdS00ig4LoYZ963O5q
 lSgPLgQ+XQ9sbgGrFQlDidHrdha9sz3tdRAuy2aXTUeOoXf0LCk1gGZleKCIl02XhfCxNnxk7
 iK6uyCGQeNAXid6bKx1BmuWfrjG+p3C5yrXLeSkyd1FMsXkkqychp9Ct2vBcweuE6CQ7VYCjv
 kcOP5VpxRRRgHsOj4GuG1L19Mx1VzbT6jgCcDojAMBsh6CRILnhPBsGNfUot3PhdmVurAN+dI
 z19bZWrsbGAWITb9DyhD7zcLzKK9hMMu7fz2iZIeMyQuPsVX0hnbDmAyeJ4xNIeOjqH/X6BAU
 grh5eb331x4M1ogGzcULUzMkCqoWgcaNfHP7XrS0bhoHFUeBJUlCgoBsjXROHMhO2+Mew57b/
 ImeFUu9DK7DnRmWJkWGkYdYMPPsqQQWU0trv5HFDMmKd2uVBWpWcuxg21Iy8Sh8Z22On+y91C
 wCYlQHb/YTOC2fEQISU/kggOi16So1Y8WRXC6gyv0r4blhGTO2Ln3iU+kK+h0y/6mAEyra2rz
 WnDaQUtXgAQx78dlj065KvMHoT6OFsUaWRYWVae82i0BTc7xTFU7RNAYv73MAEyAX1M2zbFm9
 2HlygQb+dN8kuI3MO4VuI2mzxi5zlQvQifxUMIRwhcmdVRG4Pb4xb0zmpiXxqjCkm/pFOrBGP
 D5u9mEVJAkLN/j/0gzow==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 23.03.21 17:57, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 05:50:59PM +0100, Jan Engelhardt wrote:
>> Some participants in the discussion over at the debian-sparc list menti=
oned
>> "NFS" and "Invalid argument", which is something I know just too well f=
rom
>> iptables. NFS is a filesystem that uses an extra data blob (5th argumen=
t to the
>> mount syscall). Such blobs have historically not always been designed t=
o bear
>> the same layout between ILP32 and LP64 modes, and nfs's structs fell pr=
ey to
>> this as well.
>>
>> My hypothesis now is that fs/nfs/fs_context.c line 1160:
>>
>> 	if (in_compat_syscall())
>> 		nfs4_compat_mount_data_conv(data);
>>
>> and ones similar to it (I didn't look too close where nfs3 gets to do i=
ts
>> conversion), no longer trigger as a result of compat_sys_mount being
>> wiped from the syscall table:
>
> No, if in_compat_syscall() syscall doesn't trigger properly the kernel
> would not get this far.
>
> That being said, the NFS compat code was moved out of the compat mount
> handler and into nfs and refactored in the commit just before this one.
>
> Frank, can you double check that commit
> 67e306c6906137020267eb9bbdbc127034da3627 really still works, and
> only 028abd9222df0cf5855dab5014a5ebaf06f90565 broke your setup?

Indeed, I also expected 67e306c6906137020267eb9bbdbc127034da3627 to fail
because of its commit message, but from my log it did work correctly.

As the T1000 is at home and I don't have another T1 based system in my
storage location where I am now, I'll double check that in the evening
and report back.

Strangely for a V245 (with UltraSPARC IIIi) both commits seem to work
according to my testing, but 5.10.x (from Debian) doesn't work and
5.9.15 (also from Debian) does work - tested now both for boot from
network and boot from disk.

Possibly unrelated to the problem with the T1000, the V245 emits the
following for boot from disk with 5.10.x:

```
[...]
Loading Linux 5.10.0-5-sparc64-smp ...
Loading initial ramdisk ...

[    2.602821] rtc_cmos rtc_cmos: IRQ index 0 not found
/dev/sda2: clean, 33516/8454144 files, 1105784/33798750 blocks
[   13.542728] autofs4:pid:1:autofs_fill_super: called with bogus options
[   13.628931] systemd[1]: proc-sys-fs-binfmt_misc.automount: Failed to
initialize automounter: Invalid argument
[   13.759917] systemd[1]: Failed to set up automount Arbitrary
Executable File Formats File System Automount Point.
[FAILED] Failed to set up automount  File System Automount Point.
[   14.456396] Unable to handle kernel paging request in mna handler
[   14.456400]  at virtual address da65f2fed110e482
[   14.597474] current->{active_,}mm->context =3D 00000000000000ce
[   14.597478] current->{active_,}mm->pgd =3D fff0000006d5c000
[   14.752380] Unable to handle kernel paging request in mna handler
[   14.752383]  at virtual address da65f2fed110e482
[   14.893509] current->{active_,}mm->context =3D 0000000000000094
[   14.969141] current->{active_,}mm->pgd =3D fff00011010e0000
[   15.040554] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x00000009
[   15.141430] Press Stop-A (L1-A) from sun keyboard or send break
[   15.141430] twice on console to return to the boot prom
[   15.141459] kernel BUG at kernel/cpu.c:960
```

Cheers,
Frank

