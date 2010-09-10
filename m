From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 18:31:27 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <Pine.LNX.4.64.1009101425350.7839@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Thu, 19 Aug 2010, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Thu, 19 Aug 2010 09:15:16 -0400 (EDT)
> 
> > BTW. two years ago, I reported a bug that userspace programs on sparc64 
> > would randomly crash in a few hours with preempt enabled 
> > ( http://marc.info/?l=linux-sparc&m1222607414906&w=4 )
> > 
> > Now I tried the same workload with 2.6.35 and it is stable with preempt.
> > 
> > Are you aware that the bug was fixed? Or if not, it may be still lurking 
> > there and some unrelated change hid the race condition. Should I bisect 
> > the kernel to find out which patch actually fixed (or hid) the bug?
> 
> I can't think of anything we did explicitly to fix that.
> 
> I'm sure you can find more useful things to do than to try and
> bisect that thing down, really :-)

From my experience with development --- no race should be silently 
ignored. Because if you ignore a race, there is a possibility that the 
race is still lurking there, only hitting under different conditions.

I did the bisect anyway, the race was fixed between 2.6.28 and 2.6.29-rc1.
Here "bad" really means "doesn't have a bug" and "good" means "does have 
the bug", because bisect tool was written to search for bugs that were 
created, not fixed. "X" means "doesn't work, I guessed".

bad:    47676   590cf28580c999c8ba70dc39b40bab09d69e2630
bad:    61357   0191b625ca5a46206d2fb862bb08f36f2fcb3b31
bad:    61391   54a696bd07c14d3b1192d03ce7269bc59b45209a
bad:    61578   bb26c6c29b7cc9f39e491b074b09f3c284738d36
good:   65849   a65056205cdf7efb96fb2558e4f1ec6bae2582ed
good:   61638   cb10ea549fdc0ab2dd8988adab5bf40b4fa642f3
good:   113707  745ca2475a6ac596e3d8d37c2759c0fbe2586227 - X
good:   66223   d8a5e2e9f4e70ade136c67ce8242f0db4c2cddc7
bad:    86684   94d6a5f7341ebaff53d4e41cc81fab37f0d9fbed
good:   112956  e50a906e0200084f04f8f3b7c3a14b0442d1347f
bad:    102852  6ded6ab9be4f6164aef1c527407c1b94f0929799
bad:    109140  7596b27dbd8de7bcfa7a80b2756114b49bd5c018
bad:    111150  f3a5c547012a09f38f7c27b17a8e3150b69cd259

I very much don't understand the bisect tool, I thought that it will do a 
binary search between the entries in the ChangeLog file, but it skips very 
randomly (the second columnt is the line in the ChangeLog file).

How does it really work? Do you know how to interpret it and which patch 
really fixed the bug?

Mikulas
