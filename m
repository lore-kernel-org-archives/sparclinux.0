From: Heitzso <heitzso@growthmodels.com>
Date: Thu, 05 May 2005 10:05:31 +0000
Subject: ss20/ross/smp
Message-Id: <4279EFEB.2070705@growthmodels.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Some data points in case they are useful.

On a current gentoo ss20 (512M ram, standard internal scsi)
with dual hypersparc (ross) 150s, I can compile SMP current
2.4.30 stable kernel (pulled down from kernel.org, no extra patches)
and it seems to be running stable SMP provided I don't attempt to
run X (xorg is what's on the box, via gentoo).  With xorg X running
the system locks up after awhile (few minutes to an hour or so,
seems to depend on how much I'm trying to do).

I'm compiling current 2.6.x stable (again from kernel.org) now
just to get a baseline.  It seems to have SMP disabled in the
config in a way that would have to be manually edited to enable.

I'm not in a position to do in-the-guts debugging by myself
of SMP sparc32/ross issues.  BUT, am quite willing to download
kernels, patches, etc. and run tests, report on those tests, etc.
Just let me know.



Heitzso


