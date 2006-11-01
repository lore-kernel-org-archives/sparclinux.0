From: Meelis Roos <mroos@linux.ee>
Date: Wed, 01 Nov 2006 12:27:45 +0000
Subject: Re: serial port registration messages
Message-Id: <Pine.SOC.4.61.0611011425210.13157@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0610311728060.27442@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0610311728060.27442@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> It's not just about buffer sizes, it's about uniqueness
> and the only unique thing amongst all PROM devices is
> the PROM node number, so that's what we must use as the
> ID.

Hmm, I still do not undestand. The numbers dmesg shows are still equal 
to each other so they are about the same prom node. Is somewhere another 
prom node with the same name that is not printed and used for serial?

Or, do we check the prom names and it they match for several nodes then 
use the node number instead of the name?

-- 
Meelis Roos (mroos@linux.ee)
