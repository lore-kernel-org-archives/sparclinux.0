From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 07 Jul 2006 07:30:19 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <44AE0D8B.5060805@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> From: Daniel Smolik <marvin@mydatex.cz>
> Date: Thu, 06 Jul 2006 21:35:43 +0200
> 
> 
>>I have similar problem with my Raptor GFX (Permedia2). If I run 
>>Xserver in fb driver I get this:
>>
>>
>>ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40584606){00} arg(ff25bb9c) 
>>on /dev/fb0
>>ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40184600){00} arg(ff25bba4) 
>>on /dev/fb0
>>
>>Is it same problem as in Atyfb ?
> 
> 
> Yes, it is the same problem.
> 
> And I've used ATI R128 cards without Sun firmware on them too,
> and they would cause the same messages.
> 
> It makes zero sense to put knowledge of this SBUS framebuffer
> ioctl into every single framebuffer driver, because that is what
> you would need to do in order to cover all possible cases.

Thanks for answer. But what can we do with this problem ? Start 
communicate with video driver authors ?


			Regards
				Dan
