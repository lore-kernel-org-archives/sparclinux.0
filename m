From: David Miller <davem@davemloft.net>
Date: Wed, 18 May 2011 21:03:52 +0000
Subject: Re: [PATCH 2/2] drivercore: revert addition of of_match to struct
Message-Id: <20110518.170352.92788672093555496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110518185751.28986.69446.stgit@ponder>
	<20110518192105.28986.53198.stgit@ponder>
In-Reply-To: <20110518192105.28986.53198.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org, miltonm@bga.com, sparclinux@vger.kernel.org, torvalds@linux-foundation.org, joy@entuzijast.net

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 13:21:05 -0600

> Commit b826291c, "drivercore/dt: add a match table pointer to struct
> device" added an of_match pointer to struct device to cache the
> of_match_table entry discovered at driver match time.  This was unsafe
> because matching is not an atomic operation with probing a driver.  If
> two or more drivers are attempted to be matched to a driver at the
> same time, then the cached matching entry pointer could get
> overwritten.
> 
> This patch reverts the of_match cache pointer and reworks all users to
> call of_match_device() directly instead.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Tested on SunBlade2500 and Niagara2+

Acked-by: David S. Miller <davem@davemloft.net>
