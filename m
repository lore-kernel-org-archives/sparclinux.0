From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 19 Jun 2017 06:54:15 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170619065415.GC28760@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Eric!

On Mon, Jun 19, 2017 at 08:47:47AM +0200, Eric Botcazou wrote:
> The Solaris maintainer ported Cilk++ (https://en.wikipedia.org/wiki/Cilk) to 
> the SPARC architecture for GCC 7 and later, which explains why the issue 
> doesn't show up with GCC 6.  Cilk++ is a multithreading layer on top of C and 
> C++ and its testsuite does a lot of thread manipulation.
> 
> Note that, even when the machine doesn't freeze, the Cilk++ testsuite reports 
> several timeouts (there are no such timeouts on Solaris):
>   https://gcc.gnu.org/ml/gcc-testresults/2017-06/msg00462.html

Thanks for the explanation. We're now just disabling cilk on Debian
for gcc-7 and gcc-snapshot for the time being.

> This is probably the most promising angle of attack: someone should look into 
> the timeouts by running the Cilk++ testsuite with low/no parallelism and find 
> out where they come from (compiler, Cilk++ runtime or system/kernel).  I can 
> do it, but I'm essentially a compiler guy and I don't have much expertise in 
> multithreading at the system/kernel level.

Ok, I hope that will help the kernel guys to figure out what the
problem is.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
