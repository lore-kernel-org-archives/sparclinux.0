From: Chris Torek <chris.torek@windriver.com>
Date: Mon, 22 Dec 2008 22:34:27 +0000
Subject: Re: Unify module.*
Message-Id: <200812222234.mBMMYRn07972@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081222220745.GA30716@uranus.ravnborg.org>
In-Reply-To: <20081222220745.GA30716@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>I really did not like this part:
>#ifdef CONFIG_SPARC64
>                BUG_ON(((u64)location >> (u64)32) != (u64)0);
>#endif /* CONFIG_SPARC64 */
>
>I think it should be safe to do:
>
>		BUG_ON(((unsigned long)location >> (unsigned long)32) !>		       (unsigned long)0);

No, you can't safely shift a 32-bit value by 32 bits (the compiler
is allowed to turn this into a shift of 0 bits for instance, by
using a 5-bit mask for the shift distance).  However it should be
safe to do this, which is exactly the same in practice:

		BUG_ON((((unsigned long)location >> 31) >> 1) !		       (unsigned long)0);

>But I did not really see the point of the BUG_ON in the first place,
>and my limited digging did not turn up when it was added.

Not sure who uses it and why it was added, but it's equivalent to:

	BUG_ON((unsigned long)location > 0xffffffff);

which I personally prefer to the shift version -- I think it makes
the intent more obvious -- but this might still draw a warning about
being always-false on 32-bit.  Of course, if gcc gets any smarter,
so might the shift version.

Chris
