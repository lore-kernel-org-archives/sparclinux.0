From: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 06 Jan 2014 01:08:28 +0000
Subject: Re: [PATCH v3] sparc/PCI: Use dev_is_pci() to identify PCI devices
Message-Id: <52CA020C.60206@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1386741626-35744-1-git-send-email-wangyijing@huawei.com> <20140104.210533.653844636617320862.davem@davemloft.net>
In-Reply-To: <20140104.210533.653844636617320862.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, guohanjun@huawei.com

On 2014/1/5 10:05, David Miller wrote:
> From: Yijing Wang <wangyijing@huawei.com>
> Date: Wed, 11 Dec 2013 14:00:26 +0800
> 
>> Use dev_is_pci() instead of checking bus type directly.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied.
> 
> 
Hi David,
   This patch has been merged in Bjorn's pci tree, so will have some conflict between yours and Bjorn's tree?

-- 
Thanks!
Yijing

