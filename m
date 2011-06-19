From: David Miller <davem@davemloft.net>
Date: Sun, 19 Jun 2011 23:01:50 +0000
Subject: Re: reorganized struct inode results in unaligned accesses
Message-Id: <20110619.160150.1199476848151993579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee>
	<BANLkTiktb6GS7fcHRRgC=bHJjz8k0hVmPw@mail.gmail.com>
	<m2boxtfo0d.fsf@firstfloor.org>
In-Reply-To: <m2boxtfo0d.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andi@firstfloor.org
Cc: torvalds@linux-foundation.org, mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 19 Jun 2011 15:35:30 -0700

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>> Dang. I guess it needs to be made "unsigned long" again. Which is a
>> shame, because we only use a couple of bits from there, and "struct
>> inode" really is much too big already.
> 
> In the past it was usually enough to just align it to alignof(unsigned
> long), not actually make it long. struct page went through this
> a long time ago.

Hmmm, can this scheme actually work out properly on both big and
little endian?  Because endianness determines whether the bits start
in the "lower addressed" 32-bit word or the "higher addressed" 32-bit
word.

If this trick is being attempted elsewhere, I think it could perhaps
account for some strange bugs :-)
