From: David Miller <davem@davemloft.net>
Date: Fri, 17 Apr 2015 19:24:12 +0000
Subject: Re: [PATCH] iommu-common: Fix PARISC compile-time warnings
Message-Id: <20150417.152412.203905879393546707.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150417022804.GA708@oracle.com>
In-Reply-To: <20150417022804.GA708@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 16 Apr 2015 22:28:04 -0400

> Fixes warnings due to
> - no DMA_ERROR_CODE on PARISC,
> - sizeof (unsigned long) = 4 bytes on PARISC.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

I'll apply this, thanks Sowini.
