From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 04 Feb 2011 13:39:31 +0000
Subject: sparc32 linux SMP
Message-Id: <4D4C0193.2020900@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello all,

I just want to report that we have been able to run the SPEC2000 integer 
tests successfully on Linux SMP 2.6.38-rc1. After 2-3 days of running 
the tests (users=2) on a dual core LEON@70MHz on Debian Etch, the 
results were correct. Two months ago I was able to run for 1-2 minutes 
before the system crashed in different ways or hanged.

Thanks all,
Daniel
