From: Meelis Roos <mroos@linux.ee>
Date: Mon, 31 May 2004 19:29:33 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <Pine.GSO.4.44.0405312227390.17755-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Right, but why aren't you using the suncg6 frame buffer driver?

I tried to rule out as many drivers as I could.

> console=prom is not only slow, it's deadlock prone as well

Thanks for the hint, will try cg6fb tomorrow. But I switched off cg6fb
to debug the hangs so I do not have great hopes for it.

Why is prom console deadlock prone?

-- 
Meelis Roos (mroos@linux.ee)

