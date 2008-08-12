From: David Miller <davem@davemloft.net>
Date: Tue, 12 Aug 2008 06:30:13 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080811.233013.49328708.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080620.144128.32005196.davem@davemloft.net>
	<20080620.215139.218732028.davem@davemloft.net>
	<Pine.LNX.4.64.0806211542050.21474@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806211542050.21474@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 21 Jun 2008 15:42:56 -0400 (EDT)

> On Fri, 20 Jun 2008, David Miller wrote:
> 
> > giving a try.
> >
> > sparc64: Implement support for IRQ stacks.
> 
> For me it doesn't work. Locked up after "console: colour dummy device 
> 80x25".

Are you sure you didn't see a "Stack overflow" message on the
screen? :-)

That's what I get when I try to boot with your provided
kernel config.

The problem is that CONFIG_STACK_DEBUG doesn't understand
the IRQ stacks at all.

I'll see if I can tweak it to handle this.
