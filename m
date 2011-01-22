From: Alex Buell <alex.buell@munted.org.uk>
Date: Sat, 22 Jan 2011 10:55:29 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <1295693729.349.2.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 2011-01-21 at 20:11 -0800, David Miller wrote:

> > [00000000000a0000]
> 
> Yeah, it's dying the same way as before.
> 
> I'm stumped at the moment.

I just spotted something. Looking at the above address, it seems to be
0xA0000, same as the high address for accessing VGA memory in a PC.
Perhaps it's still trying to access that whereas on a SUN it may need
remapping to the correct location?
-- 
Tactical Nuclear Kittens
