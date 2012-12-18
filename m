From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2012 23:48:51 +0000
Subject: Re: [PATCH v2] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <20121218.154851.1283512279269300846.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <50CF5BEF.9080009@oracle.com>
In-Reply-To: <50CF5BEF.9080009@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 17 Dec 2012 11:52:47 -0600

> Modifying the huge pte's requires that all the underlying pte's be
> modified.
> 
> Version 2: added missing flush_tlb_page()
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Applied and queued up for -stable, thanks.
