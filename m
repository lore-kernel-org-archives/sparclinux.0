From: "David S. Miller" <davem@redhat.com>
Date: Wed, 02 Jun 2004 23:02:20 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum
Message-Id: <20040602160220.113abfb3.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 01 Jun 2004 11:47:32 -0500
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Mon, 2004-05-31 at 14:44 +0200, Christoph Hellwig wrote:
> > And while we're at it, if someone cares for the
> > sbus scsi drivers:  any chance to convert them awaya from needing scsi.h
> > and hosts.h in drivers/scsi/ to the <scsi/*.h> headers?  It's really
> > just some boring decrufting, mostly killing obsolete typedefs.
> 
> Patch attached to move from old typedefs to modern ones, and stop using
> the old headers. This covers esp & qlogicpti, and really isn't rocket
> science, just boring decrufting.

Applied, thanks Tom.
