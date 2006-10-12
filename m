From: David Miller <davem@davemloft.net>
Date: Thu, 12 Oct 2006 21:34:42 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <20061012.143442.105431995.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010132943.GB18539@ele.uri.edu>
	<20061010.151751.90998930.davem@davemloft.net>
	<20061012143726.GD21243@ele.uri.edu>
In-Reply-To: <20061012143726.GD21243@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 12 Oct 2006 10:37:26 -0400

> This will be difficult as the machine in question isn't one I want to
> reboot too often. The running kernel and modules are compiled with debug
> info, though; if I send you the relevant .o files will that help?

The reason I asked for it in the image is because I want to tell gdb
"x/10i 0xZZZZZ" using the exact program counters in the dumps and get
exactly the instruction that is faulting.

That is very difficult with modules since they can get loaded at any
address, and the gdb listings you provided with those symbol-relative
addresses were non-sensible, and that's why I can't match the true
cause up right now.

So whilst I can try with a module image, you'd have to do things like
tell me exactly what is the base address of the loaded kernel module
at the time of the message trigger and other non-trivial stuff like
that to get me the debugging info I want to fix this.

Thanks.
