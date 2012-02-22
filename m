From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Feb 2012 17:12:06 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <alpine.SOC.1.00.1202221910420.17363@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee> <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202162151030.16208@math.ut.ee>
 <alpine.SOC.1.00.1202201109260.467@math.ut.ee> <20120220170603.GC7836@mtj.dyndns.org> <alpine.SOC.1.00.1202210030530.11350@math.ut.ee> <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com> <20120222170330.GA29521@merkur.ravnborg.org>
In-Reply-To: <20120222170330.GA29521@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tejun Heo <tj@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

> Meelis - do the affected boxes have any special memory configurations?

Nothin special to me. E3500 has 2G, V100 has 1G, V210 and V240 have 2G 
and 1.5G.

> Could you try to boot with a sensible mem=xxx value to see if limiting the memory
> helps.

Like mem%6M? Will try.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
