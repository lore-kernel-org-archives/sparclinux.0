From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 06 May 2005 00:42:51 +0000
Subject: Re: [gentoo-sparc] ss20/ross/smp
Message-Id: <20050506004251.GB8336@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 05, 2005 at 06:05:31AM -0400, Heitzso wrote:

> I'm compiling current 2.6.x stable (again from kernel.org) now
> just to get a baseline.  It seems to have SMP disabled in the
> config in a way that would have to be manually edited to enable.

Um, because it's completely busted?

> I'm not in a position to do in-the-guts debugging by myself
> of SMP sparc32/ross issues.  BUT, am quite willing to download
> kernels, patches, etc. and run tests, report on those tests, etc.
> Just let me know.

In the year-plus since you first posted this you could have read, at a
leisurely pace, the entire sparcv8 manual five times and the Linux
smp4m implementation twenty.  And if you had, you would be able to fix
the problem instead of testing someone else's nonexistent fixes.
These machines cost, what, ten bucks now?  I guarantee you the
limiting factor isn't testing resources.

If you want this port to live, get hacking.  If you get stuck, there
are people here who can and often will answer your questions.
Otherwise it's not much use posting periodically to remind people that
you'd like it fixed but aren't willing to do any of the work needed to
make that happen.

-- 
Keith M Wesolowski

If at first you don't succeed, destroy all evidence that you tried.
