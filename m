From: Meelis Roos <mroos@linux.ee>
Date: Tue, 17 Jun 2014 10:38:57 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1406171337210.22460@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Now while debugging a different issue on Sun Fire V100, I noticed a
> > different crash dump on reboot, showing also recursive fault from PROM
> > space. The messages are different (because of newer PROM generation?)
> > but the problem seems same, except no hang happens - that's why I had
> > not noticed it before.
> > 
> > Since V100 has LOM (remote lights-out management), I could test it more
> > easily and decided to bisect it.
> 
> Is still only with the SLAB allocator and modular CONFIG_SUN_OPENPROMFS?

Yes, SLAB with modular openpromfs. Non-modular openpromfs or SLUB with 
debugging do not trigger it, and SLUB debugging does not show anything. 
Switching back to SLAB reproduced it again.

-- 
Meelis Roos (mroos@linux.ee)
