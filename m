From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 07 Jul 2006 10:25:29 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <44AE3699.9050705@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> From: Daniel Smolik <marvin@mydatex.cz>
> Date: Fri, 07 Jul 2006 12:09:15 +0200
> 
> 
>>I would like, but Xserver over fbdev doesn't work. Accelerated Xserver 
>>too because in Xorg is bug with multi PCI domain and driver doesn't 
>>recognize my Raptor card :-).
> 
> 
> Yes, these problems are known.
> 
> In fact I was playing with a Raptor card in an SB2500 just
> the other week.
> 
And have you this card used as console ? When I use this card as 
console in 2.4.x  work OK. But under 2.6.x work but font looks ugly 
and I cannot find solution.





> But those problems are totally unrelated to the ioctl messages.
Yes I know, but I hope that I can use Xserver over fb :-)



			Dan



> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

