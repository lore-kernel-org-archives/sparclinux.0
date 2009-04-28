From: David Miller <davem@davemloft.net>
Date: Tue, 28 Apr 2009 09:01:09 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090428.020109.216217114.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303.163713.131742043.davem@davemloft.net>
	<20090427152051.5067e888.akpm@linux-foundation.org>
	<fa686aa40904272059q604d61c5u1fe584a2166545f1@mail.gmail.com>
In-Reply-To: <fa686aa40904272059q604d61c5u1fe584a2166545f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: monstr@monstr.eu, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com, smaclennan@pikatech.com, sparclinux@vger.kernel.org, akpm@linux-foundation.org, tpiepho@freescale.com, john.williams@petalogix.com

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Apr 2009 21:59:39 -0600

>     of: make of_(un)register_platform_driver common code.
> 
>     Some drivers using of_register_platform_driver() wrapper break on sparc
>     because the wrapper isn't in the header file.  This patch moves it from
>     Microblaze and PowerPC implementations and makes it common code.
> 
>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Looks great:

Acked-by: David S. Miller <davem@davemloft.net>
