From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 18:55:23 +0000
Subject: Re: [PATCH] sparc64: mm: fix copy_tsb to correctly copy huge page TSBs
Message-Id: <20170605.145523.2161559093801012337.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496440272-19057-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1496440272-19057-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, nitin.m.gupta@oracle.com, bob.picco@oracle.com, anthony.yznaga@oracle.com

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri,  2 Jun 2017 14:51:12 -0700

> When a TSB grows beyond its current capacity, a new TSB is allocated
> and copy_tsb is called to copy entries from the old TSB to the new.
> A hash shift based on page size is used to calculate the index of an
> entry in the TSB.  copy_tsb has hard coded PAGE_SHIFT in these
> calculations.  However, for huge page TSBs the value REAL_HPAGE_SHIFT
> should be used.  As a result, when copy_tsb is called for a huge page
> TSB the entries are placed at the incorrect index in the newly
> allocated TSB.  When doing hardware table walk, the MMU does not
> match these entries and we end up in the TSB miss handling code.
> This code will then create and write an entry to the correct index
> in the TSB.  We take a performance hit for the table walk miss and
> recreation of these entries.
> 
> Pass a new parameter to copy_tsb that is the page size shift to be
> used when copying the TSB.
> 
> Suggested-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Great find, applied and queued up for -stable.

Thanks!
