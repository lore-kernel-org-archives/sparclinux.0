From: Greg KH <greg@kroah.com>
Date: Mon, 05 Jan 2004 22:39:51 +0000
Subject: Re: Linux 2.4.23-rc1
Message-Id: <20040105223950.GE30464@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <002701c3a8a1$b1ce6380$54dc10c3@amos> <20031111145734.46d19c87.davem@redhat.com> <20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk> <20031111150815.6a8aff01.davem@redhat.com> <20031112015433.GA20145@kroah.com> <20031111223630.6f2bf759.davem@redhat.com>
In-Reply-To: <20031111223630.6f2bf759.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, milang@tal.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Nov 11, 2003 at 10:36:30PM -0800, David S. Miller wrote:
> On Tue, 11 Nov 2003 17:54:33 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > Then how is the ir-usb driver supposed to be able to set a baud rate of
> > 4000000 in a portable manner?
> 
> You just won't get support for it on Sparc, nor any other
> platform that does not have the B4000000 macro defined.
> Ie.
> 
> #ifdef B4000000
> 		case B4000000:
> 			....
> #endif

I've finally made this change, and will send it onward in a few days.

thanks,

greg k-h
