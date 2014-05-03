From: Meelis Roos <mroos@linux.ee>
Date: Sat, 03 May 2014 06:16:16 +0000
Subject: Re: [PATCH 0/10] Sparc64 MM bug fixes
Message-Id: <alpine.SOC.1.00.1405030912160.5960@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175420.1944889075484067093.davem@davemloft.net>
In-Reply-To: <20140430.175420.1944889075484067093.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Anyways, please let me know how well these patches work and if they
> > make any difference for your problems at all.  THP enabled and THP
> > disabled results are both extremely useful.
> 
> Preliminary results from 4 computers are positive.

Of there 4, 3 performed debian update with aptitude successfully. V100 
hung after
Preconfiguring packages ...

nothing on console either.

This may or may not be related to the THP problem - V100 and X1 have 
sometimes occassionally rebooted by themselves, I think even with THP 
off. I have not had time to narrow it down to something specific - my 
last suspicion was tulip driver (lots of local IDE activity did not 
trigger it, lots of network activity seemed to have some probability of 
triggering it).

-- 
Meelis Roos (mroos@linux.ee)
