From: David Miller <davem@davemloft.net>
Date: Mon, 02 Nov 2009 13:08:10 +0000
Subject: Re: Leon patches...
Message-Id: <20091102.050810.240472884.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091102.042421.72817389.davem@davemloft.net>
In-Reply-To: <20091102.042421.72817389.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 02 Nov 2009 14:13:35 +0100

> We are currently trying to rewrite this patch anyway:
> kristoffer@gaisler.com sent the uart driver (that was included
> in the AMBA device patch) to linux-serial instead. He seem to have
> rewritten it so that it was only dependent on Openfirmware, not the
> AMBA plug and play scanning. So, I'll have to rewrite this patch
> anyway
> and take that driver out. What remains will be the AMBA p&p scanning.

What prevents all AMBA drivers from using openfirmware?

That would be the ideal situation.

> Can you until then postphone the AMBA device patch so that
> it (the new patch to be sent) might be applied at a later time?

I'll just apply the Leon SMP patch for now, and then I'll apply
the updated device stuff when you send it to me.

Thanks.

