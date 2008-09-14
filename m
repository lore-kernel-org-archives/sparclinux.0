From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 00:02:38 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913.170238.176922548.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 20:04:27 +0200

> Dave, I hope you can make sense of all this... you have the prtconf of the
> machine in the repository so you can see which PCI controller that is.
> If you need any more details, please don't hesitate to let me know.

I wonder if interrupts are getting through.

Can you watch /proc/interrupts when you try to use the card in the
sparc box?
