From: David Miller <davem@davemloft.net>
Date: Wed, 18 May 2011 21:03:40 +0000
Subject: Re: [PATCH 1/2] of: fix race when matching drivers
Message-Id: <20110518.170340.1970357603006374415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110518185751.28986.69446.stgit@ponder>
	<20110518192100.28986.94335.stgit@ponder>
In-Reply-To: <20110518192100.28986.94335.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org, miltonm@bga.com, sparclinux@vger.kernel.org, torvalds@linux-foundation.org, joy@entuzijast.net

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 13:21:00 -0600

> From: Milton Miller <miltonm@bga.com>
> 
> If two drivers are probing devices at the same time, both will write
> their match table result to the dev->of_match cache at the same time.
> 
> Only write the result if the device matches.
> 
> In a thread titled "SBus devices sometimes detected, sometimes not",
> Meelis reported his SBus hme was not detected about 50% of the time.
>>From the debug suggested by Grant it was obvious another driver matched
> some devices between the call to match the hme and the hme discovery
> failling.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> [grant.likely: modified to only call of_match_device() once]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Tested on SunBlade2500 and Niagara2+

Acked-by: David S. Miller <davem@davemloft.net>
