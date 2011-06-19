From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 19 Jun 2011 22:35:30 +0000
Subject: Re: reorganized struct inode results in unaligned accesses
Message-Id: <m2boxtfo0d.fsf@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee>
	<BANLkTiktb6GS7fcHRRgC=bHJjz8k0hVmPw@mail.gmail.com>
In-Reply-To: <BANLkTiktb6GS7fcHRRgC=bHJjz8k0hVmPw@mail.gmail.com> (Linus
	Torvalds's message of "Sun, 19 Jun 2011 09:51:24 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Meelis Roos <mroos@linux.ee>, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> Dang. I guess it needs to be made "unsigned long" again. Which is a
> shame, because we only use a couple of bits from there, and "struct
> inode" really is much too big already.

In the past it was usually enough to just align it to alignof(unsigned
long), not actually make it long. struct page went through this
a long time ago.

This could cause r-m-w races with the next field in theory, but assuming
it's reasonably read-only (ie only set up at inode creation time)
that should be fine.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
