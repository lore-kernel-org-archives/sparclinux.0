From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2012 17:10:26 +0000
Subject: Re: [PATCH v2] sparc: Add sparc support for platform_get_irq()
Message-Id: <20121023.131026.2220218547942106926.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 23 Oct 2012 12:16:50 +0200

> On 2012-10-18 09:42, Andreas Larsson wrote:
>> This adds sparc support for platform_get_irq that in the normal case
>> use
>> platform_get_resource() to get an irq. This standard approach fails
>> for sparc as
>> there are no resources of type IORESOURCE_IRQ for irqs for sparc.
>>
>> Cross platform drivers can then use this standard platform function
>> and work on
>> sparc instead of having to have a special case for sparc.
> 
> Any comments? Is this a good idea, or do anyone see any problems with
> this change?
> 
> It would make life easier when adapting device drivers to work on a
> sparc platform.

I'm just busy and haven't gotten to review this change yet, be patient.
