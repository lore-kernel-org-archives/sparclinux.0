From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jan 2011 19:52:53 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <20110126.115253.193722576.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 26 Jan 2011 18:02:22 +0100

> I have made an first implementation on the LEON, the hangs that I
> could trigger quite easily are now gone and I can run my system for
> several days without rather heavy load, however I still have some
> problems on another board, but I don't think they are directly
> related...
> 
> Please look at my implementation suggestion (patches in separate email
> soon), I have tried to separate the patches so that it will be easier
> to implement it for other CPU models, however I don't really know the
> other architectures... it would be nice if someone else could have
> look at it and someone how has the hardware...
> 
> I have removed the use of smp_cross_call in smp_call_function* and
> instead used the generic implementation by defining
> USE_GENERIC_SMP_HELPERS, I think this is the cleanest approach.

Thanks so much for doing this work!

I'll take a look at your patches soon.
