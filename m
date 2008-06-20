From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 02:00:48 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080619.190048.193701955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670806190707k7ae6da8cud80a826a1603d941@mail.gmail.com>
	<a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
In-Reply-To: <a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 19 Jun 2008 20:02:44 +0400

> I have reverted this commit and
> 2.6.26-rc6-00233-g99d3b2d works fine. It can boot.

I know what the problem is.

It's hanging because lockdep is starting to actually be used. :-)
Beforehand various bugs caused lockdep to disable itself almost
immediately.  So it was never actually enabled on sparc64.

When you revert that changeset, there is a loop in the backtrace of
all kernel threads, and therefore lockdep turns itself off when all of
the stack backtrace slots get consumed by that loop in the backtraces.

After the revert you should see a set of kernel messages like:

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

and that would confirm my theory.

Lockdep really isn't usable on sparc64 at this time and it's one of
the ongoing things I'm trying to get fully fixed.  The changeset in
question fixes a real bug in stack backtrace output, so it should
stay in the tree.

FWIW, I just verified the above on my ultra5 box.
