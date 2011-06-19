From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 19 Jun 2011 23:14:02 +0000
Subject: Re: reorganized struct inode results in unaligned accesses
Message-Id: <20110619231402.GK16236@one.firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee> <BANLkTiktb6GS7fcHRRgC=bHJjz8k0hVmPw@mail.gmail.com> <m2boxtfo0d.fsf@firstfloor.org> <20110619.160150.1199476848151993579.davem@davemloft.net>
In-Reply-To: <20110619.160150.1199476848151993579.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: andi@firstfloor.org, torvalds@linux-foundation.org, mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> Hmmm, can this scheme actually work out properly on both big and
> little endian?  Because endianness determines whether the bits start
> in the "lower addressed" 32-bit word or the "higher addressed" 32-bit
> word.

True, it needs an ifdef, with the other order in BE. struct page has that iirc.

> 
> If this trick is being attempted elsewhere, I think it could perhaps
> account for some strange bugs :-)

Well if you want to be sure better try to get rid of the void *

(I tried early on in x86-64, it caused a lot of warnings all over)

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
