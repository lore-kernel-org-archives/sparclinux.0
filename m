From: daniel@gaisler.com
Date: Fri, 22 Apr 2011 06:49:01 +0000
Subject: Re: [PATCH] sparc32: removed unused code, implemented by
Message-Id: <20110422024901.48vhzxk2sk0s4swo@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303395699-6929-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303395699-6929-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Thu, 21 Apr 2011 16:47:01 -0700 (PDT), David Miller  wrote:
From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Thu, 21 Apr 2011 16:21:39 +0200
>
> > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>
> I had to do the rwsem_32.S removal by hand because:
>
> > -#ifdef CONFIG_SMP
> > -#if !(defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP))
> > -1: ldstub [%g1 + 4], %g7
> > -#else
> > -1: set 4, %g7
> > - ldstuba [%g1 + %g7] 1, %g7  /* ASI_LEON23_DCACHE_MISS */
> > -#endif
>
> these leon hacks are not in any of my trees. 
>
> But otherwise applied, thanks. 

Yeah, these are ugly LEON hacks not part of the kernel.. Thanks for 
applying the patches. 

Daniel


