From: David Miller <davem@davemloft.net>
Date: Mon, 15 Sep 2014 21:11:55 +0000
Subject: Re: q about ldc_bind after irq save
Message-Id: <20140915.171155.921512519519447870.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140910184926.GC14466@oracle.com>
In-Reply-To: <20140910184926.GC14466@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 15 Sep 2014 09:12:46 -0400

> On (09/12/14 16:36), David Miller wrote:
>> 
>> > But is there a reason we can't move the request_irq from ldc_bind
>> > and into ldc_alloc itself?  Or is there a simpler fix?
>> 
>> Because we don't have the string name for the IRQ until we get it
>> from the ldc_bind() call, for one.
> 
> but that's not insurmountable. The name used by vnet/vdc is vio->name
> (initialized in vio_driver_init(), before ldc_alloc() is called),
> and ds uses a const string. So, by passing an extra const char *name
> argument to ldc_alloc(), the request_irq()s  can be moved out of ldc_bind(),
> avoiding the lockdep warning?
> 
> I'll submit a patch for this later today/tomorrow, unless there's
> something else I'm missing.

I guess what's most important is that we don't service any LDC interrupts
for that channel until it's state is fully brought up.

And that should be ensured by the ldc_bind() sequence wherein we enable
the IRQs and fully configure the channel all under the cpu-irq-disabling
lp->lock.

So it should be fine, but please test thoroughly :-)
