From: Meelis Roos <mroos@linux.ee>
Date: Tue, 14 Jun 2011 10:39:03 +0000
Subject: Re: 3.0-rc3: Kernel unaligned access at end_writeback+0x38
Message-Id: <alpine.SOC.1.00.1106141338270.16316@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106141331430.16316@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106141331430.16316@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> Tested 3.0-rc3 on a sparc64 machine and got loads of these warnings:
> 
> [   71.909647] Kernel unaligned access at TPC[4d95b8] end_writeback+0x38/0xc0

Another machinbe also shows
Kernel unaligned access at TPC[4ee800] iget_locked+0x60/0x160
with 3.0.rc2-0400-...

-- 
Meelis Roos (mroos@linux.ee)
