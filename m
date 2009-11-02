From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 02 Nov 2009 13:13:35 +0000
Subject: Re: Leon patches...
Message-Id: <4AEEDAFF.8040902@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091102.042421.72817389.davem@davemloft.net>
In-Reply-To: <20091102.042421.72817389.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> Konrad, I've just done a review of the two pending Leon patches.
> Sorry for taking so long.
> 
> The SMP patch looks fine, I've applied it to sparc-next-2.6 and am
> doing some build validation tests before pushing it out to kernel.org
> 

O, that is great news.

> The AMBA device patch needs a little bit of work.
> 
> I think you should create a CONFIG_AMBA in drivera/ambapp/Kconfig
> that protects everything.  CONFIG_AMBA should "depends on SPARC_LEON"
> 
> Then drivers/Makefile should only traverse down into ambapp/
> if CONFIG_AMBA is set, just as we do for other bus layers such
> as PCI.
> 
> Fix that up and I'll try to add the Amba patch into sparc-next-2.6
> too, thanks!

I'll do that in the new version of the patch.
We are currently trying to rewrite this patch anyway:
kristoffer@gaisler.com sent the uart driver (that was included
in the AMBA device patch) to linux-serial instead. He seem to have
rewritten it so that it was only dependent on Openfirmware, not the
AMBA plug and play scanning. So, I'll have to rewrite this patch anyway
and take that driver out. What remains will be the AMBA p&p scanning.

It'll take a  while to get a new patch.
Can you until then postphone the AMBA device patch so that
it (the new patch to be sent) might be applied at a later time?

-- Greetings Konrad


> 
> Thanks.
> 
> 

