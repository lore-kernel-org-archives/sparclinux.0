From: David Miller <davem@davemloft.net>
Date: Wed, 16 Sep 2009 22:32:21 +0000
Subject: Re: [PATCH v2] sparc: Clean up linker script using new linker
Message-Id: <20090916.153221.257687176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.1.10.0909161322260.2942@dr-wily.mit.edu>
	<20090916.103019.253722423.davem@davemloft.net>
	<alpine.DEB.1.10.0909161332190.2942@dr-wily.mit.edu>
In-Reply-To: <alpine.DEB.1.10.0909161332190.2942@dr-wily.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tabbott@ksplice.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, geofft@ksplice.com

From: Tim Abbott <tabbott@ksplice.com>
Date: Wed, 16 Sep 2009 14:03:48 -0400 (EDT)

> On Wed, 16 Sep 2009, David Miller wrote:
> 
>> It's hard for me to ACK this because it's not a straight nop
>> transformation, which we could at least presume would function
>> properly if the macros were implemented correctly.
> 
> Would it help if I were to split the patch into first rearranging the code 
> to look like the macros and then applying the macros, so that you can see 
> more easily exactly what is changing?

No, it wouldn't :-)  The issue is that I can't just say from
reading the patch that it will absolutely work.

But I'm willing to take the risk and we can revert if testing
shows it breaks things, so:

Acked-by: David S. Miller <davem@davemloft.net>
