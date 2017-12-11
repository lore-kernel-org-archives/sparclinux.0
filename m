From: David Miller <davem@davemloft.net>
Date: Mon, 11 Dec 2017 19:20:06 +0000
Subject: Re: n2_crypto gets a BUG() triggered on T5240
Message-Id: <20171211.142006.2149391250067730206.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 11 Dec 2017 02:14:31 +0100 (CET)

> With the current Debian sid system (2-3 days old) running the 4.14.2,
> loading the n2_crypto module causes a BUG() to get triggered. The
> system is a T5240 and the problem is reliably repeatable in case I
> should try some suggestions, patches, or if I need to provide more
> information. On a T5120, loading n2_crypto does not lead to this
> issue.
> 
> Trimmed dmesg, kept the lines which seem relevant.

I can't see any recent changes to the driver which would cause this.

Please reproduce with the current upstream kernel and bisect.

Thank you.
