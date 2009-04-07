From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 07 Apr 2009 22:10:08 +0000
Subject: Re: kernel bug with CONFIG_KEYBOARD_ATKBD=y
Message-Id: <200904071710.09685.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <200904071001.19368.dennis@ausil.us>
In-Reply-To: <200904071001.19368.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 07 April 2009 04:57:55 pm David Miller wrote:
> From: Dennis Gilmore <dennis@ausil.us>
> Date: Tue, 7 Apr 2009 10:01:17 -0500
>
> > Initalizing network drop monitor service
> > kernel BUG at
> > /builddir/build/BUILD/kernel-2.6.29/linux-2.6.29.sparc64/arch/sparc/inclu
> >de/asm/tlb_64.h:48!
>
> What kernel is this tree based upon?  2.6.29.1?
yeah 2.6.29.1

kernel-2.6.29.1-52.fc11  from fedora cvs with 

CONFIG_KEYBOARD_ATKBD=y  
# CONFIG_KGDB is not set


they were the only changes i made to the config

Dennis
