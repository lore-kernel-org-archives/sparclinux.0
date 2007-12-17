From: David Miller <davem@davemloft.net>
Date: Mon, 17 Dec 2007 10:21:00 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071217.022100.146647816.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 17 Dec 2007 11:10:59 +0100

> I tried setting the console devices to rsc-console in PROM, but the RSC
> never sees anything other than the initial kernel output, and doesn't
> relay any input to the machine. Have you tried that on your 280R?

I simply use the main serial lines, not the RSC.
