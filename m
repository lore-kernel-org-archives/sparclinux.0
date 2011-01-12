From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jan 2011 04:27:19 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110111.202719.221588364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 18:29:45 -0800 (PST)

> Oh... I see what is happening.  save_vga() sets this value using it's
> own heuristics, when VGA_SAVE_FONTS is set, but in a way that won't
> work in multi-domain PCI situations.
> 
> So we need to set this up in the drivers just like we do for the
> 'vgabase' member.
> 
> I'll work on some patches to fix this.

Alex, give this a try.
