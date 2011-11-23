From: Tom Callaway <tcallawa@redhat.com>
Date: Wed, 23 Nov 2011 21:04:34 +0000
Subject: Re: bug report: 3.1.0-rc4 doesn't discover my FC drives
Message-Id: <4ECD5FE2.2010705@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1315419505.1068.43.camel@o.ww.redhat.com>
In-Reply-To: <1315419505.1068.43.camel@o.ww.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/23/2011 11:28 AM, Heinz Mauelshagen wrote:
> They were in Aurora 2 still, which got released in 2006, because I could
> access the drives with it IIRC. I don't remember to have been forced to
> do FW tricks like that with it. Are the drivers floating around
> somewhere still?

If it worked then, then you've almost certainly got SCSI as opposed to
FC, or you're on a qlogic FC controller (isp1000U, driven via
qla2xxx.ko). Aurora had firmware for that qlogic controller, Fedora has
it too as the ql2200-firmware package, but qlogic stopped maintaining
that firmware a long long time ago.

Caveat: All of this is from memory, I don't have a E6500.

~tom

=
Fedora Project
