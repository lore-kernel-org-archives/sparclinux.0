From: "David S. Miller" <davem@redhat.com>
Date: Thu, 08 Jan 2004 20:08:43 +0000
Subject: Re: PSYCHO0 PBMA: PCI streaming byte hole error asserted.
Message-Id: <20040108120843.46df711c.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073585763.1669.1.camel@localhost>
In-Reply-To: <1073585763.1669.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 08 Jan 2004 12:16:03 -0600
Josh Grebe <josh@brokedown.net> wrote:

> I'm getting a log message of:
> 
> PSYCHO0 PBMA: PCI streaming byte hole error asserted.
> 
> Pretty frequently. So frequently in fact, that I think it may be logging
> one every packet that crosses my gigabit network card.  I have an E450
> with two Intel E1000 cards in it, here is my lspci (sorry for bad
> formatting):

Scott, does the DMA engine of the e1000 do read/write of PCI cache lines
with not all the byte enables on?  In particular, with descriptor reads/writes?

That's not allowed on many RISC platform PCI controllers due to how they
implement caching of DMA traffic, sparc64 is one such instance.

If there is some way to tweak the config of the e1000 such that it will not
generate these transactions, we should do so on sparc64 at least.
