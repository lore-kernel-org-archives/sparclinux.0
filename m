From: David Miller <davem@davemloft.net>
Date: Fri, 09 Oct 2009 23:21:20 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <20091009.162120.164441279.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <505766fa0909230040m13e3dc34x2ceb83848767d825@mail.gmail.com>
	<505766fa0909231903t2fe2f7b6y26d2681d6d38ef0e@mail.gmail.com>
	<20091009.150829.218507309.davem@davemloft.net>
In-Reply-To: <20091009.150829.218507309.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: heyongli@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 09 Oct 2009 15:08:29 -0700 (PDT)

> Thank you for this bug report and patch, I am looking at
> it now.

I'm trying to figure out how the deadlock can even occur,
and I've failed so far, please help me :-)

See, we always take the VIO and LDC locks in the same order
(VIO then LDC) and always with interrupts disabled, so it is
not possible to deadlock.

The only way we could deadlock is if:

1) There is some path that takes the LDC lock before the VIO one.

2) There is some path that takes either lock with interrupts
   enabled.

And I cannot find any such case.

It might help if you run your test case with lockdep enabled.  It will
find such deadlocks and report them precisely to the kernel logs.

Thank you!
