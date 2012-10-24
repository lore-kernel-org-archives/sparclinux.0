From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Oct 2012 19:37:43 +0000
Subject: Re: [PATCH v2] sparc: Add sparc support for platform_get_irq()
Message-Id: <20121024193743.GA3521@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Andreas.

On Tue, Oct 23, 2012 at 12:16:50PM +0200, Andreas Larsson wrote:
> On 2012-10-18 09:42, Andreas Larsson wrote:
>> This adds sparc support for platform_get_irq that in the normal case use
>> platform_get_resource() to get an irq. This standard approach fails for sparc as
>> there are no resources of type IORESOURCE_IRQ for irqs for sparc.
>>
>> Cross platform drivers can then use this standard platform function and work on
>> sparc instead of having to have a special case for sparc.
>
> Any comments? Is this a good idea, or do anyone see any problems with  
> this change?

First off - seeing a SPARC ifdef in base/drivers make me think
that something is wrong. And there is not even a comment why SPARC is so
special.

And secondly - what is need for SPARC to support IORESOURCE_IRQ?
I took a very quick look - and I did not understand all the
logic regarding IORESOURCE_IRQ.
But I could see linux/ioport.h being included in several places
in sparc..

	Sam
