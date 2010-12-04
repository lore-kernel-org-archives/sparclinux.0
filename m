From: David Miller <davem@davemloft.net>
Date: Sat, 04 Dec 2010 19:53:30 +0000
Subject: Re: [PATCH] sparc64: Netra AX1105 loses console output while
Message-Id: <20101204.115330.193707625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101107132051.GE19881@here>
In-Reply-To: <20101107132051.GE19881@here>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrien Mazarguil <maz@p0d.org>
Date: Sat, 4 Dec 2010 10:34:54 +0100

> On Fri, Dec 03, 2010 at 10:18:08AM -0800, David Miller wrote:
>> > This is a larger can of worms than just these two console I/O
>> > routines, let me do the audit and I'll give you a patch to test.
>> 
>> Sorry for taking so long.
>> 
>> I have a set of patches which fix this problem, I'll post
>> them with you CC:'d so you can test them out.
> 
> Thanks! I applied them to the current kernel head, compiled for sparc64 and
> tested on my board (Netra AX1105). Works perfectly.

Thanks for your report, patience, and testing.
