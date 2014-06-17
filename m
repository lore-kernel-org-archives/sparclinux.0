From: Meelis Roos <mroos@linux.ee>
Date: Tue, 17 Jun 2014 15:50:54 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1406171849240.12946@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > > Since V100 has LOM (remote lights-out management), I could test it more
> > > > easily and decided to bisect it.
> > >
> > > Is still only with the SLAB allocator and modular CONFIG_SUN_OPENPROMFS?
> >
> > Yes, SLAB with modular openpromfs. Non-modular openpromfs or SLUB with
> > debugging do not trigger it, and SLUB debugging does not show anything.
> > Switching back to SLAB reproduced it again.
> 
> SLAB's handling of numa is a bit more complicated than SLUBs. Could this
> be related to yet another exotic NUMA configuration with nodes that are
> flagged to have memory and have none etc?

V100 is a single-CPU entry-level cheap server with UltraSparc IIi CPU 
and ALI Aladdin IV southbridge&co. So no SMP (UP configuration), no 
NUMA.

-- 
Meelis Roos (mroos@linux.ee)
