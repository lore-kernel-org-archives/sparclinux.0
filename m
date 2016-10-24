From: tndave <tushar.n.dave@oracle.com>
Date: Mon, 24 Oct 2016 20:40:06 +0000
Subject: Re: [PATCH 2/6] sparc64: Add ATU (new IOMMU) support
Message-Id: <1be31752-6f6d-e28e-9e30-835c8b7b8395@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
 <1476123127-24314-3-git-send-email-tushar.n.dave@oracle.com>
 <20161024.134645.2216722602983259081.davem@davemloft.net>
In-Reply-To: <20161024.134645.2216722602983259081.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/24/2016 10:46 AM, David Miller wrote:
> From: Tushar Dave <tushar.n.dave@oracle.com>
> Date: Mon, 10 Oct 2016 11:12:03 -0700
>
>> +	/* calculate size of IOTSB */
>> +	table_size = (atu->size / IO_PAGE_SIZE) * 8;
>> +	table = kzalloc(table_size, GFP_KERNEL);
>> +	if (!table) {
>> +		err = -ENOMEM;
>> +		goto table_failed;
>> +	}
>> +	table = (void *)IO_PAGE_ALIGN((u64)table);
>
> If you use the page allocator directly you can avoid all of these
> funny alignment calculations.
Okay. I will look into this.
>
>> @@ -931,8 +1046,10 @@ static int pci_sun4v_probe(struct platform_device *op)
>>  	struct pci_pbm_info *pbm;
>>  	struct device_node *dp;
>>  	struct iommu *iommu;
>> +	struct atu *atu;
>>  	u32 devhandle;
>>  	int i, err = -ENODEV;
>> +	static bool hv_atu = 1;
>
> Please use true/false with boolean variables.
Sure.
>
>> +			hv_atu = 0;
>
> Likewise.
>
Thanks.
-Tushar

