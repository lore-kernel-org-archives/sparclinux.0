From: David Miller <davem@davemloft.net>
Date: Thu, 23 Jun 2016 19:44:09 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <20160623.154409.654956825440290649.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 21:33:34 +0200

> On 06/23/2016 09:31 PM, David Miller wrote:
>> And all of those binaries you say "don't matter" take up memory,
>> swap space, etc.  And if you add this up for the entire system
>> it's non-trivial.
>> 
>> Multiply this by some factor N when virtualization is involved.
> 
> On a machine with 8 TiB of memory? I have also never heard anyone complain
> about memory issues on x86_64. Are you also running i686 for that reasons?

It's physical memory, cache memory, TLB entries.

Not the amount of physical or virtual "address space" the cpu
supports.

> Intel ICC does exactly that. I even provided a reference for that.

I don't understand how such an optimization is even possible, or would
even apply in common cases where the pointer is actually used.
