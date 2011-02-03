From: David Miller <davem@davemloft.net>
Date: Thu, 03 Feb 2011 08:51:33 +0000
Subject: Re: [PATCH 1/2 v2] sparc32: implement SMP IPIs using the generic
Message-Id: <20110203.005133.71118133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 03 Feb 2011 09:50:05 +0100

> David Miller wrote:
> 
>>Ok, this looks mostly fine to me.
>>
>>Once we have the sun4m/sun4d versions written I can think about
>>applying this.
>>
>>We might want to abstract out the common code of the dispatch and
>>service stuff you have for LEON, otherwise we'll have 3 copies of
>>that code that sets and clears the mask state.
>>
>>Perhaps something using BTFIXUP or similar.
>>  
> I was thinking so too, BTFIXUPs for CPU model specific "IPI
> operations" to avoid the switch-statement in the arch_ functions.

Exactly.
