From: Meelis Roos <mroos@linux.ee>
Date: Sat, 03 May 2014 04:45:33 +0000
Subject: Re: [PATCH 0/10] Sparc64 MM bug fixes
Message-Id: <alpine.SOC.1.00.1405030742300.5960@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175420.1944889075484067093.davem@davemloft.net>
In-Reply-To: <20140430.175420.1944889075484067093.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Anyways, please let me know how well these patches work and if they
> make any difference for your problems at all.  THP enabled and THP
> disabled results are both extremely useful.

Preliminary results from 4 computers are positive.

Ultra 2 (2x300), Netra X1, V100 and V480 (4 CPU) have survived night 
(two of them actually day+night) of
while true; do apt-get update; done
that killed the machine with 1-2 tries before. Nothing bad in dmesg. THP 
on+always on all the them for now.

-- 
Meelis Roos (mroos@linux.ee)
