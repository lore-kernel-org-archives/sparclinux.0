From: Meelis Roos <mroos@linux.ee>
Date: Sat, 07 Feb 2009 08:44:52 +0000
Subject: Re: hang on panic, can not return to OBP
Message-Id: <Pine.SOC.4.64.0902071043140.28855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > I'm on serial console:
> > [  129.237799] f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
> > [  129.237925] Console: ttyS0 (SunZilog zs0)
> > [  129.238289] console [ttyS0] enabled
> > 
> > Strange that this time (fresh todays git kernel with no changes) I can 
> > use BREAK successfully - and I only need to send it once from minicom 
> > (^A F).
> 
> Strange...  I have to send two breaks on hypervisor sun4v consoles.
> 
> Because the way you send Alt-SYSRQ keycodes on serial consoles
> is BREAK+sysrq_code, and that's why two breaks are necessary to
> indicate a real break into the OBP prompt.
> 
> I suspect it doesn't work for you in that other case because it's
> at a point before the serial driver has even registered yet.

I think it was registered...

Just tried with fully booted up system (E3500, console on zs serial) and 
single BREAK was enough to drop to prom ok prompt.

-- 
Meelis Roos (mroos@linux.ee)
