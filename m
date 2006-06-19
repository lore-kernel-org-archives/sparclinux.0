From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jun 2006 03:57:12 +0000
Subject: Re: [SILO PATCH]: Fix CDROM booting on sparc64
Message-Id: <20060618.205712.105428738.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060618.190752.125899833.davem@davemloft.net>
In-Reply-To: <20060618.190752.125899833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 18 Jun 2006 20:43:02 -0700 (PDT)

> Great news, Dave! Thank you so much for looking into it.
> 
> Unfortunately, I don't have any hardware which exhibits this problem. I've 
> prepared a tiny Debian installer iso image, which includes the patched 
> silo, so that people can test it easily (just burn it to a CD and give it 
> a spin). It is available as
> 
> http://www.wooyd.org/debian/silo/sparc-mini.iso
> 
> This directory also contains an updated Debian silo package.

This image boots on my SB1000 just fine, and that's the machine where
I could reproduce the bug.

