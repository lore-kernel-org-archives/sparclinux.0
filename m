From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Tue, 29 Dec 2015 20:01:08 +0000
Subject: 4.4-rc kernels only use one of two CPUs on Sun Blade 2500
Message-Id: <22146.59012.540193.349474@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Something is causing the 4.4-rc kernels to only use half the CPU
capacity of my Sun Blade 2500 (dual USIIIi).  The kernel does detect
both CPUs, but it doesn't seem to want to schedule processes on
both of them.  During CPU-intensive jobs like GCC bootstraps, 'top'
indicates the machine is 50% idle and aggregate CPU usage is 100%
(should be 200%).  This is completely deterministic.

Going back to 4.3.0 resolves the problems.

Any ideas?  I'll try a git bisect, but it's going to take a while
on this old HW.

The 4.4-rc .config is my working 4.3 .config + make oldconfig with
default answers (mostly N) to all new options -- I diffed them and
didn't see anything suspicious.

I also didn't find anything suspicious in the kernel log.

/Mikael
