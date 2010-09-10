From: David Miller <davem@davemloft.net>
Date: Fri, 10 Sep 2010 18:36:55 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20100910.113655.108788405.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 10 Sep 2010 14:31:27 -0400 (EDT)

> I very much don't understand the bisect tool, I thought that it will do a 
> binary search between the entries in the ChangeLog file, but it skips very 
> randomly (the second columnt is the line in the ChangeLog file).
> 
> How does it really work? Do you know how to interpret it and which patch 
> really fixed the bug?

When there are multiple lines of development, it has to hop in and out
of the merged branches.

Sometimes that aspect can make it go "out of order".

The best you can do is do the full bisect, trust what it comes up
with, and start your analysis with the commit it comes up with after
the whole bisect is complete.

What commit did it print out when you completed the bisect run?

Also, there is another problematic case, sometimes bisect gives you
a merge commit.  And this means that in the tree in which the
development of the branch was done, the bisect condition doesn't
trigger, but once it gets integrated into what happened upstream
meanwhile, it does trigger.
