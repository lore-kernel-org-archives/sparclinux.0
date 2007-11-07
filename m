From: Bernd Zeimetz <bernd@bzed.de>
Date: Wed, 07 Nov 2007 14:35:42 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4731CD3E.3070201@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> But I did the artificial tests, like running dpkg-query --search libc.so.6
> in loops, and this seems to work well. Thanks a lot!
> 

I was running aptitude -u in a loop for half an hour now, and it didn't
crash, so I assume that fixed the bug. Many thanks for the patch David!

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
