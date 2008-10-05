From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2008 20:57:13 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20081005.135713.173042834.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2008 13:47:11 -0700 (PDT)

> You didn't even test boot this, you can't change the size of cpuinfo_sparc
> without fixing all the hardcoded assembler indexing of that structure.
> 
> First, you're need to pad it out to the next power of two, then you'd
> need to update the shift constant macro that all the assembler uses.

Sorry, my bad, I was thinking of the trap_info.  That structure
needs such careful handling, this one doesn't.
