From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Mar 2006 21:16:37 +0000
Subject: Re: ESP busted
Message-Id: <20060309.131637.114886710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Thu, 09 Mar 2006 07:22:11 -0600

> Its 150k, so I've put it up at:
> http://dev.gentoo.org/~squash/esp.s

This is really bad, GCC isn't inlining anything.

So the deepest IRQ handler path eats up ~1152 bytes of stack space and
that's before we call into the scsi layer to indicate command
completion.

With gcc-4.0.x most of the IRQ path gets inlined even with the -Os we
are giving to GCC now.

What gcc version are you using again?  I'll try to reproduce here and
try to add some inline directives to try and cure this.

Thanks.
