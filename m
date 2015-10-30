From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 30 Oct 2015 22:13:24 +0000
Subject: Re: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-Id: <20151030221324.GM7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151030214848.GC13904@localhost.localdomain>
In-Reply-To: <20151030214848.GC13904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 30.10.2015 [21:48:48 +0000], Keith Busch wrote:
> On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> > Given that it's 4K just about everywhere by default (and sort of
> > implicitly expected to be, I guess), I think I'd prefer we default to
> > 4K. That should mitigate the performance impact (I'll ask our IO team to
> > do some runs, but since this impacts functionality on some hardware, I
> > don't think it's too relevant for now). Unless there are NVMe devcies
> > with a MPSMAX < 4K? 
> 
> Right, I assumed MPSMIN was always 4k for the same reason you mentioned,
> but you can hard code it like you've done in your patch.
> 
> The spec defines MPSMAX such that it's impossible to find a device
> with MPSMAX < 4k.

Great, thanks!

-Nish

