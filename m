From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 19:33:08 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <Pine.LNX.4.64.1009101527570.29949@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Fri, 10 Sep 2010, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Fri, 10 Sep 2010 14:46:39 -0400 (EDT)
> 
> > If you can't interpret it --- there happened sparc+sparc64 -> sparc merge 
> > between this and it looks like a probable cause. Could you give me your 
> > git tree with linear commits that I could try?
> 
> I rebase my tree every time the merge window completes, so
> I can't give that to you, sorry.
> 
> But you don't need my tree from back then, you can git bisect between
> the commits on my line of development branch when Linus pulled my tree
> in.
> 
> And even my original tree was linear, I would pull Linus's tree in now
> and again to deal with merge conflicts and similar.

I assume that there was some commit ID in your tree when you started to do 
sparc+sparc64 unification and there was some commit ID when you finished 
it. So give me these two and I hope git will go linearly between them.

> Anyways, all the information is there, you just need to give GIT the
> properl commit ranges.
> 
> BTW, if you're so disappointed about how it walks the graph during git
> bisect, feel free to suggest alternatives to the GIT developers.  I
> think they considered long and hard about this, and therefore the
> current behavior isn't arbitrary :-)

If you understand git better than me, please explain to me how to 
interpret bisect result --- i.e. I sent a list of commit IDs that are 
result of bisecting, so tell me which fixed the bug and how did you find 
it.

Mikulas
