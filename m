From: "David S. Miller" <davem@redhat.com>
Date: Mon, 31 May 2004 19:36:14 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum
Message-Id: <20040531123614.71f9c5fa.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 31 May 2004 14:44:55 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Any chance to switch sbus over to using it aswell?

If you submit a patch, I'll integrate it and munge it until it
builds :-)

> And while we're at it, if someone cares for the
> sbus scsi drivers:  any chance to convert them awaya from needing scsi.h
> and hosts.h in drivers/scsi/ to the <scsi/*.h> headers?  It's really
> just some boring decrufting, mostly killing obsolete typedefs.

Similarly...
