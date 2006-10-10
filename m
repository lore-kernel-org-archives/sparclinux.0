From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 22:17:51 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <20061010.151751.90998930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061005211543.GA18539@ele.uri.edu>
	<20061009.183607.63736982.davem@davemloft.net>
	<20061010132943.GB18539@ele.uri.edu>
In-Reply-To: <20061010132943.GB18539@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Tue, 10 Oct 2006 09:29:43 -0400

> I still get:
> 
> Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0 [eth1394]
> Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0x1060 [eth1394]
> 
> The second one triggers on every packet received, the first only triggers once in a while.
> 
> If you want more gdb info or a disassembly just ask.

Hmmm, can you do me a favor?  Build ieee1394 and eth1394 statically
into your kernel, reproduce, and post the kernel log messages
and the vmlinux image somewhere where I can fetch them.

I should be able to fix this once I have that.

Thanks a lot.
