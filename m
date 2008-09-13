From: David Miller <davem@davemloft.net>
Date: Sat, 13 Sep 2008 23:21:31 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080913.162131.203890493.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Sat, 13 Sep 2008 21:32:58 +0300 (EEST)

> > I can not understanda what I have right now - I applied to what I think 
> > was the right kernel, the resulting kernel hung like below. Then I 
> > reversed the hme patch and the resulting kernel still hangs the same 
> > way. Maybe I botched something... anyway, here is the hang. An by the 
> > way, it used to stop at {6} ok, now it's {7} ok so it's a different CPU.
> 
> Hmm, I'm really stuck now. Fetched clean 2.6.27-rc6, applied the 
> patches, hangs with or without hme debug patch like before. no "debug" 
> on -p or console=prom results in anything more.
> 
> Ideas?

Remove the CON_BOOT flag from the PROM early console struct in
arch/sparc64/kernel/setup.c
