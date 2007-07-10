From: seb@frankengul.org
Date: Tue, 10 Jul 2007 11:26:41 +0000
Subject: dpkg-query hangs again
Message-Id: <20070710112641.GA23043@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I got another hang on another machine with the same symptoms.

	1- dpkg-query is stuck in R state with a RSS of 1405M (or 1409).
	2- the process is not killable
	3- the process eats all cpu (load was near 75)
	4- strace on the process shows nothing (no syscall waiting)
	5- One cannot halt the machine (must push the power button to stop it)

The problem happened on 
	1- an U60 with 1.5Go of ram and 2 Uii at 300Mhz.
	2- a SUN Blade 2000 with 4Go of RAM and 2 Uiii at 900Mhz.

In each case, the problem happened at the same place :
	When building a Mono packages, at the dh_shlibdeps -s stage when building the packages.
The hangs is not fully reproductible but if it happens, it's there.

It's like the process cause an infinite loop in the kernel.

	Seb
