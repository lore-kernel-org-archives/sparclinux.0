From: "David S. Miller" <davem@redhat.com>
Date: Fri, 09 Jan 2004 08:41:35 +0000
Subject: Re: PSYCHO0 PBMA: PCI streaming byte hole error asserted.
Message-Id: <20040109004135.28c1a83c.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073585763.1669.1.camel@localhost>
In-Reply-To: <1073585763.1669.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Jan 2004 14:20:29 -0800
"Feldman, Scott" <scott.feldman@intel.com> wrote:

> > Scott, does the DMA engine of the e1000 do read/write of PCI 
> > cache lines with not all the byte enables on?  In particular, 
> > with descriptor reads/writes?
> 
> 82542/82543/82544 only update the status byte of the Tx desc on
> write-back.  Only the status byte would be byte-enabled.  Every other
> 8254x controller write backs the entire Tx desc (16-bytes) with full
> byte-enables.

I take back what I said, this can't possible be happening for the descriptors
since they are allocated with pci_alloc_consistent() which does not use
streaming DMA mappings.

It must, therefore be occuring on the packet data itself.
