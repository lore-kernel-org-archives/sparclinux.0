From: Meelis Roos <mroos@linux.ee>
Date: Fri, 06 Feb 2009 12:38:25 +0000
Subject: Re: hang on panic, can not return to OBP
Message-Id: <Pine.SOC.4.64.0902061435590.10784@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> What kind of console are you on?
> 
> For serial consoles, you have to send BREAK twice.

I'm on serial console:
[  129.237799] f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
[  129.237925] Console: ttyS0 (SunZilog zs0)
[  129.238289] console [ttyS0] enabled

Strange that this time (fresh todays git kernel with no changes) I can 
use BREAK successfully - and I only need to send it once from minicom 
(^A F).

-- 
Meelis Roos (mroos@linux.ee)
