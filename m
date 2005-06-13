From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Jun 2005 21:26:19 +0000
Subject: Re: Working config wanted for 2.6.11, Ultra 5, sparc64
Message-Id: <20050613.142619.21926866.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
In-Reply-To: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Jun 2005 14:56:49 -0600 (MDT)

> As for LCDs, in times past to get my Samsung 17" LCD to work, I had to 
> specify both an OBP level resolution and refresh rate as well as in the 
> kernel arguments for the atyfb driver (since atyfb doesn't always seem to 
> respect the OBP defined rates).
> 
> The OBP setting that worked in my case was 
> output-device=screen:r1280x1024x60 and the kernel argument was 
> video=atyfb:1024x768@60 (never did quite get a 1280x1024 console going).

Ok.  This is very peculiar because there was a long'ish
thread where we specifically fixed ATY in the 2.6.x kernel
to adhere to the OBP settings precisely.

There are, obviously, some holes still in this area.
Ho hum...

Thanks for the data.
