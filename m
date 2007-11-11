From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 11 Nov 2007 06:27:23 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4736A0CB.6090403@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Wed, 07 Nov 2007 15:35:42 +0100
> 
>>> But I did the artificial tests, like running dpkg-query --search libc.so.6
>>> in loops, and this seems to work well. Thanks a lot!
>>>
>> I was running aptitude -u in a loop for half an hour now, and it didn't
>> crash, so I assume that fixed the bug. Many thanks for the patch David!
> 
> Many thanks for helping me track it down.

You're welcome!

The v880 is still running fine, I'll setup the stuff which was supposed
to be running on the machine during the next days, so we'll see how it
behaves under a higher load for a longer time soon.

Thanks again for looking into this annoying bug!


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
