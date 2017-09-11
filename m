From: David Miller <davem@davemloft.net>
Date: Mon, 11 Sep 2017 22:55:43 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <20170911.155543.564152952288133009.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 11 Sep 2017 16:32:09 -0600

> This patch adds hypercall function stubs and C templates for
> ccb_submit/info/kill which provide coprocessor services for the Oracle
> Data Analytics Accelerator, registration for the DAX api group, and
> all the various associated constants.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> Signed-off-by: Sanath Kumar <sanath.s.kumar@oracle.com>

Please resubmit inside of a patch series containing the first
consumer of these interfaces.

Without an example usage, it's essentialy impossible to properly
review.

Thank you.
