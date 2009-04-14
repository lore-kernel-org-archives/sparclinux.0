From: Josip Rodin <joy@orion.carnet.hr>
Date: Tue, 14 Apr 2009 17:57:35 +0000
Subject: Re: [PATCH] sparc: fix possible build error in
Message-Id: <20090414175735.GA2662@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <49E42A57.50506@cn.fujitsu.com>
In-Reply-To: <49E42A57.50506@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 14, 2009 at 02:16:55PM +0800, Wei Yongjun wrote:
> commit 51dcdfec6a274afc1c6fce180d582add9ff512c0 (parport: Use the PCI
> IRQ if offered) parport_pc_probe_port() gained an irqflags arg.  This
> isn't being supplied on sparc.  This patch make sparc fallback to the
> old behaviour, that is using 0 for irqflags.

FWIW looks like this is already in Linus' tree:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h(783eb52013ad20784550bccd482e541c9619c2

-- 
     2. That which causes joy or happiness.
