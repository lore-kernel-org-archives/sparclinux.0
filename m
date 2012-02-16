From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Feb 2012 19:53:14 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <alpine.SOC.1.00.1202162151030.16208@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee> <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca>
In-Reply-To: <20120213214623.GJ11077@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> Ugh; that looks bad.  If it failed there, then the global device node list
> is corrupted.  I hate to ask you this, but would you be able to git bisect to
> narrow down the commit that causes the problem?

Finished bisecting on E2500 (the original machine where I found the 
problem). Bisecting leads to
[0ee332c1451869963626bf9cac88f165a90990e1] memblock: Kill early_node_map[]
So yes, it looks like memblock.

-- 
Meelis Roos (mroos@linux.ee)
