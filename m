From: "David S. Miller" <davem@redhat.com>
Date: Wed, 31 Mar 2004 20:24:18 +0000
Subject: Re: [SPARC64]: Use correct register values for OBP names
Message-Id: <20040331122418.1d0d73c9.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040329200503.GA24518@foobazco.org>
In-Reply-To: <20040329200503.GA24518@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 29 Mar 2004 12:05:04 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> This looks like a lot of voodoo, but it fixes two real problems: (1)
> SMP systems end up with duplicate entries in openpromfs, and (2) the
> names there don't match what's shown by OBP which is confusing.
> 
> It works properly on U1, U2, and E3500, but I suspect it only works on
> spitfire systems.  I don't have access to any cheetahs.  Probably at
> least upa-portid is wrong there, but I have no idea what OBP shows on
> such systems anyway.

Yikes, this function is full of other bugs too.  F.e. for PCI devices
it assumes the parent is PCI host yet it could be a PCI-PCI bridge.

The problem is that each and every node type needs different reg
decoding, PCI is one way, cpus are another, and EBUS is different
as well.

I would like to put more thought into this issue before we put in
a change like this.  The bit masking, as you suspected, is going
to be wrong on other platforms.  The "board ID" or whatever first
unit of the address is at a different set of upper bits on different
platforms and bus types, for one thing.
