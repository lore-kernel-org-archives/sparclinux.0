From: Greg KH <gregkh@suse.de>
Date: Mon, 05 Mar 2007 03:32:52 +0000
Subject: Re: [6/6] 2.6.21-rc2: known regressions
Message-Id: <20070305033252.GA27558@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015045.GK3441@stusta.de>
In-Reply-To: <20070305015045.GK3441@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, "David S. Miller" <davem@sunset.davemloft.net>, sparclinux@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oneukum@suse.de>, linux-usb-devel@lists.sourceforge.net, Craig Schlenter <craig@codefountain.com>, Paul Rolland <rol@as2917.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, David Brownell <david-b@pacbell.net>, a.zummo@towertech.it, rtc-linux@googlegroups.com

On Mon, Mar 05, 2007 at 02:50:45AM +0100, Adrian Bunk wrote:
> 
> Subject    : usb-serial broken
>              (ftdi serial device shows up as ttyUSB140 instead of ttyUSB0)
> Submitter  : Craig Schlenter <craig@codefountain.com>
> Caused-By  : Oliver Neukum <oneukum@suse.de>
>              commit 34ef50e5b1f96c2d8c0f3d28b7d407743806256c
> Handled-By : Oliver Neukum <oneukum@suse.de>
> Status     : patch available

Patch is queued up in my tree and will go to Linus in a few days.

But I think there is another usb-serial patch that Oliver needs to send
me to fix another problem with the usb-serial core...

thanks,

greg k-h
