From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 20 Feb 2008 05:29:55 +0000
Subject: Re: [PATCH] [LMB]: Fix lmb_add_region if region should be added at the head
Message-Id: <1E43CE53-98E0-4D98-9629-9E3336A25BAE@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
	<20080219.204525.193731674.davem@davemloft.net>
	<7A7ECF09-E547-4C04-A388-C3E8755478DD@kernel.crashing.org>
	<20080219.212655.173468988.davem@davemloft.net>
In-Reply-To: <20080219.212655.173468988.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


On Feb 19, 2008, at 11:26 PM, David Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Tue, 19 Feb 2008 23:16:18 -0600
>
>> The for loop above the code I added will move all the existing slots
>> up one.  Its just the tail cleanup we are missing.
>
> Aha, I see how this works now, thanks!
>
> I'll add this to my LMB tree.

Sounds good.  Now just convince Paul or Linus to pull this in for  
2.6.25 :)

- k
