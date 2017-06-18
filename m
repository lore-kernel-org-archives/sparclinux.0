From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 18 Jun 2017 19:59:49 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <ccf52774-8dcf-8a1c-7d47-a9f9c87166d1@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/04/2017 10:30 PM, David Miller wrote:
> Ok, please report this again with a simple reproducable test case
> and I will try to reproduce it and work on it here.
> 
> All of my testing is being done with gcc-6.3 vanilla and current
> kernels, and in fact I'm doing parallel "make -j128" gcc and glibc
> testsuite runs and not hitting any problems at all.

According to Eric Botcazou from gcc upstream, we most likely know the
culprit now. Eric noticed that the issue occurred within the cilk-plus
testsuite and by passing --disable-libcilkrts to configure, the testsuite
finished without problems, even with -j32.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
