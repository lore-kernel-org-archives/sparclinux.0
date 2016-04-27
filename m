From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 27 Apr 2016 00:36:54 +0000
Subject: Re: [PATCH v5 0/4] Cleaning printk stuff in NMI context
Message-Id: <20160427003654.GB4782@swordfish>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1461239325-22779-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On (04/21/16 13:48), Petr Mladek wrote:
> v5 adds changes suggested by Sergey Senozhatsky. It should not longer
> conflict with his async printk patchset.

passes my tests. (apart from that cosmetic-nano-nit) the series
looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
