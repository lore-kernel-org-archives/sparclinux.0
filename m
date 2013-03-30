From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 12:22:24 +0000
Subject: Re: [PATCH] sparc:cleanup unused code in smp_32.h
Message-Id: <20130330122224.GA10294@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <5156BE4A.2030400@huawei.com>
In-Reply-To: <5156BE4A.2030400@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, wangyijing@huawei.com

On Sat, Mar 30, 2013 at 06:28:26PM +0800, Kefeng Wang wrote:
> After genirq and generic clockevent support at sparc32,
> smp4m_irq_rotate(), prof_multiplier() and prof_counter()
> are no longer used and should be removed.
> 
> Find more info from commit 6baa9b20 & 62f08283.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
