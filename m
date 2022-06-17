Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3428AC433EF
	for <sparclinux@archiver.kernel.org>; Fri, 17 Jun 2022 08:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiFQINh (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 17 Jun 2022 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380688AbiFQINf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 17 Jun 2022 04:13:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2419060A83
        for <sparclinux@vger.kernel.org>; Fri, 17 Jun 2022 01:13:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d14so286161pjs.3
        for <sparclinux@vger.kernel.org>; Fri, 17 Jun 2022 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ajw5ZlW7BO6xh4idYg9ZGUxMVX3OZuSbGQMRvZITss=;
        b=BjmCyWwguCYTpglhYm7P+9sfT2Sf6eI4hqC5TCzRNcj8GpT7Cc5jJvVeFu+/QvdoQO
         RGPpgCZxneDK+JRvBbAA3vU8YL0MLBkdIjsUazKCO2zJ5IT6caqZ177xBPaHYaNtSFhL
         wsOPZyAq8zDsC4+RXY1GMKrYj3Yyu9EDxibHdpAAagnIOLEJ3bJD7JOCrpBNaHhaJdjq
         /4qXmmNFH+/zsDvQ2LPSFYj7Byd34mjZXsxzy6la7Th49HWzuITGgf435hSeF0LnrHen
         fHCXck9cWmkJX/PFv6Ee2nUXQikqy1BawnEmGitan/14y2a4JTmEO8TSXRXXDJrqoj/v
         LdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ajw5ZlW7BO6xh4idYg9ZGUxMVX3OZuSbGQMRvZITss=;
        b=iQrzvlubIzurorXoY3QCaT6/qbRZpQDVu72woztC5PE1NwKqGV6EEMviS7Cu6kqfrW
         2Jnh/QJloBYP097tr3Qc/6vAMq5yR+3cSWbzdshZm+THqoFdj4OQB8axZrUiAH9T8qDm
         IeCdy2+FaoGtyzdNm2HNrGOxe7Z3m10NIXWXXTGIpgU5VysXnIF2OKI5londrlYx2y3u
         R4uHcR9l50bypGjWf4kt1NvRfwuc101gj7CwrV4rnToE6fy1acuiV9VpxDniIPdAnh/i
         89Re3EriEqcf6bXnwY1Tcv3+4DhqY0YsRIby12nMW/msVIbDU0UZWVcOt+4Jv6zO/CG7
         PmeQ==
X-Gm-Message-State: AJIora9ha9/DHWLSx09dvYOFNvMB8WqJvajxmSo/27jU2htwdtHfydNK
        HEmka3Ntu2SqM3Ts7wh4IDJPKg==
X-Google-Smtp-Source: AGRyM1uaJ6D+98lyL0Nb8O2bTi6YMfyv3saLk9hySILdD8r9XB2OdIlAqHZgNeMyStjI4ZdfZ29vcg==
X-Received: by 2002:a17:90b:4a4c:b0:1e4:da3a:9b07 with SMTP id lb12-20020a17090b4a4c00b001e4da3a9b07mr9398372pjb.242.1655453612597;
        Fri, 17 Jun 2022 01:13:32 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0015e8d4eb219sm2932151plk.99.2022.06.17.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:13:31 -0700 (PDT)
Date:   Fri, 17 Jun 2022 16:13:28 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
Message-ID: <Yqw3qHZIwM35rcLh@FVFYT0MHHV2J.usts.net>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616210518.125287-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jun 16, 2022 at 02:05:15PM -0700, Mike Kravetz wrote:
> HugeTLB address ranges are linearly scanned during fork, unmap and
> remap operations.  If a non-present entry is encountered, the code
> currently continues to the next huge page aligned address.  However,
> a non-present entry implies that the page table page for that entry
> is not present.  Therefore, the linear scan can skip to the end of
> range mapped by the page table page.  This can speed operations on
> large sparsely populated hugetlb mappings.
> 
> Create a new routine hugetlb_mask_last_page() that will return an
> address mask.  When the mask is ORed with an address, the result
> will be the address of the last huge page mapped by the associated
> page table page.  Use this mask to update addresses in routines which
> linearly scan hugetlb address ranges when a non-present pte is
> encountered.
> 
> hugetlb_mask_last_page is related to the implementation of
> huge_pte_offset as hugetlb_mask_last_page is called when huge_pte_offset
> returns NULL.  This patch only provides a complete hugetlb_mask_last_page
> implementation when CONFIG_ARCH_WANT_GENERAL_HUGETLB is defined.
> Architectures which provide their own versions of huge_pte_offset can also
> provide their own version of hugetlb_mask_last_page.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

It'll be more efficient, Thanks.

Acked-by: Muchun Song <songmuchun@bytedance.com>

