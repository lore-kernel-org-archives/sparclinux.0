From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 07 Jul 2006 10:09:15 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <44AE32CB.6090707@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> From: Daniel Smolik <marvin@mydatex.cz>
> Date: Fri, 07 Jul 2006 09:30:19 +0200
> 
> 
>>Thanks for answer. But what can we do with this problem ? Start 
>>communicate with video driver authors ?
> 
> 
> For now just simply ignore the kernel message, it really
> does no harm. :)
I would like, but Xserver over fbdev doesn't work. Accelerated Xserver 
too because in Xorg is bug with multi PCI domain and driver doesn't 
recognize my Raptor card :-).

