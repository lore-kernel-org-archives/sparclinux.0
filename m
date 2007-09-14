From: David Carlton <david.carlton@sun.com>
Date: Fri, 14 Sep 2007 17:20:56 +0000
Subject: Re: Is Sun putting much effort into supporting the gcc/binutils
Message-Id: <yf2d4wltb7r.fsf@luai12.SFBay.Sun.COM>
List-Id: <sparclinux.vger.kernel.org>
References: <46E7CF5F.3090909@walrond.org>
In-Reply-To: <46E7CF5F.3090909@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 14 Sep 2007 09:27:38 -0700, Joe Buck <Joe.Buck@synopsys.COM> said:

> Like most tech companies that have seen better days, Sun's been
> cutting costs to the bone; I'm sure that they don't feel rich.

This is true.  I'm not sure how many rounds of layoffs we've had over
the last five years, but there were many, and I'm not completely sure
that we're done.

It's also true that we're not behaving as well as we should in this
situation.  I've forwarded several messages in this thread to people
at Sun who might be in a position to make a difference: from where I
sit, it looks like a situation where having a few of our engineers
contributing directly to these segments of the open source community
would help a lot.

Also from where I sit, Sun is trying to do the right thing.  We've
been consistently open sourcing key components of our software for
some time now, and are trying (not always successfully, we have a
learning curve like everybody else) to build new communities and
participate in existing ones.  And we're trying to be as open to
mixing and matching as we possibly can: we'd prefer for you to run
Solaris on Sun hardware (I was going to write on Sparc, but we're
actually quite agnostic on the x86/Sparc choice these days), but we're
more than happy to sell you Sun hardware where you run your choice of
OS on it (Solaris, a few versions of Linux, and we even announced a
Windows OEM deal last week), and we're also quite happy to have you
run Solaris on other people's hardware (see the IBM Solaris
announcement last month).  And if you run other OSes on other
hardware, well, that's a learning opportunity for us, but would you
like to run Java?  Or maybe just the JVM with, say, JRuby on top?  Or
use OpenOffice?  And if you want to build your own box with our chip
design, that's great too!

But obviously we're not doing a perfect job; in particular, we're
clearly not doing as good a job on the Sparc + Linux quadrant as we
should.  Please continue to try to keep us honest, but do so with the
realization that we're fallible, we're resource-constrained, and we
can't do everything at once.

I am speaking purely as an individual; I am currently employed by Sun,
and I have a soft spot for GCC (I used to work on GDB before being
hired by Sun), but my current work is completely unrelated to compiler
toolchain issues.  (Other than as a user!)  And I have no particular
influence on Sun's resource allocation or open source behavior.

David Carlton
david.carlton@sun.com
