From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 20:53:28 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160427.165328.1116001015853043626.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Apr 2016 22:49:11 +0200

> On Wed, Apr 27, 2016 at 04:22:42PM -0400, David Miller wrote:
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Wed, 27 Apr 2016 14:06:04 -0600
>> 
>> > Also, perhaps think about a way to make the assembler emit something
>> > fatal instead of a warning when this situation occurs? People tend to
>> > ignore warnings. ;)
>> 
>> Yeah, good idea, I'll try to come up with something.
>> 
>> I think you can put asserts into the linker script, and we should have
>> added a test on swapper_tsb's address a very long time ago. :)
> 
> Something like this:
 ...

Indeed, see the patch I just posted.
