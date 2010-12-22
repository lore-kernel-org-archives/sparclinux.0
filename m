From: David Miller <davem@davemloft.net>
Date: Wed, 22 Dec 2010 03:54:43 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <20101221.195443.226780734.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jiri Gaisler <jiri@gaisler.com>
Date: Tue, 21 Dec 2010 23:44:44 +0100

> 
> We are thinking of switching the LEON port to use CASA (compare and swap),
> just like in the sparc64 port. Most newer leon3/4 processors implement CASA,
> even if the instruction belongs to sparc V9 and not V8. Would a patch like
> that be accepted (for the LEON port only)? This will not fix the SMP for
> general sparc32 (which really is broken), but it would fix it for LEON.

It should be fine as long as the patches are clean enough.
