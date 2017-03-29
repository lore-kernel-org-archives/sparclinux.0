From: David Miller <davem@davemloft.net>
Date: Wed, 29 Mar 2017 00:52:26 +0000
Subject: tlb_batch_add_one()
Message-Id: <20170328.175226.210187301635964014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


There seems to be some disagreement about how the hugepage state is
passed into tlb_batch_add().  It's declared as an integer shift, but
there are call sites that pass it in the old way, as a boolean.

For example, all of the call sites in tlb_batch_pmd_scan(), which
likely should be passing PAGE_SHIFT.  Passing true or false in these
spots can't be right.

I also noticed that there appears to be generic support for handling
the need to flush on page size changes during tlb batching, have
a look at __tlb_remove_page_size(), and the new arch overridable
hook tlb_remove_check_page_size_change().

Thanks.
