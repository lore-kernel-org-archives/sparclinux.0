From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2006 22:53:17 +0000
Subject: Re: generic__raw_read_trylock Considered Harmful
Message-Id: <20060919.155317.22126004.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060831134254.GE4919@parisc-linux.org>
In-Reply-To: <20060831134254.GE4919@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, takata@linux-m32r.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 31 Aug 2006 07:42:55 -0600

> NOTE to architecture maintainers: generic_raw_read_trylock() is
> completely unfit for use and will cause lockups if used in interrupt
> context.

I was about to go an fix SPARC but then looked in the tree
for actual users, and I see one, and only one, in the lockdep
code which tries to grab the tasklist_lock.

That's it (well.. there's one strange IA64 specific case in the MCA
code too).

You say you were fixing up PARISC and actually hit this problem, was
it exactly this lockdep case?  I really doubt it...

