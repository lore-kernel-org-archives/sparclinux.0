From: Tejun Heo <tj@kernel.org>
Date: Mon, 20 Feb 2012 21:01:38 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120220210138.GB3538@dhcp-172-17-108-109.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee>
 <20120213080618.GA11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202131119040.1488@math.ut.ee>
 <20120213214623.GJ11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202162151030.16208@math.ut.ee>
 <alpine.SOC.1.00.1202201109260.467@math.ut.ee>
 <20120220170603.GC7836@mtj.dyndns.org>
 <alpine.SOC.1.00.1202202203590.4196@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202202203590.4196@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, sam@ravnborg.org

Hello,

On Mon, Feb 20, 2012 at 10:04:10PM +0200, Meelis Roos wrote:
> > Hmmm.... So, different bisection results from two machines?  That's a
> > bit weird.  I *think* this bisection result makes more sense.  Can you
> > please verify the bisection result on e2500 once more?
> 
> Will do.

Thanks a lot.  I'm *suspecting* that somehow memory used to back the
device tree is not fully reserved and the change in allocation logic
is giving out it as part of allocation.  I'll look through the change
more and see if I can spot a bug in the new code but I guess we'll
probably have to print out some pointer values to find out the
offending address.

Thanks.

-- 
tejun
