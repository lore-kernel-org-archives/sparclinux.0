From: Meelis Roos <mroos@ut.ee>
Date: Sat, 13 Sep 2008 18:32:58 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809132131190.3619@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I can not understanda what I have right now - I applied to what I think 
> was the right kernel, the resulting kernel hung like below. Then I 
> reversed the hme patch and the resulting kernel still hangs the same 
> way. Maybe I botched something... anyway, here is the hang. An by the 
> way, it used to stop at {6} ok, now it's {7} ok so it's a different CPU.

Hmm, I'm really stuck now. Fetched clean 2.6.27-rc6, applied the 
patches, hangs with or without hme debug patch like before. no "debug" 
on -p or console=prom results in anything more.

Ideas?

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
