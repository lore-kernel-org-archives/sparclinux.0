From: David Miller <davem@davemloft.net>
Date: Sat, 31 May 2008 21:19:48 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20080531.141948.193702968.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Sat, 31 May 2008 11:02:38 +0200 (CEST)

> Hi
> 
> I have an Ultra 5 (360MHz, 256MB) with kernel 2.6.25.4 and I see userspace 
> process crashes when I run kernel compiled with preempt. The crashes 
> happen once in few hours, a good test for them is to compile kernel in a 
> loop --- the crashes happen in cc1 or as.

Thanks for the report, I remember you mentioning this at
LinuxTAG the other day.

> BTW. I saw another problem --- when I compile kernel with 64kB pages, it 
> crashes on load (it doesn't even switch to Linux console) ... is it known 
> problem?

It's known to be broken.  I simply suggest that people not try
to use such esoteric features until I have a lot of time to
try and either make them work or remove them.
