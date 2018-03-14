From: David Miller <davem@davemloft.net>
Date: Wed, 14 Mar 2018 18:01:55 +0000
Subject: Re: [PATCH net-next] sunvnet: does not support GSO for sctp
Message-Id: <20180314.140155.2269775332232678760.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1521050167-3946-1-git-send-email-cathy.zhou@oracle.com>
In-Reply-To: <1521050167-3946-1-git-send-email-cathy.zhou@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cathy.zhou@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: cathy.zhou@oracle.com
Date: Wed, 14 Mar 2018 10:56:07 -0700

> From: Cathy Zhou <Cathy.Zhou@Oracle.COM>
> 
> The NETIF_F_GSO_SOFTWARE implies support for GSO on SCTP, but the
> sunvnet driver does not support GSO for sctp.  Here we remove the
> NETIF_F_GSO_SOFTWARE feature flag and only report NETIF_F_ALL_TSO
> instead.
> 
> Signed-off-by: Cathy Zhou <Cathy.Zhou@Oracle.COM>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>

Since this is a bug fix I'm applying this to the 'net' tree.

Thanks.
