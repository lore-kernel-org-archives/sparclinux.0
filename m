From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 13 Jan 2005 23:29:34 +0000
Subject: Re: mmap(/dev/mem) causing sigbus
Message-Id: <20050113152934.446eac9e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1105657934.2527.96.camel@duffman>
In-Reply-To: <1105657934.2527.96.camel@duffman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 13 Jan 2005 15:12:14 -0800
Tom Duffy <tomduffy@dslextreme.com> wrote:

> It seems that there is an issue with either mmap or mmap'ing /dev/mem on
> sparc64.  A tool (mstflint) for flashing firmware for Mellanox
> Infiniband HCA's is crashing on sparc64.  It mmap's /dev/mem and when it
> accesses it, a bus error is generated.
> 
> Should this work?

It's not meant to be used at all.  We have abstracted out a way
to portably mmap() pci devices by opening /proc/bus/pci/* nodes,
running the appropriate ioctl() to choose I/O or MEM space,
then mmap()'ing on the fd to mmap the PCI device resources.

At the very least, i386 and ppc support this interface as well.
