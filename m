From: David Miller <davem@davemloft.net>
Date: Tue, 16 May 2017 15:53:25 +0000
Subject: Re: [PATCH v2 net-next] bnxt: add dma mapping attributes
Message-Id: <20170516.115325.904175179446683748.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1494379812-282087-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494379812-282087-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org, michael.chan@broadcom.com

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue,  9 May 2017 18:30:12 -0700

> On the SPARC platform we need to use the DMA_ATTR_WEAK_ORDERING attribute
> in our Rx path dma mapping in order to get the expected performance out
> of the receive path.  Adding it to the Tx path has little effect, so
> that's not a part of this patch.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Tushar Dave <tushar.n.dave@oracle.com>
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> ---
> v2: simplify by getting rid of the driver-specific ifdef and define

Applied.
