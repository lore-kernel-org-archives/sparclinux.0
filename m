From: Meelis Roos <mroos@linux.ee>
Date: Thu, 08 May 2014 20:32:51 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405082307120.27832@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Oh I see, the bug didn't even exist.  In __tsb_context_switch the
> > address is adjusted properly when the huge TSB mapping is installed in
> > the TLB.  So there's no bug at all. :-/
> 
> I take this back, the __tsb_context_switch() does DOES NOT adjust
> the virtual address, it uses the one provided by the TSB config
> structure.
> 
> So the bug is very real.
> 
> Meelis can you double check that you had this patch installed and
> booted kernels built with the change present on those machines?

Each machine compiles and boots its own kernel (self-hosting for test 
coverage purposes), patch is still applied on all of them, vmlinuz is 
later than the patch, the latest kernel was booted up as vwrified with 
last -10.

Verified it on V100 - checked patch is still applied, reran make (it did 
not touch vmlinux because it as up to date), reinstalled kernel and 
modules, booted it up and tested with git.

Unfortunately it still hangs :(

In addition to these four computers, I also tested E220R in the morning 
with fresh git + the patch and it also failed git clone test.

-- 
Meelis Roos (mroos@linux.ee)
