From: David Miller <davem@davemloft.net>
Date: Tue, 30 Oct 2007 01:35:30 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071029.183530.165919100.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 01:50:30 +0100

> What we're missing here is a probably important piece:
> 
> If dpkg-query is running during a build, it is running in a fakeroot
> environment. I've straced that, see the attachment.
> 
> What I find in the strace are at least several clones, which is the
> point where aptitude -u crashed according to the straces in
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bugC3187#102

Thanks for the fakeroot trace.

I am pretty sure the clone()'s we see here are just normal
fork()'s, in both the fakeroot's dpkg-query and the aptitude
case.

I'll go study up on fakeroot's implementation to look for
potential clues.

