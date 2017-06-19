From: Eric Botcazou <ebotcazou@libertysurf.fr>
Date: Mon, 19 Jun 2017 06:47:47 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <1577186.YNi7BlrOG7@polaris>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > All of my testing is being done with gcc-6.3 vanilla and current
> > kernels, and in fact I'm doing parallel "make -j128" gcc and glibc
> > testsuite runs and not hitting any problems at all.
> 
> According to Eric Botcazou from gcc upstream, we most likely know the
> culprit now. Eric noticed that the issue occurred within the cilk-plus
> testsuite and by passing --disable-libcilkrts to configure, the testsuite
> finished without problems, even with -j32.

The Solaris maintainer ported Cilk++ (https://en.wikipedia.org/wiki/Cilk) to 
the SPARC architecture for GCC 7 and later, which explains why the issue 
doesn't show up with GCC 6.  Cilk++ is a multithreading layer on top of C and 
C++ and its testsuite does a lot of thread manipulation.

Note that, even when the machine doesn't freeze, the Cilk++ testsuite reports 
several timeouts (there are no such timeouts on Solaris):
  https://gcc.gnu.org/ml/gcc-testresults/2017-06/msg00462.html

This is probably the most promising angle of attack: someone should look into 
the timeouts by running the Cilk++ testsuite with low/no parallelism and find 
out where they come from (compiler, Cilk++ runtime or system/kernel).  I can 
do it, but I'm essentially a compiler guy and I don't have much expertise in 
multithreading at the system/kernel level.

-- 
Eric Botcazou
