From: David Miller <davem@davemloft.net>
Date: Tue, 19 Dec 2017 16:38:20 +0000
Subject: Re: [PATCH] crypto: n2 - cure use after free
Message-Id: <20171219.113820.1629794046915223777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20171216010117.13275-1-jengelh@inai.de>
        <20171219.103116.1726291053594167469.davem@davemloft.net>
        <nycvar.YFH.7.76.1712191637300.11660@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1712191637300.11660@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jengelh@inai.de
Cc: sparclinux@vger.kernel.org, herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, rmk+kernel@arm.linux.org.uk

From: Jan Engelhardt <jengelh@inai.de>
Date: Tue, 19 Dec 2017 16:42:39 +0100 (CET)

> Nevertheless, I think that the error pathing in n2_core.c should be made 
> robust as well.

I completely agree.

> Should I resubmit with a new commit message?

Yes.
