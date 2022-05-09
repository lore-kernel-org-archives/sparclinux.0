Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E603C433F5
	for <sparclinux@archiver.kernel.org>; Mon,  9 May 2022 06:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiEIG5L (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 9 May 2022 02:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiEIGqQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 9 May 2022 02:46:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FF1230E0
        for <sparclinux@vger.kernel.org>; Sun,  8 May 2022 23:42:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 204so8653551pfx.3
        for <sparclinux@vger.kernel.org>; Sun, 08 May 2022 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwBbyH87QLuFybJCJK1L3o2HCzGQtzlhndyFtKBo1+M=;
        b=YUWb9VnH9CLdCOFSCg0EgRuHaol/guxgUnIE24J/u98QZ3I3dvqShcw6bHn8PbLn33
         De91e3fLiUGBZs3puXjUkFqnGkfsceO/2eweNFJzxUeEtvloQSE+QJUqsSR4B/n5rCXn
         fOwQjXfTmiY/r6o87bGR+3OcaUM524WjnTrpTYj/0PlXxJLh/+Gh7NH9mmwLwHUNU7RV
         798mKiROjo4EcdLxdwMlUkdsZDYVb3TJer8JHISDq/bQz+F1seNMMayMZJHD4rOjmga0
         GVFw2YGdi2fk3IJL1R+yM+i5a8XRpkgqS57S/UyObr/jP4lzVJidIkm4bfeiGNsDsFN7
         rlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwBbyH87QLuFybJCJK1L3o2HCzGQtzlhndyFtKBo1+M=;
        b=yjL5vP+ot5SFEv+PuLp8fyqQbGPGJNrMnXl7nLwr8BnEuCB66WjEtFArwKBVVat96z
         rYkc+YUzq4deiYrK4MbUNoeHIWpdLSIe4v0RCsJMgJaWBsflJ1TZQ2dgpINIAEY3wHbq
         0pbFhQ24MghkVd446MJR5YPMGFAMbeI28wIMz9OfCa9zGzDjpCAqJaP165SEG50gbOch
         +dsjyN3Mjiw26+oIh8kYfU+3wds21znsskGC7wrJCIrT/QFIAxfhsHiwP72iv9pILlcg
         HHewYzIomgwXQ2VESxjTK+7YHOw/zJ5/YnvldkRCuj7BuRZMmYnLX4j7pDCuwC7jdqMu
         nuHw==
X-Gm-Message-State: AOAM532fR5H6jOpXp01lWF8Il0I2K1/9d7AjEcVGTQGJTX+ahRW/cVz7
        6Lu/GjZdhERuAFmPnNlfgKqJiA==
X-Google-Smtp-Source: ABdhPJzri2xI4eu2ZTD8cGUcHrOUq+LTIb9Xrei/K8/ULY+fOTzB8m7m6qoWPFqlzvQXcDaMYRtrhA==
X-Received: by 2002:a63:6987:0:b0:3c6:c3ce:5097 with SMTP id e129-20020a636987000000b003c6c3ce5097mr2699720pgc.293.1652078540543;
        Sun, 08 May 2022 23:42:20 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b0015e8d4eb21bsm6178989plh.101.2022.05.08.23.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:42:20 -0700 (PDT)
Date:   Mon, 9 May 2022 14:42:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue
 when unmapping
Message-ID: <Yni3yTLblEF5aJw5@FVFYT0MHHV2J.usts.net>
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <43b11b69e9f0d9d7e7960b86661db27cc404d0c7.1652002221.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b11b69e9f0d9d7e7960b86661db27cc404d0c7.1652002221.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, May 08, 2022 at 05:36:41PM +0800, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When unmapping a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it. This is correct
> for PMD or PUD size hugetlb, since they always contain only one
> pmd entry or pud entry in the page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes, so we will nuke only one pte or pmd
> entry for this CONT-PTE/PMD size hugetlb page.
> 
> And now try_to_unmap() is only passed a hugetlb page in the case
> where the hugetlb page is poisoned. Which means now we will unmap
> only one pte entry for a CONT-PTE or CONT-PMD size poisoned hugetlb
> page, and we can still access other subpages of a CONT-PTE or CONT-PMD
> size poisoned hugetlb page, which will cause serious issues possibly.
> 
> So we should change to use huge_ptep_clear_flush() to nuke the
> hugetlb page table to fix this issue, which already considered
> CONT-PTE and CONT-PMD size hugetlb.
> 
> We've already used set_huge_swap_pte_at() to set a poisoned
> swap entry for a poisoned hugetlb page. Meanwhile adding a VM_BUG_ON()
> to make sure the passed hugetlb page is poisoned in try_to_unmap().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
