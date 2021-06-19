Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D11C2B9F4
	for <sparclinux@archiver.kernel.org>; Sat, 19 Jun 2021 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE14610A7
	for <sparclinux@archiver.kernel.org>; Sat, 19 Jun 2021 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhFSJdM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 05:33:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFSJdL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 19 Jun 2021 05:33:11 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.210])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1luXJb-0004tL-U4; Sat, 19 Jun 2021 09:30:59 +0000
Subject: Re: [sparc64] kernel panic from running a program in userspace
To:     Anatoly Pugachev <matorola@gmail.com>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        kernel-testers@vger.kernel.org
References: <CADxRZqwzbHvMwEB=y_xi2GYK55wtnzycWcUoK_t4q_ccisp+Sg@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <f9bd5a0e-6f9e-c042-cbfc-2e03bf16b92c@canonical.com>
Date:   Sat, 19 Jun 2021 10:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CADxRZqwzbHvMwEB=y_xi2GYK55wtnzycWcUoK_t4q_ccisp+Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

I suspect this issue was fixed with the following commit:

commit e5e8b80d352ec999d2bba3ea584f541c83f4ca3f
Author: Rob Gardner <rob.gardner@oracle.com>
Date:   Sun Feb 28 22:48:16 2021 -0700

    sparc64: Fix opcode filtering in handling of no fault loads

Colin

On 19/06/2021 09:24, Anatoly Pugachev wrote:
> Hello!
> 
> Getting the following in logs:
> (reproducible with almost every run, tried different kernel as well -
> debian packaged 5.10.0-7-sparc64-smp )
> 
> [  863.344843] stress-ng[593992]: bad register window fault: SP
> 00000000fcd023ff (orig_sp 00000000fcd01c00) TPC fff80001000237fc O7
> fff800010003e008
> [  890.782498] CPU[4]: SUN4V mondo timeout, cpu(5) made no forward
> progress after 500001 retries. Total target cpus(7).
> [  890.782539] CPU[3]: SUN4V mondo timeout, cpu(5) made no forward
> progress after 500001 retries. Total target cpus(7).
> [  890.782590] Kernel panic - not syncing: SUN4V mondo timeout panic
> [  890.782664] CPU: 4 PID: 480951 Comm: stress-ng Tainted: G
>  E     5.13.0-rc6 #229
> [  890.782713] Call Trace:
> [  890.782733] [<0000000000c806c8>] panic+0xf4/0x2d4
> [  890.782773] [<000000000043f3a8>] hypervisor_xcall_deliver+0x288/0x320
> [  890.782816] [<000000000043efb8>] xcall_deliver+0xf8/0x120
> [  890.782860] [<0000000000440518>] smp_flush_tlb_page+0x38/0x60
> [  890.782898] [<000000000044ee44>] flush_tlb_pending+0x64/0xa0
> [  890.782938] [<000000000044f1c4>] arch_leave_lazy_mmu_mode+0x24/0x40
> [  890.782977] [<0000000000651b4c>] copy_pte_range+0x5ac/0x860
> [  890.783013] [<0000000000655974>] copy_pud_range+0x1f4/0x260
> [  890.783049] [<0000000000655b2c>] copy_page_range+0x14c/0x1c0
> [  890.783083] [<00000000004613b4>] dup_mmap+0x374/0x4a0
> [  890.783123] [<0000000000461530>] dup_mm+0x50/0x200
> [  890.783157] [<0000000000462384>] copy_process+0x704/0x1280
> [  890.783196] [<00000000004631a8>] kernel_clone+0x88/0x380
> [  890.783231] [<000000000042d170>] sparc_clone+0xb0/0xe0
> [  890.783274] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [  890.784106] CPU[7]: SUN4V mondo timeout, cpu(5) made no forward
> progress after 500002 retries. Total target cpus(7).
> [  890.784119] CPU[6]: SUN4V mondo timeout, cpu(5) made no forward
> progress after 500003 retries. Total target cpus(7).
> [  890.784876] Press Stop-A (L1-A) from sun keyboard or send break
> [  890.784876] twice on console to return to the boot prom
> [  890.784897] ---[ end Kernel panic - not syncing: SUN4V mondo
> timeout panic ]---
> 
> (and machine halt)
> 
> after running stress-ng :
> 
> stress-ng.git$ ./stress-ng --verbose --timeout 10m --opcode -1
> stress-ng: debug: [480950] stress-ng 0.12.10 g27f90a2276bd
> stress-ng: debug: [480950] system: Linux ttip 5.13.0-rc6 #229 SMP Tue
> Jun 15 12:30:23 MSK 2021 sparc64
> stress-ng: debug: [480950] RAM total: 7.8G, RAM free: 7.0G, swap free: 768.7M
> stress-ng: debug: [480950] 8 processors online, 256 processors configured
> stress-ng: info:  [480950] dispatching hogs: 8 opcode
> stress-ng: debug: [480950] cache allocate: using cache maximum level L2
> stress-ng: debug: [480950] cache allocate: shared cache buffer size: 128K
> stress-ng: debug: [480950] starting stressors
> stress-ng: debug: [480951] stress-ng-opcode: started [480951] (instance 0)
> stress-ng: debug: [480952] stress-ng-opcode: started [480952] (instance 1)
> stress-ng: debug: [480953] stress-ng-opcode: started [480953] (instance 2)
> stress-ng: debug: [480955] stress-ng-opcode: started [480955] (instance 3)
> stress-ng: debug: [480957] stress-ng-opcode: started [480957] (instance 4)
> stress-ng: debug: [480959] stress-ng-opcode: started [480959] (instance 5)
> stress-ng: debug: [480961] stress-ng-opcode: started [480961] (instance 6)
> stress-ng: debug: [480950] 8 stressors started
> stress-ng: debug: [480963] stress-ng-opcode: started [480963] (instance 7)
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> Inconsistency detected by ld.so: dl-runtime.c: 80: _dl_fixup:
> Assertion `ELFW(R_TYPE)(reloc->r_info) == ELF_MACHINE_JMP_SLOT'
> failed!
> *** stack smashing detected ***: terminated
> munmap_chunk(): invalid pointer
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> *** stack smashing detected ***: terminated
> Inconsistency detected by ld.so: : 422: Assertion `�' failed!
> *** stack smashing detected ***: terminated
> 
> 
> Machine is my testing LDOM (virtual machine), installed and running
> the latest sparc4 debian sid (unstable).
> 

