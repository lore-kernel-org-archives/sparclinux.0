From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Jun 2011 16:51:24 +0000
Subject: Re: reorganized struct inode results in unaligned accesses
Message-Id: <BANLkTiktb6GS7fcHRRgC=bHJjz8k0hVmPw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Sun, Jun 19, 2011 at 9:33 AM, Meelis Roos <mroos@linux.ee> wrote:
>
> Commit 13e12d14e2dccc7995b8f15a5678a338ab4e6a8c (vfs: reorganize 'struct
> inode' layout a bit) changes i_state to be unsigned int instead of
> unsigned long. This is the cause of unaligned accesses on sparc64 and
> maybe others. Changing it back to unsigned long fixes the warnings but I
> did not look at the layout of the resulting struct - might leave a hole
> there.

Argh. Gaah, we acces that thing with the bit-ops when we do the
bit_waitqueue() and wait_on_bit() thing.

My bad, and apparently our type checking for the wait-on-bit stuff
isn't as tight as it should be.

Dang. I guess it needs to be made "unsigned long" again. Which is a
shame, because we only use a couple of bits from there, and "struct
inode" really is much too big already.

I do wonder why "wait_on_bit()" takes a "void *", when apparently it
can only handle "unsigned long *" entities. Maybe we could fix the
implementation to really take anything.

                  Linus
