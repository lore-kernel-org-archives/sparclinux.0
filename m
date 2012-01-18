From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jan 2012 04:49:01 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120117.234901.2029957420081702927.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 18 Jan 2012 00:20:08 +0000

> On Tue, Jan 17, 2012 at 01:51:51PM -0500, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Tue, 17 Jan 2012 12:56:56 -0500 (EST)
>> 
>> > I'm looking into the rest.
>> 
>> So just adding the stubs (or your idea, linking with libc) doesn't
>> work at all.
>> 
>> All the new features in libext2 that get linked in cause the second
>> stage bootloader image to grow too large.
>> 
>> I'll just have to extract the parts of libext2 that we actually need
>> into a stripped down local copy in SILO and I guess this will make
>> us immune to this issue showing up again in the future.
> 
> If you haven't put too much effort into it yet, can you give me a 
> few days to experiment with dropping unnecessary symbols from the 
> built library using objcopy? If it turns out to be simple, I'd rather 
> use this than duplicating code.

We've been fighting this problem for years, it only gets worse and
all of these various hacks are error prone.

The only real solution is to write something made for a bootloader and
that's what I'm already doing.  The code isn't that hard at all.

