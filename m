From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2016 15:42:12 +0000
Subject: Re: 4.9.0-rc6-00086-g3b404a5 seems good on my sparc64 machines
Message-Id: <alpine.LRH.2.20.1611231911120.13985@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > I tried yesterdays git 4.9.0-rc6-00086-g3b404a5 on most of my sparc64 
> > machines and found no new regressions. The tests were only simple bootup 
> > tests so far (no dist-upgrade since my userspace is stuck in debian 
> > unstable 2015).
> 
> You should be able to dist-upgrade your 2015 unstable to a current version
> of unstable without any bigger issues. You are effectively upgrading from
> release to release+1 which is normally always supported.

There is no current version for debian sparc port AFAIK.

deb http://snapshot.debian.org/archive/debian/20150725T121538Z/ unstable main contrib non-free

minus udev-related packages (downgraded to 218-8) is what I have running 
on most of them.

Debian-ports has sparc64 but so far I have understood that I can not 
just "upgrade" a 32-bit userland sparc port to sparc64 port, but rather 
do a clean install on another HDD for test.

Or have I misunderstood something?

-- 
Meelis Roos (mroos@linux.ee)
