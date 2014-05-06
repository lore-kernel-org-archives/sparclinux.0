From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 03:59:35 +0000
Subject: Re: [PATCH 09/10] sparc64: Add basic validations to {pud,pmd}_bad().
Message-Id: <20140505.235935.450424103698651850.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175556.65359624693463383.davem@davemloft.net>
In-Reply-To: <20140430.175556.65359624693463383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 1 May 2014 18:17:02 +0200

> It would had been self-documenting if the type is changed to
> phys_addr_t here.  But I see that we do not use phys_addr_t much
> (only one place) in sparc code today.

I wouldn't be against such a cleanup.

Code has been using "unsigned long" since the dawn of time, most of
this stuff was written before phys_addr_t got added.  And it was added
to handle 32-bit machines with larger than 32-bit physical addresses.

Technically sparc32 could theoretically need it, as it supports 36-bit
physical address in the srmmu PTEs.  But actually in practice it does
not, as only I/O devices get mapped into ares using those high bits.

