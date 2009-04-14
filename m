From: David Miller <davem@davemloft.net>
Date: Tue, 14 Apr 2009 09:01:40 +0000
Subject: Re: [PATCH] sparc: fix possible build error in
Message-Id: <20090414.020140.262767589.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49E42A57.50506@cn.fujitsu.com>
In-Reply-To: <49E42A57.50506@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Wei Yongjun <yjwei@cn.fujitsu.com>
Date: Tue, 14 Apr 2009 14:16:55 +0800

> commit 51dcdfec6a274afc1c6fce180d582add9ff512c0 (parport: Use the PCI
> IRQ if offered) parport_pc_probe_port() gained an irqflags arg.  This
> isn't being supplied on sparc.  This patch make sparc fallback to the
> old behaviour, that is using 0 for irqflags.
> 
> No test.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Applied, thank you.
