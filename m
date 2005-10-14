From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Oct 2005 19:43:21 +0000
Subject: Re: qlogicpti kernel panic
Message-Id: <20051014.124321.34718872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1129315998.2243.35.camel@localhost.localdomain>
In-Reply-To: <1129315998.2243.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 14 Oct 2005 13:53:18 -0500

> I got a kernel panic on 2.6.14-rc4-git2 on the e4500 (8 CPU, 8GB mem). 
> 
> It's hitting the BUG() case in drivers/scsi/qlogicpti.c in ourdone():
> 
> 1146                if (Cmnd->cmnd[0] = 0x12 && ok) {
> 1147                        unsigned char *iqd;
> 1148
> 1149                        if (Cmnd->use_sg != 0)
> 1150                                BUG();
> 
> I can't find any other SCSI drivers doing this sort of check, then
> again, no other SCSI driver seems to act like qlogicpti. Adding a printk
> there shows that Cmnd->use_sg is 1.

That piece of code needs to be rewritten.  That situation is perfectly
valid.  It wants to sniff the SCSI command result buffer, but that
isn't the portable way to do it at all.
