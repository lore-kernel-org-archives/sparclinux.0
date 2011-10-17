From: David Miller <davem@davemloft.net>
Date: Mon, 17 Oct 2011 00:56:52 +0000
Subject: Re: longjmp question
Message-Id: <20111016.205652.2113001929982036357.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 16 Oct 2011 18:07:38 +0100

> Assuming that the analysis is correct, and memcpy does receive correct 
> arguments, it might be a bug in __memcpy_ultra3 (which would be very 
> exciting :-). If you are using an UltraSparc III machine as well, and 
> could try it on a different architecture, I would be a very interested 
> in the result.

I reproduced your crash last week on a Niagara3 system, therefore I
don't think it is dependent upon the memcpy implementation.

If you are still convinced it is some memcpy issue :-) I can only
suggest that you check those buffer pointers passed to memcpy, if
(given the size) they overlap at all, that would be a bug.  You can't
use memcpy() for overlapping buffers, one must use memmove() instead.
