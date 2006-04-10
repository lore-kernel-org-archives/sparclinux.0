From: Christophe Jacquet <jacquetc@free.fr>
Date: Mon, 10 Apr 2006 09:11:55 +0000
Subject: Re: Parallel port problems on Sun Ultra10
Message-Id: <1144660315.443a215b81270@imp1-g19.free.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <1144596830.4439295e52873@imp1-g19.free.fr>
In-Reply-To: <1144596830.4439295e52873@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

> this reminds me of a problem I had a few week ago while playing with
> an homebuild parallel port project. The machine would lock totally, but
> as soon as I disconnected the circuit from the port the machine would
> unlock.
>
> Maybe you could try disconnecting the printer and see what happens?

I reproduced the steps described in my previous post, but I tried various things
after the machine froze:

1) I swicthed off the printer's power supply: the machine remained frozen,
2) I disconnected the printer cable: the machine remained frozen,
3) I switched on the printer again, and I reconnected the cable: the machine
remained frozen.

So the machine seems to be locked for good after doing a write() to /dev/lp0.


Regards,

Christophe Jacquet.
