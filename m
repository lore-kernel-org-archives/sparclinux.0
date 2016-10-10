From: Allen <allen.pais@oracle.com>
Date: Mon, 10 Oct 2016 09:32:28 +0000
Subject: Re: user probes patch
Message-Id: <57FB5D5C.5020301@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161006.013850.1300008206447553874.davem@davemloft.net>
In-Reply-To: <20161006.013850.1300008206447553874.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> I was reading the user probes sparc patch and I noticed that
> it doesn't handle the 'y' register properly in the pt_regs
> accessors because it assumes that all of the registers are
> "unsigned long" in size.  The 'y' register is "unsinged int".

   Oh yes, Will have that fixed and resent.


