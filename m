Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32149C38142
	for <sparclinux@archiver.kernel.org>; Tue, 31 Jan 2023 08:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjAaI7f (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAaI7C (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 31 Jan 2023 03:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F304C6CF
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 00:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675155189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJbeBzcV4TWL0jebm/OUMAc1K3T5Nk9LlHTe0trXExM=;
        b=QoKbOBh0u7V5ezcaCsyGNPKi4FH9tFVMDj5cmP3WsGDLNtXyZU8P/L30NVUZEomPPqGH00
        NI2gzQrFd3luAS+RV1o57JgqmwvQhzH0gTVk342WJIjP645Jv2PTllzi2rS1BRd5HFyfKY
        2JfRE1YXkbgDbgBpmif08XYWSZBTwh0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-HrQhK2zyPkCwq5ce4Rfonw-1; Tue, 31 Jan 2023 03:47:05 -0500
X-MC-Unique: HrQhK2zyPkCwq5ce4Rfonw-1
Received: by mail-wr1-f69.google.com with SMTP id y2-20020adfee02000000b002bfb44f286dso2329815wrn.11
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 00:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJbeBzcV4TWL0jebm/OUMAc1K3T5Nk9LlHTe0trXExM=;
        b=UlU/OsGC0+6gwdRdovC2Z/xnCYI2BPvrzMmaiQUc0NnGK1uqai9EmyH2+JhnyKVFoA
         Lj24Rrzv278JhA7e0EZuMxcIOhlUQnPyvLITxJCFe+LotxXyH+3vESKtx7zAWvf6JhGU
         +B7hCh80i/bWMNNanEtjysrItTxHnQWvK7ODUVPA79Jrtxs925zBLSsLQXeHqWwMA2kq
         J4hXM/hxAA5hj+n0sEu6c7ADvgkV5Qj7a2uxgrryi6rVcxpQ3/3QV4YPZSF63zIcFCnl
         9mIIN7D9RQCknJipn8mf+zvztGtZzcn0rURogeYkB8gI7sXg2z5RTc2RH9Ou+KAgK3Uc
         uYsA==
X-Gm-Message-State: AFqh2kqCz8t9jxxXra865nVzuHs1rLLm81s8wKpoGlF5zsoS/SDmnRox
        dsD1u3QsntgJJBObcPmJ4Ri58ZBneE+Hnc19h6xJvFJSCGN2qV4qWNIFh6DfPY6t5CBK8VOGlLf
        rMDZq1aH6vUviUXSulpVNqw==
X-Received: by 2002:a05:600c:5488:b0:3da:1e3e:1ce8 with SMTP id iv8-20020a05600c548800b003da1e3e1ce8mr53630059wmb.13.1675154823546;
        Tue, 31 Jan 2023 00:47:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvh7lQeNQsyIFm/SR9ZDxGOpNWOdkerlKVXtNt1BuLbAz5uHp0GAPBMu/t5psiwCY3rWQKS6A==
X-Received: by 2002:a05:600c:5488:b0:3da:1e3e:1ce8 with SMTP id iv8-20020a05600c548800b003da1e3e1ce8mr53630039wmb.13.1675154823235;
        Tue, 31 Jan 2023 00:47:03 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003dc36981727sm13025688wma.14.2023.01.31.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:47:02 -0800 (PST)
Message-ID: <671d9bbb-0f19-2710-00ef-47734085dddc@redhat.com>
Date:   Tue, 31 Jan 2023 09:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] sparc/mm: don't unconditionally set HW writable bit
 when setting PTE dirty on 64bit
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hev <r@hev.cc>,
        Anatoly Pugachev <matorola@gmail.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
References: <20221212130213.136267-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221212130213.136267-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 12.12.22 14:02, David Hildenbrand wrote:
> On sparc64, there is no HW modified bit, therefore, SW tracks via a SW
> bit if the PTE is dirty via pte_mkdirty(). However, pte_mkdirty()
> currently also unconditionally sets the HW writable bit, which is wrong.
> 
> pte_mkdirty() is not supposed to make a PTE actually writable, unless the
> SW writable bit (pte_write()) indicates that the PTE is not
> write-protected. Fortunately, sparc64 also defines a SW writable bit.
> 
> For example, this already turned into a problem in the context of
> THP splitting as documented in commit 624a2c94f5b7 ("Partly revert "mm/thp:
> carry over dirty bit when thp splits on pmd") and might be an issue during
> page migration in mm/migrate.c:remove_migration_pte() as well where we:
> 	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
> 		pte = pte_mkdirty(pte);
> 
> But more general, anything like:
> 	maybe_mkwrite(pte_mkdirty(pte), vma)
> code is broken on sparc64, because it will unconditionally set the HW
> writable bit even if the SW writable bit is not set.
> 
> Simple reproducer that will result in a writable PTE after ptrace
> access, to highlight the problem and as an easy way to verify if it has
> been fixed:
> 
> --------------------------------------------------------------------------
>   #include <fcntl.h>
>   #include <signal.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
> 
>   static void signal_handler(int sig)
>   {
>           if (sig == SIGSEGV)
>                   printf("[PASS] SIGSEGV generated\n");
>           else
>                   printf("[FAIL] wrong signal generated\n");
>           exit(0);
>   }
> 
>   int main(void)
>   {
>           size_t pagesize = getpagesize();
>           char data = 1;
>           off_t offs;
>           int mem_fd;
>           char *map;
>           int ret;
> 
>           mem_fd = open("/proc/self/mem", O_RDWR);
>           if (mem_fd < 0) {
>                   fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
>                   return 1;
>           }
> 
>           map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1 ,0);
>           if (map == MAP_FAILED) {
>                   fprintf(stderr, "mmap() failed: %d\n", errno);
>                   return 1;
>           }
> 
>           printf("original: %x\n", *map);
> 
>           /* debug access */
>           offs = lseek(mem_fd, (uintptr_t) map, SEEK_SET);
>           ret = write(mem_fd, &data, 1);
>           if (ret != 1) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) failed with %d: %d\n", ret, errno);
>                   return 1;
>           }
>           if (*map != data) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) not visible\n");
>                   return 1;
>           }
> 
>           printf("ptrace: %x\n", *map);
> 
>           /* Install signal handler. */
>           if (signal(SIGSEGV, signal_handler) == SIG_ERR) {
>                   fprintf(stderr, "signal() failed\n");
>                   return 1;
>           }
> 
>           /* Ordinary access. */
>           *map = 2;
> 
>           printf("access: %x\n", *map);
> 
>           printf("[FAIL] SIGSEGV not generated\n");
> 
>           return 0;
>   }
> --------------------------------------------------------------------------
> 
> Without this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	access: 2
> 	[FAIL] SIGSEGV not generated
> 
> Let's fix this by setting the HW writable bit only if both, the SW dirty
> bit and the SW writable bit are set. This matches, for example, how
> s390x handles pte_mkwrite() and pte_mkdirty() -- except, that they have
> to clear the _PAGE_PROTECT bit.
> 
> We have to move pte_dirty() and pte_dirty() up. The code patching
> mechanism and handling constants > 22bit is a bit special on sparc64.
> 
> With this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	[PASS] SIGSEGV generated
> 
> This handling seems to have been in place forever.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Hev <r@hev.cc>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: Raghavendra K T <raghavendra.kt@amd.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Ping

-- 
Thanks,

David / dhildenb

