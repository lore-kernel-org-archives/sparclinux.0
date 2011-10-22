From: David Miller <davem@davemloft.net>
Date: Sat, 22 Oct 2011 22:54:05 +0000
Subject: Re: longjmp question
Message-Id: <20111022.185405.1566752500858779366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 22 Oct 2011 10:43:39 +0100

> On Sat, Oct 22, 2011 at 05:05:05AM -0400, David Miller wrote:
>> From: Jurij Smakov <jurij@wooyd.org>
>> Date: Sat, 22 Oct 2011 10:00:24 +0100
>> 
>> > Is something conceptually wrong with just doing this:
>> > 
>> > asm volatile ("save; flush; restore");
>> > 
>> > It fixes the problem for freebsd (will test on linux later today), and 
>> > does not rely on compiler doing (or not doing) the "right" 
>> > optimization.
>> 
>> I would not do a "naked" save here, please just use the construct
>> I showed you with the %o7 register clobber.
> 
> Yes, I missed that save is not allocating any memory, which is 
> wrong. What I actually had in mind was this:
> 
> asm volatile ("save %sp, -96, %sp; flushw; restore");

Only works on 32-bit, will crash on 64-bit.

Just let the compiler do it for you, please... the compiler absolutely cannot
optimize away a function that uses a volatile asm statement.  And it absolutely
cannot make a function that clobbers %o7 a leaf function.

Please just use the approach I suggested, it covers all cases and is in fact
future proof.

