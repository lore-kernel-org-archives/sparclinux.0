From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 18:46:39 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <Pine.LNX.4.64.1009101441260.16985@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Fri, 10 Sep 2010, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Fri, 10 Sep 2010 14:31:27 -0400 (EDT)
> 
> > I very much don't understand the bisect tool, I thought that it will do a 
> > binary search between the entries in the ChangeLog file, but it skips very 
> > randomly (the second columnt is the line in the ChangeLog file).
> > 
> > How does it really work? Do you know how to interpret it and which patch 
> > really fixed the bug?
> 
> When there are multiple lines of development, it has to hop in and out
> of the merged branches.
> 
> Sometimes that aspect can make it go "out of order".

Bisecting over a graph, that is totally confusing.

> The best you can do is do the full bisect, trust what it comes up
> with, and start your analysis with the commit it comes up with after
> the whole bisect is complete.
> 
> What commit did it print out when you completed the bisect run?
> 
> Also, there is another problematic case, sometimes bisect gives you
> a merge commit.  And this means that in the tree in which the
> development of the branch was done, the bisect condition doesn't
> trigger, but once it gets integrated into what happened upstream
> meanwhile, it does trigger.

good:   112956  e50a906e0200084f04f8f3b7c3a14b0442d1347f
bad:    102852  6ded6ab9be4f6164aef1c527407c1b94f0929799
bad:    109140  7596b27dbd8de7bcfa7a80b2756114b49bd5c018
bad:    111150  f3a5c547012a09f38f7c27b17a8e3150b69cd259

I don't know what came up. The last "good" one and the last "bad" one are 
more than 1000 lines apart. After these tries it refused to bisect 
further and pretended that the bug is found.

If you can't interpret it --- there happened sparc+sparc64 -> sparc merge 
between this and it looks like a probable cause. Could you give me your 
git tree with linear commits that I could try?

Mikulas
