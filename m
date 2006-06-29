From: David Miller <davem@davemloft.net>
Date: Thu, 29 Jun 2006 21:42:42 +0000
Subject: Re: booting the T1000
Message-Id: <20060629.144242.74747695.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Newport <crn@netunix.com>
Date: Thu, 29 Jun 2006 22:37:08 +0100

> I could be wrong, but there seem to be generic issues running tftpd via 
> inetd, often only intermittently reproduceable. 

It reproduces only when tftpd is invoked from inetd before the client
sends out the first packet.

If inetd gets a non-blocking socket, it chokes on the first read()
when data is not available in the socket receive buffer.  If the
client is fast enough, or the tftpd server slow enough, this will
never happen.

That's why it might be intermittently reproducable.

Believe me, I traced this one down to the source :)
