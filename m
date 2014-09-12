From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2014 20:36:53 +0000
Subject: Re: q about ldc_bind after irq save
Message-Id: <20140912.163653.766678500534620420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140910184926.GC14466@oracle.com>
In-Reply-To: <20140910184926.GC14466@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 10 Sep 2014 14:49:26 -0400

> But is there a reason we can't move the request_irq from ldc_bind
> and into ldc_alloc itself?  Or is there a simpler fix?

Because we don't have the string name for the IRQ until we get it
from the ldc_bind() call, for one.
