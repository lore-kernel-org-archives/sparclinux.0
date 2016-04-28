From: "George Spelvin" <linux@horizon.com>
Date: Thu, 28 Apr 2016 21:21:26 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428212126.16985.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[Obviously non-SPARC recipients dropped, but I probably missed some.]

>> __ffs on the available architectures:

> SPARC: sparc64: YES, sparc32: NO
> Patch needs to be updated to refelct this.

I didn't see the sparc64 implementation, but on looking again, I have
to say that no, it doesn't.

arch/sparc/lib/ffs.S is a custom implementation of __ffs, but it's a
function call and 33 instructions/18 cycles long.  There are several
similar custom implementations that I also considered "NO".

"fast" in this context means a handful of inline instructions,
usually one of:

1. A direct count_trailing_zeros instruction,
2. count_leading_zeros(x ^ (x-1)), or
3. count_leading_zeros(bit_reverse(x)), or
4. popcount(~x & (x-1)).

The question is whether __ffs plus a variable shift is faster than
three instructions plus an unpredictable branch.
