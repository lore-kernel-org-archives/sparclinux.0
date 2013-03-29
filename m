From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 29 Mar 2013 11:09:04 +0000
Subject: Re: [PATCH] sparc:remove unused declaration smp_boot_cpus()
Message-Id: <20130329110904.GA2765@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <5152E41D.2030901@huawei.com>
In-Reply-To: <5152E41D.2030901@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 27, 2013 at 08:20:45PM +0800, Kefeng Wang wrote:
> smp_boot_cpus() was replaced smp_prepare_cpus() long ago, and it no
> longer needed, so delete it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

But when looking at the same file it looks like we have
more candidates for removal:
smp4m_irq_rotate,
prof_multiplier,
prof_counter,

Care to send a follow-up patch that remvoe these also.

	Sam
