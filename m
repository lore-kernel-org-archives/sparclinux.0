From: tndave <tushar.n.dave@oracle.com>
Date: Mon, 24 Oct 2016 18:31:14 +0000
Subject: Re: [PATCH 1/6] sparc64: Add FORCE_MAX_ZONEORDER and default to 13
Message-Id: <149c73af-f3a5-2704-ba73-5e2fbbb4749e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
 <1476123127-24314-2-git-send-email-tushar.n.dave@oracle.com>
 <20161024.134543.843902561898603557.davem@davemloft.net>
In-Reply-To: <20161024.134543.843902561898603557.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/24/2016 10:45 AM, David Miller wrote:
> From: Tushar Dave <tushar.n.dave@oracle.com>
> Date: Mon, 10 Oct 2016 11:12:02 -0700
>
>> From: Dave Kleikamp <dave.kleikamp@oracle.com>
>>
>> This change allows ATU (new IOMMU) in SPARC systems to request
>> large (32M) contiguous memory during boot for creating IOTSB backing
>> store.
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
>
> If you need 32MB allocations, wouldn't a max zone order of 12 be
> sufficient?  (8K << 12 = 32MB)
Yes, but config FORCE_MAX_ZONEORDER is actually maximum order plus one.
For example, a value of 13 means that the largest free memory block is
2^12 pages. For 32MB we need 2^12 8K pages, hence FORCE_MAX_ZONEORDER
must be MAX_ORDER + 1 i.e. 13.

Thanks.

-Tushar

>
