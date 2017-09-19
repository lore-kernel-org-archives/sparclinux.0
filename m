From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 18:10:06 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.111006.734002102633434772.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 19:40:30 +0200

> On 09/19/2017 07:31 PM, David Miller wrote:
>> All of that complexity and knowledge of formatting properties this way
>> or that has no business in the kernel, and belongs completely in
>> userspace.
> 
> But that's not really contradicting to the fact that this information
> belongs to sysfs, not some obscure device node below /dev.
> 
> Basically every human-readable information from the kernel is provided
> through sysfs these days. Why should it be different for SPARC?

Every?

I disagree.

Properly printing openfirmware and mdesc properties requires context
(what type of bus or device is this node underneath, etc.) and
knowledge of how that property works.

The kernel has no business knowing how every current and future
property type, for every device type existing now and in the future,
should be handled.

Exporting the raw data allows having userspace decide what to do.
