From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jun 2008 22:02:22 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <20080618.150222.177264768.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Wed, 18 Jun 2008 22:06:24 +0200

> I noticed the DMA address changes every few times, will it work if I
> wait a few hours until it has tried all possible addresses? ;)

I doubt it :-)

What's your approximate test case, is it some script that
performs the big directory operations you described in your
original report?

Can I have a copy?  I'd like to trigger this here and debug
it locally if possible.
