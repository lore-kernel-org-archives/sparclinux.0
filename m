Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB123C77B70
	for <sparclinux@archiver.kernel.org>; Tue, 11 Apr 2023 14:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDKOUU (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 11 Apr 2023 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjDKOUH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 11 Apr 2023 10:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2312A
        for <sparclinux@vger.kernel.org>; Tue, 11 Apr 2023 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAltGiW0DBDAeNvmuGpEYB8uc7AKLZpAtOjrnOVCND0=;
        b=U6l53ih84Dvkj/sm1paqNwL0r4dDBjC1j4G3cm1cPp82BtN1Agh9r06AW6gVt8FXjuc9Ub
        CMTUmEH0qUP5/iCmeNDWee+ju67swtxbT0ima1dzhCaUKx2enDw/GOizyPGV4Ss2CcyT6G
        PNarD+J75VPvIxpH1l2ubUSxm2tYfnQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-C2-4uelANBy92GryT8f2tw-1; Tue, 11 Apr 2023 10:19:00 -0400
X-MC-Unique: C2-4uelANBy92GryT8f2tw-1
Received: by mail-wr1-f71.google.com with SMTP id o26-20020adfa11a000000b002dd3986083bso1195312wro.12
        for <sparclinux@vger.kernel.org>; Tue, 11 Apr 2023 07:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222739; x=1683814739;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAltGiW0DBDAeNvmuGpEYB8uc7AKLZpAtOjrnOVCND0=;
        b=woyy5TB1q/LTadgd9g4zIGIZesXBKJwJgiWDeTcu0iGuQFQKKxdH4qx9FTZpwGvgBh
         aXd7S68QuVIK0u4oDFh6mRewD0IJBfe7dpjyfCuWu26l1PHL/JIiIzLBdSLK1wiZD9yZ
         v08kGuR0xCObhgoknkl/I/YSRau6vqQNdrR6oMrVdWJaKC022Lf0Hi9DdTapo8VbjygN
         Z7JbD9bMSy/2vdcZowX45ZHMtWykrHmk22YTvN+dXshB7mczXslNU78adzkCpbdAewhf
         iTRYyde1DPAxwVcNtIqcDfuvDmGk/r+wfJA2S+R5nuMczHdMtMIh10v1khaVrgWyV9Co
         TxWg==
X-Gm-Message-State: AAQBX9d3xGkIw2ecrUsYryKXILCoZY7KOC/4ECC0SbWtYU2k8yuqEunH
        LGu7UV9ST3TJf3LJzzcoFc4DO02GpnCd4nuO9yzCI1wg1rZlX0IvsCdN3gI5VSnmnN8T4iHHK9H
        R1SMZ018Uker7oKROMXCsmw==
X-Received: by 2002:a5d:470d:0:b0:2d7:4c98:78fe with SMTP id y13-20020a5d470d000000b002d74c9878femr8621097wrq.34.1681222738937;
        Tue, 11 Apr 2023 07:18:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350bY0p0lov10ncoRRjudSkgQbnGcBkbDWJtshXja6yULgw6jQWdjzluLhiX0b55T0sA76SToJg==
X-Received: by 2002:a5d:470d:0:b0:2d7:4c98:78fe with SMTP id y13-20020a5d470d000000b002d74c9878femr8621084wrq.34.1681222738612;
        Tue, 11 Apr 2023 07:18:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1300:6f08:1748:eba7:b2a9? (p200300cbc70613006f081748eba7b2a9.dip0.t-ipconnect.de. [2003:cb:c706:1300:6f08:1748:eba7:b2a9])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d51c4000000b002efb55de21dsm10542399wrv.103.2023.04.11.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 07:18:58 -0700 (PDT)
Message-ID: <81a2070a-f7aa-2185-8211-26b57815e968@redhat.com>
Date:   Tue, 11 Apr 2023 16:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/huge_memory: conditionally call maybe_mkwrite() and
 drop pte_wrprotect() in __split_huge_pmd_locked()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20230411141529.428991-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230411141529.428991-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 11.04.23 16:15, David Hildenbrand wrote:
> No need to call maybe_mkwrite() to then wrprotect if the source PMD was not
> writable.
> 
> It's worth nothing that this now allows for PTEs to be writable even if
> the source PMD was not writable: if vma->vm_page_prot includes write
> permissions.
> 
> As documented in commit 931298e103c2 ("mm/userfaultfd: rely on
> vma->vm_page_prot in uffd_wp_range()"), any mechanism that intends to
> have pages wrprotected (COW, writenotify, mprotect, uffd-wp, softdirty,
> ...) has to properly adjust vma->vm_page_prot upfront, to not include
> write permissions. If vma->vm_page_prot includes write permissions, the
> PTE/PMD can be writable as default.
> 
> This now mimics the handling in mm/migrate.c:remove_migration_pte() and in
> mm/huge_memory.c:remove_migration_pmd(), which has been in place for a
> long time (except that 96a9c287e25d ("mm/migrate: fix wrongly apply write
> bit after mkdirty on sparc64") temporarily changed it).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Ignore this one, it's a duplicate of 6/6 and I forgot to delete that 
patch before triggering git send-email ...

-- 
Thanks,

David / dhildenb

