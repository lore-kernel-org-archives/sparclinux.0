From: David Miller <davem@davemloft.net>
Date: Thu, 30 Mar 2017 20:22:54 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <20170330.132254.194046756997356229.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 28 Mar 2017 17:52:26 -0700 (PDT)

> 
> There seems to be some disagreement about how the hugepage state is
> passed into tlb_batch_add().  It's declared as an integer shift, but
> there are call sites that pass it in the old way, as a boolean.
> 
> For example, all of the call sites in tlb_batch_pmd_scan(), which
> likely should be passing PAGE_SHIFT.  Passing true or false in these
> spots can't be right.

And this appears to be causing regressions, gcc bootstraps fail with
all kinds of memory corruption, including in the libc malloc arena.

I did a full git bisect and it showed the multipage size support
commit as the culprit.
