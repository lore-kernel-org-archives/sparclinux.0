From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:33 +0000
Subject: Re: [PATCH] sparc:cleanup unused code in smp_32.h
Message-Id: <20130331.193133.210545164355686346.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5156BE4A.2030400@huawei.com>
In-Reply-To: <5156BE4A.2030400@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wangkefeng.wang@huawei.com
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, wangyijing@huawei.com

From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Sat, 30 Mar 2013 18:28:26 +0800

> After genirq and generic clockevent support at sparc32,
> smp4m_irq_rotate(), prof_multiplier() and prof_counter()
> are no longer used and should be removed.
> 
> Find more info from commit 6baa9b20 & 62f08283.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied.
