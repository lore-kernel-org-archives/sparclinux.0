From: David Miller <davem@davemloft.net>
Date: Fri, 19 Feb 2010 23:07:16 +0000
Subject: Re: Execution possible in non-executable mappings in recent 2.6
Message-Id: <20100219.150716.252828371.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100219225724.GA29861@grsecurity.net>
In-Reply-To: <20100219225724.GA29861@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The bug seems to be that the TSB ITLB loading code mistakenly
uses "andcc %reg, _PAGE_EXEC_4U..." instead of using
"sethi" to load _PAGE_EXEC_4U into a register then checking
the bit.

andcc only supports signed 13-bit values in the immediate
field.  And _PAGE_EXEC_4U is bit 12.

I'll work on a fix, thanks for the test cases.

