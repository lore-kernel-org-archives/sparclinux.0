From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:15:18 +0000
Subject: Re: [PATCH] sparc: tsb must be flushed before tlb
Message-Id: <20130619.021518.1013121910526110702.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <51C06930.3050800@oracle.com>
In-Reply-To: <51C06930.3050800@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 18 Jun 2013 09:05:36 -0500

> This fixes a race where a cpu may re-load a tlb from a stale tsb right
> after it has been flushed by a remote function call.
> 
> I still see some instability when stressing the system with parallel
> kernel builds while creating memory pressure by writing to
> /proc/sys/vm/nr_hugepages, but this patch improves the stability
> significantly.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Bob Picco <bob.picco@oracle.com>

Applied and queued up for -stable, thanks.
