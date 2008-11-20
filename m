From: David Miller <davem@davemloft.net>
Date: Thu, 20 Nov 2008 12:50:56 +0000
Subject: Re: Extending Leon-Sparc page table size to 32k
Message-Id: <20081120.045056.166469954.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
In-Reply-To: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "k e" <eiselekd@gmail.com>
Date: Thu, 20 Nov 2008 13:39:01 +0100

> > You have no choice in these matters, as indexing at each page table
> > level is determined by hardware.  What does Leon use with 32K pages?
> 
> Hi,
> I wrote the MMU in vhdl myself, so I would rewrite the hardware (vhdl).
> The Leon-sparc processor is a synthesizable core that runs on a fpga.

Well then I think what you should do is look at how the address space
looks for real processes, and use this information to figure out where
it would better to increase density.

I suspect making the PTE level tables denser would be the most beneficial.
But do not take my word for it :-)
