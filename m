From: David Miller <davem@davemloft.net>
Date: Tue, 27 Feb 2007 05:29:02 +0000
Subject: Re: sparc64 / bbc_i2c.c
Message-Id: <20070226.212902.78711266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0702252352310.32309@parallax.ddns.shef.ac.uk>
	<20070226.101219.18306730.davem@davemloft.net>
	<20070227052239.GA30083@stardust.friedrich-kn.de>
In-Reply-To: <20070227052239.GA30083@stardust.friedrich-kn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joerg.Friedrich@friedrich-kn.de
Cc: j.j.green@sheffield.ac.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Joerg Friedrich <Joerg.Friedrich@friedrich-kn.de>
Date: Tue, 27 Feb 2007 06:22:39 +0100

> Can you just tell me if it's sufficient to check for  a return value >0
> of wait_event_interruptible_timeout? I was not sure so I extended the
> check to 
> if ((val != -ERESTARTSYS) && (val > 0))

I changed the check to just "val > 0".

The comments in the kernel around the implementation and
declaration of the function wait_event_interruptible()
VERY CLEARLY state that the possible return values are:

1) Negative error code on interrupt
2) Zero if timeout expired
3) Positive non-zero value if condition became true before
   timeout expired

So there is no doubt that "val > 0" is sufficient.
