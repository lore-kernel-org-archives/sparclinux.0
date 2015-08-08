From: Meelis Roos <mroos@linux.ee>
Date: Sat, 08 Aug 2015 18:59:48 +0000
Subject: Re: Occasional userland crashes on sparc in 4.1.0+
Message-Id: <alpine.LRH.2.20.1508082156000.9527@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507271430410.23956@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1507271430410.23956@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Additionally, v240 still sees the possible irq lock inversion dependency 
> as reported in https://lkml.org/lkml/2015/5/11/348 but this is probably 
> not related.

Today I also got a spontaneous reboot and a hang from the same V240, one 
from 4.2.0-rc3+ and one from todays 4.2.0-rc5+ kernel.

-- 
Meelis Roos (mroos@linux.ee)
