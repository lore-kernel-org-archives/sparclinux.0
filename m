From: David Miller <davem@davemloft.net>
Date: Thu, 23 Apr 2015 01:39:23 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150422.213923.982207738636099175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Wed, 22 Apr 2015 18:29:12 -0600

> On 4/22/15 5:25 PM, David Miller wrote:
>> From: David Ahern <david.ahern@oracle.com>
>> Date: Wed, 22 Apr 2015 17:19:23 -0600
>>
>>> Only thing left in my queue is optimized versions of the ffs / fls
>>> families, but that patch is v9b specific, not M7.
>>
>> Something faster than the popc thing in arch/sparc/lib/ffs.S?
> 
> hmmm... i saw that, but wasn't clear 1) how it got inserted and 2) the
> overhead of a function call versus inline. Anyways, what I have is the
> same 3 instructions as an inline. But really the __ffs was just along
> for the ride; the focus was on __fls.

Because we must support all processors in a single kernel image, the
called assembler routine that gets patched is the best tradeoff in my
opinion.

I strongly recommend we do the same thing for any optimizations done
to fls*().

>> Are you thinking of using "lzcnt"?  I wasn't impressed with the
>> performance of that instruction last time I played around with it.
> 
> A comparison of what I hacked together is attached (columns too wide
> for inline). Data is from a T4-2. It shows lzcnt to be better for
> __fls, fls and fl64.

Cool, is it faster when used in your tests for ffs() too?
