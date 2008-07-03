From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2008 20:44:16 +0000
Subject: Re: [PATCH] sparc64: fix up bus_id changes in sparc core code
Message-Id: <20080703.134416.115438394.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080702153651.GB30318@kroah.com>
	<20080703.033556.167121752.davem@davemloft.net>
	<20080703164939.GA13326@suse.de>
In-Reply-To: <20080703164939.GA13326@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@suse.de
Cc: jbarnes@virtuousgeek.org, kay.sievers@vrfy.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Thu, 3 Jul 2008 09:49:39 -0700

> Argh, I'm patching against a previous patch that was only sent to Jesse
> for the PCI core, sorry for the confusion.
> 
> The patch for that is below.  It's probably easier for Jesse to take
> both of these in his tree if you like, or I can send you just the Sparc
> one, based on HEAD right now, and then the intermediate step in the PCI
> patch would not be needed.
> 

It's easiest if Jesse takes them both, here is my ACK:

Acked-by: David S. Miller <davem@davemloft.net>
