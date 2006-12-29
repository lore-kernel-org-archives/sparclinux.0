From: David Miller <davem@davemloft.net>
Date: Fri, 29 Dec 2006 05:44:14 +0000
Subject: Re: [PATCH] sparc64: isa.c should cope with OBP nodes with no
Message-Id: <20061228.214414.48799944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1166915246238-git-send-email-richm@oldelvet.org.uk>
In-Reply-To: <1166915246238-git-send-email-richm@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: richm@oldelvet.org.uk
Date: Sat, 23 Dec 2006 23:07:25 +0000

> From: Richard Mortimer <richm@oldelvet.org.uk>
> 
> The todm5819 Openboot device node on Netra X1 does not have a "reg"
> property. In this case of_get_property returns NULL resulting in an
> Oops. Avoid this by returning from isa_dev_get_resource() without
> attempting to request_resource().
> 
> Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>

Thanks for catching this.

It's really aweful how we return the "pregs" here but it's
ultimately unused, because even though we end up passing it
to isa_dev_get_irq() that function doesn't even use the pregs
argument.

So let's just return void from isa_dev_get_resource() and drop
the pregs arg from isa_dev_get_irq().

I'll apply the following as ths fix, thanks again.

