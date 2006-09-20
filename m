From: David Miller <davem@davemloft.net>
Date: Wed, 20 Sep 2006 17:56:59 +0000
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-Id: <20060920.105659.128612840.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060920172123.GA9334@ele.uri.edu>
In-Reply-To: <20060920172123.GA9334@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Wed, 20 Sep 2006 13:21:23 -0400

> I upgraded from 2.6.17.7 to 2.6.18 today, and in dmesg I have 5 of these
> messages in a row:
> 
> Kernel unaligned access at TPC[100be8c8] ehci_hub_control+0x350/0x680 [ehci_hcd]
> 
> This message wasn't there before... I suppose it is pretty harmless as
> the kernel is supposed to handle unaligned accesses (right?) but this is
> the first time it's happened.

Yes, I've been meaning to send Greg KH patches to fix these
cases, thanks for reminding me about it.
