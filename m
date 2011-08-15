From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 15 Aug 2011 15:24:36 +0000
Subject: Re: [PATCH,SPARC] make sparc32 arch_write_unlock() match the
Message-Id: <20110815152436.GA31355@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040.65109.439941.444670@pilspetsen.it.uu.se> <20110815133116.GA20563@entuzijast.net> <20041.11793.565236.115039@pilspetsen.it.uu.se>
In-Reply-To: <20041.11793.565236.115039@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Josip Rodin <joy@entuzijast.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mikael.

>  > > @@ -175,7 +184,7 @@ static inline int __arch_read_trylock(ar
>  > >  	res; \
>  > >  })
>  > >  
>  > > -#define arch_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
>  > > +#define arch_write_unlock(rw)	arch_write_unlock(rw)
>  > >  
>  > >  #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
>  > >  #define arch_read_lock_flags(rw, flags)   arch_read_lock(rw)
>  > 
>  > Why keep the tautological define? Just wondering.
> 
> Only because sparc64 does it that way.  I now see that no other
> arch has the #define, so perhaps that bit should be deleted (from
> both sparc64 and sparc32).
Please kill the extra define in both sparc32 and sparc64.
Preferably in two separate patches.

For the subject of the patch please use:
[PATCH] sparc32: bla bla

Because when davem apply the patch everything in [] is zapped,
and it is good to see in the shortlog that this is a sparc32 specific patch.

For sparc64 we sometimes use "sparc64: bla bal", and sometimes use
"sparc: bla bla".
I prefer the first but no strong feelings.

And btw thanks for looking at this! Looks like a very difficult bug to nail.

	Sam
