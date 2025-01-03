Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A01953A1
	for <sparclinux@vger.kernel.org>; Fri,  3 Jan 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735876124; cv=none; b=SQQeZura2sw1mfN4mtN2WKbF0bDSkRa7hu5ogE6BFL87H4gE3Fa+fkHDbwmzn41SeDOVVG+FfPL9lY8xsPQFHokK3Sem0n3z6N7mfepiV1cZFyGPzMyxlPyQV8BMIBCnhYGj5p0jxjvOYKywriYwcJosQb2+mdaxJHhZ0hr1CBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735876124; c=relaxed/simple;
	bh=Bhm/n4AgpCK2GE6eCOv2daSJvCctEVk7oKmYQJfrxjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiS6W1OJT+t8n6pZ7x+a6ucIKD6XHFhuATHPVIhNSF0u8hIU10XV6ABOS7GIaPaj42dAev2b+fLb/LNSgEZ42pVFsNvW5cv6N1VK51eAcVzK1OPxkb9ON4nsxip4lkIWs3dTWEDjN0u5ndibks40HL9/1MkE7lTyeaPvX8VhlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jzvDCb9+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jzvDCb9+"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee74291415so13415293a91.3
        for <sparclinux@vger.kernel.org>; Thu, 02 Jan 2025 19:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735876122; x=1736480922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBhK1CXUGm9csX2RzVpIIXFvov7I6iYRPJ+9MZcmeVs=;
        b=jzvDCb9+gD2bnnSG+wfujkToQA8xtXuYnBVb6YhHpRT0zdb3jbSYXVybLJvcetsQ3M
         5BJ4D6Q42t226U1Xfc9uAseXxOEtrlXFljfnibbDIwbG/NHLEyRWi1cDS/WrSp89Ejea
         A1zEGRSHpYZQTCN/462NA3/n1zz7wIWlY0NMDZDQQaBwGBv9SUe6cuBplgt6+hpEkbHX
         UOfE8KysU/9OWO30Pojy9xX7t0UEwhlomaXm5Ou3bd9ttk40Yca9aGaKtjzgQ8ikVB/p
         hccjUwGDNej8AGhrnkwFyRgV5NBXjt6H1r5MmV0Fwke6WjvFxml/9GJHTahldVCQwnkz
         DfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876122; x=1736480922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBhK1CXUGm9csX2RzVpIIXFvov7I6iYRPJ+9MZcmeVs=;
        b=afLLsAmP6qNVwAeqyK0N2IS1hXstQzfqWAwezfpohEf/VPwUEewnnJa+NskZL8f7sw
         VHMuQqSaTDOBk18jsVDAHHS09fa5YULvjXk/KOp/s/zXNrqp0JghtBJ5r8HhEBwYb/1I
         lKC4WLBpqDdi+EISO2zQRw80Iopa3FmRljTV4S0bdkIZ17ZN5hvETqYEqn439C5x4pG7
         4zBMkvd0Dsoyd20fjCJRkTYmyn8xz+8txFQ/PL+GvNWkCI3+5KahArTckQx3QOCMO+d0
         gr1SsaNMrxu5Y5d8PvcyaDmJvq2umE/Qsg3RVaL9+9c8d6T/kdo0UMZKurJ8OJZBl17H
         rIKw==
X-Forwarded-Encrypted: i=1; AJvYcCVnNnZr1Ja5nfmuUVh6ypV7sovQ8gQbTIT2R0GsbGYIpYMjxo0mVezuXRWIFAB75hYauj6mWUHJSXZ8@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTWOkQ7IDBSYAjGoTPUnyx8ZHeh4lBKSC73LgBnJ27TJwaBvR
	0lY5RPjsNXSdTAqRKrLrCScvc6eb5TYutvCcxv6c6RF20T/XTdUjZ09TMxwsV6o=
X-Gm-Gg: ASbGncus38AEZvjdZt6W5qLMxLJpyqSk2w8/jdqfoNEa+zmqdUElWDBw5OvFk0K+nNs
	7EKpCLJ2rb4O22n8EjQT97gePByoL5eJjLEmw2KNN9XxfDOFw03/SmjBK9iZi2/6gLHZN51ioPI
	TxVt7mIynKN562Z3Bd0EwwIJCinsg1+lOzm/FMYTPY1BJWYyJ9wVH8S9Qn7XCUDPd63Wr8UcWeZ
	HoKVwMz3RBGd83Twcs8bYTvGm0p6w9pjqQQwSdoWBWzSZwyICHJCCPlKssUYpT0AlZIr2SKqWY0
	FBsz5w==
X-Google-Smtp-Source: AGHT+IGYgpZrnqPiPCHLxVCKQrrsZq8D5LYrHf09cYbjj5EwfNYfddJqRahKvm2mW4f56s0g/0EfTw==
X-Received: by 2002:a05:6a00:2449:b0:728:e906:e45a with SMTP id d2e1a72fcca58-72abdecdbfdmr70684623b3a.24.1735876121963;
        Thu, 02 Jan 2025 19:48:41 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb50sm25233750b3a.90.2025.01.02.19.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:48:41 -0800 (PST)
