From: David Miller <davem@davemloft.net>
Date: Wed, 02 Oct 2013 18:14:09 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131002.141409.2285269654830222483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Mon, 30 Sep 2013 17:42:02 -0700

> On 09/30/2013 04:51 PM, David Miller wrote:
>> From: Gurudas Pai <gurudas.pai@oracle.com>
>> Date: Mon, 30 Sep 2013 16:47:48 -0700
>>
>>> Allocate 10 hugepages, and run a test using tool 'fio' with following
>>> jobfile.
>>> Fio just hangs. Basically issue is with O_DIRECT and hugepages. If you
>>> comment
>>> out "direct=1" from jobfile test works fine.
>> This worked before my changes right?
> No, Just now tried with old kernel, it hangs as well.

This should fix it:

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d06079c..99b490b 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -6,12 +6,12 @@ static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
 	return mk_pte(page, pgprot);
 }
 
-static inline int huge_pte_write(pte_t pte)
+static inline unsigned long huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
 }
 
-static inline int huge_pte_dirty(pte_t pte)
+static inline unsigned long huge_pte_dirty(pte_t pte)
 {
 	return pte_dirty(pte);
 }
