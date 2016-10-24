From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 17:46:45 +0000
Subject: Re: [PATCH 2/6] sparc64: Add ATU (new IOMMU) support
Message-Id: <20161024.134645.2216722602983259081.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
        <1476123127-24314-3-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1476123127-24314-3-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 11:12:03 -0700

> +	/* calculate size of IOTSB */
> +	table_size = (atu->size / IO_PAGE_SIZE) * 8;
> +	table = kzalloc(table_size, GFP_KERNEL);
> +	if (!table) {
> +		err = -ENOMEM;
> +		goto table_failed;
> +	}
> +	table = (void *)IO_PAGE_ALIGN((u64)table);

If you use the page allocator directly you can avoid all of these
funny alignment calculations.

> @@ -931,8 +1046,10 @@ static int pci_sun4v_probe(struct platform_device *op)
>  	struct pci_pbm_info *pbm;
>  	struct device_node *dp;
>  	struct iommu *iommu;
> +	struct atu *atu;
>  	u32 devhandle;
>  	int i, err = -ENODEV;
> +	static bool hv_atu = 1;

Please use true/false with boolean variables.

> +			hv_atu = 0;

Likewise.
