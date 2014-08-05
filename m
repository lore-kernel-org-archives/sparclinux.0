From: David Miller <davem@davemloft.net>
Date: Tue, 05 Aug 2014 00:06:11 +0000
Subject: Re: [PATCH] sunsab: Fix detection of BREAK on sunsab serial console
Message-Id: <20140804.170611.823016705334075877.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201408031601.53597.cat.schulze@alice-dsl.net>
In-Reply-To: <201408031601.53597.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 3 Aug 2014 16:01:53 +0200

> From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
> 
> Fix detection of BREAK on sunsab serial console: BREAK detection was only
> performed when there were also serial characters received simultaneously.
> To handle all BREAKs correctly, the check for BREAK and the corresponding
> call to uart_handle_break() must also be done if count = 0, therefore
> duplicate this code fragment and pull it out of the loop over the received
> characters.
> 
> Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

Applied and queued up for -stable, thanks.

But this function needs more work.  For one thing, it needs to
resample the status registers to update the stat->foo values each loop
iteration, otherwise it will report break, overflow, etc. over and over
again until we get the next interrupt.

Serial chips seem to handle bare-break characters differently.  The 8250
seems to indicate "data ready" in it's status register in such cases
(and I suppose provides a zero character byte), whereas SAB seems to not
put any bytes in it's FIFO in this situation.
