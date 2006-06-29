From: David Miller <davem@davemloft.net>
Date: Thu, 29 Jun 2006 09:04:38 +0000
Subject: Re: booting the T1000
Message-Id: <20060629.020438.07638659.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Thu, 29 Jun 2006 09:37:49 +0200

> In a blog of someone working on the Ubuntu suport I found a note
> about "problems with hpa-tftpd", so I tried iputils/tftpd and atftpd without
> success. Note  that an Ultra30 booted the same image served from the
> same daemons just fine.

iputils inetd doesn't work well with tftpd at all, it propagates the
non-blocking setting of the socket down to tftpd which is not expecting
this.

Use netkit-inetd and it should go fine.  That's what I'm using here.
