From: David Miller <davem@davemloft.net>
Date: Fri, 10 Sep 2010 19:07:28 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20100910.120728.55849565.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 14:46:39 -0400 (EDT)

> If you can't interpret it --- there happened sparc+sparc64 -> sparc merge 
> between this and it looks like a probable cause. Could you give me your 
> git tree with linear commits that I could try?

I rebase my tree every time the merge window completes, so
I can't give that to you, sorry.

But you don't need my tree from back then, you can git bisect between
the commits on my line of development branch when Linus pulled my tree
in.

And even my original tree was linear, I would pull Linus's tree in now
and again to deal with merge conflicts and similar.

Anyways, all the information is there, you just need to give GIT the
properl commit ranges.

BTW, if you're so disappointed about how it walks the graph during git
bisect, feel free to suggest alternatives to the GIT developers.  I
think they considered long and hard about this, and therefore the
current behavior isn't arbitrary :-)
