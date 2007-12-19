From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 19 Dec 2007 13:26:52 +0000
Subject: Re: sparc64 with 32-bit user-space context switching question
Message-Id: <18281.7196.837088.890811@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18279.47071.463773.734087@harpo.it.uu.se>
In-Reply-To: <18279.47071.463773.734087@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Tue, 18 Dec 2007 13:06:55 +0100
 > 
 > > My main question is: what does the kernel do to the
 > > high 32 bits of the 64-bit integer registers during
 > > context switches?
 > 
 > Only %oX and %gX registers have the full 64-bit preserved across
 > context switches for 32-bit processes.
 > 
 > The %lX and %iX registers cannot have their full 64-bits preserved
 > because the amount of save space is fixed by the register window save
 > area layout on the stack, which only saves 32-bit values for each
 > register.

>> Also, does anyone know what Solaris does to the
>> high 32 bits during context switches?
>
>Solaris handles things identically to Linux.
>
>These rules are even encoded into places like the
>GCC backend for sparc, when generating v9 code
>for 32-bit.

Thanks, this helps.

/Mikael
