From: David Miller <davem@davemloft.net>
Date: Fri, 10 Sep 2010 19:45:31 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20100910.124531.186319864.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 15:33:08 -0400 (EDT)

> I assume that there was some commit ID in your tree when you started to do 
> sparc+sparc64 unification and there was some commit ID when you finished 
> it. So give me these two and I hope git will go linearly between them.

Maybe not this specific portion, but some parts of the unification
work was not done linearly, it was partly done in a GIT tree
maintained by Sam Ravnborg and partly done in mine.

Non-linear development is just how things are much of the time.

And regardless, you could figure out the commits you're looking for by
looking in GITK at the merge commit when Linus brought the my tree in
during the merge window, walk up the line that represents my branch going
back in time to the point where the line connects back up to the mainline.

Start with something like "gitk v2.6.28..v2.6.29-rc1 -- arch/sparc arch/spar64"
it's pretty clear what the sequence of commits are in that branch when you
look at that window.

The boundaries (inclusive) you come up with will be something like:

4696b64d234b84b5b70ffd49a76833aa5c49cb61
86821d18f9d8fd42fa3180ad3703d491aecc52d9

Btw, "git bisect visualize" uses gitk to show you where the good and
bad points are in the graph during bisection.
