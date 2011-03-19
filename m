From: Meelis Roos <mroos@linux.ee>
Date: Sat, 19 Mar 2011 20:57:08 +0000
Subject: Re: 38-git2-6 -- kernel/futex.c warning
Message-Id: <alpine.SOC.1.00.1103192255440.4548@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <201103181932.p2IJW5cg002394@clem.clem-digital.net> <20110318.125808.233714688.davem@davemloft.net> <4D847191.7000806@linux.intel.com>
In-Reply-To: <4D847191.7000806@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Darren Hart <dvhart@linux.intel.com>
Cc: David Miller <davem@davemloft.net>, clem@clem.clem-digital.net, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

> > > Fyi. Have been experiencing the below since 38-git2. Continual scrolling
> > > such that cannot complete system startup. System is i386 UP, Debian
> > > "squeeze".
> > 
> > Looks similar to the problems reported by Meelis, CC:'d
> 
> yes, and the same answer, see Steven Rostedts patch set from March 17th:
> 
> [PATCH 0/2 v2] [GIT PULL] futex: Fix WARN_ON trigging on UP

And applying both his patches on top of 2.6.38-06439-g5bab188 fixed the 
problem for me.

-- 
Meelis Roos (mroos@linux.ee)
