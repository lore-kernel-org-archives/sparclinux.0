From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2015 20:19:10 +0000
Subject: Re: [PATCH] sparc: Use GFP_ATOMIC in ldc_alloc_exp_dring() as it can be called in softirq context
Message-Id: <20150421.161910.832190218442838965.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1429626641-199974-1-git-send-email-sowmini.varadhan@oracle.com>
In-Reply-To: <1429626641-199974-1-git-send-email-sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 21 Apr 2015 10:30:41 -0400

> Since it is possible for vnet_event_napi to end up doing
> vnet_control_pkt_engine -> ... -> vnet_send_attr ->
> vnet_port_alloc_tx_ring -> ldc_alloc_exp_dring -> kzalloc()
> (i.e., in softirq context), kzalloc() should be called with
> GFP_ATOMIC from ldc_alloc_exp_dring.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Applied and queued up for -stable, thanks.