Message-ID: <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
Date: Fri, 3 Jan 2025 11:48:27 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 2025/1/3 00:53, Kevin Brodsky wrote:
> On 30/12/2024 10:07, Qi Zheng wrote:
>>   static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>>   {
>> -	if (riscv_use_sbi_for_rfence())
>> +	if (riscv_use_sbi_for_rfence()) {
>>   		tlb_remove_ptdesc(tlb, pt);
>> -	else
>> +	} else {
>> +		pagetable_dtor(pt);
>>   		tlb_remove_page_ptdesc(tlb, pt);
> 
> I find the imbalance pretty confusing: pagetable_dtor() is called
> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
> Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
> to ensure that the dtor is always called just before freeing, and remove

In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
and call pagetable_dtor() to dtor the page table pages.
But __tlb_batch_free_encoded_pages() is also used to free normal pages
(not page table pages), so I don't want to add overhead there.

But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
this:

diff --git a/arch/csky/include/asm/pgalloc.h 
b/arch/csky/include/asm/pgalloc.h
index f1ce5b7b28f22..e45c7e91dcbf9 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)

  #define __pte_free_tlb(tlb, pte, address)              \
  do {                                                   \
-       pagetable_dtor(page_ptdesc(pte));               \
         tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
  } while (0)

diff --git a/arch/hexagon/include/asm/pgalloc.h 
b/arch/hexagon/include/asm/pgalloc.h
index 40e42a0e71673..9903449f45cff 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -89,7 +89,6 @@ static inline void pmd_populate_kernel(struct 
mm_struct *mm, pmd_t *pmd,

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor((page_ptdesc(pte)));                     \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/loongarch/include/asm/pgalloc.h 
b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..de5b3f5c85d1c 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -57,7 +57,6 @@ static inline pte_t *pte_alloc_one_kernel(struct 
mm_struct *mm)

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/m68k/include/asm/sun3_pgalloc.h 
b/arch/m68k/include/asm/sun3_pgalloc.h
index 2b626cb3ad0ae..731cc8f0731d3 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -19,7 +19,6 @@ extern const char bad_pmd_string[];

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/mips/include/asm/pgalloc.h 
b/arch/mips/include/asm/pgalloc.h
index 36d9805033c4b..964ad514be281 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -56,7 +56,6 @@ static inline void pgd_free(struct mm_struct *mm, 
pgd_t *pgd)

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/nios2/include/asm/pgalloc.h 
b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..ef6b4b8301ac6 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -30,7 +30,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);

  #define __pte_free_tlb(tlb, pte, addr)                                 \
         do {                                                            \
-               pagetable_dtor(page_ptdesc(pte));                       \
                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
         } while (0)

diff --git a/arch/openrisc/include/asm/pgalloc.h 
b/arch/openrisc/include/asm/pgalloc.h
index 596e2355824e3..9361205610910 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -68,7 +68,6 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/riscv/include/asm/pgalloc.h 
b/arch/riscv/include/asm/pgalloc.h
index c8907b8317115..61c26576614da 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -25,12 +25,10 @@
   */
  static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, 
void *pt)
  {
-       if (riscv_use_sbi_for_rfence()) {
+       if (riscv_use_sbi_for_rfence())
                 tlb_remove_ptdesc(tlb, pt);
-       } else {
-               pagetable_dtor(pt);
+       else
                 tlb_remove_page_ptdesc(tlb, pt);
-       }
  }

  static inline void pmd_populate_kernel(struct mm_struct *mm,
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..5b5c73e9fdb4b 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -34,7 +34,6 @@ static inline void pmd_populate(struct mm_struct *mm, 
pmd_t *pmd,

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..4fd59fb184818 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -27,7 +27,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *);

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

@@ -35,7 +34,6 @@ do { 
        \

  #define __pmd_free_tlb(tlb, pmd, address)                      \
  do {                                                           \
-       pagetable_dtor(virt_to_ptdesc(pmd));                    \
         tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));     \
  } while (0)

@@ -43,7 +41,6 @@ do { 
        \

  #define __pud_free_tlb(tlb, pud, address)                      \
  do {                                                           \
-       pagetable_dtor(virt_to_ptdesc(pud));            \
         tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));     \
  } while (0)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index a96d4b440f3da..a59205863f431 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct 
mmu_gather *tlb, void *pt)
  /* Like tlb_remove_ptdesc, but for page-like page directories. */
  static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, 
struct ptdesc *pt)
  {
+       pagetable_dtor(pt);
         tlb_remove_page(tlb, ptdesc_page(pt));
  }

This avoids explicitly calling pagetable_dtor() in the architecture
code. If that makes sense, I can send a formal separate patch to do
this.

Thanks,
Qi


> the extra handling from arch code? I may well be missing something, I'm
> not super familiar with the tlb handling code >
> - Kevin
