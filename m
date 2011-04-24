From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2011 21:14:33 +0000
Subject: Re: memblock versus bootmem (relevant for sparc32?)
Message-Id: <20110424211433.GA27780@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110423174200.GA25324@merkur.ravnborg.org>
In-Reply-To: <20110423174200.GA25324@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > 
> > Replacing bootmem seems like a bigger task - that will wait.
> 
> will need to move get_free_all_memory_range() and related funcs
> from arch/x86/mm/memblock.c to mm/memblock.c or mm/nobootmem.c

It would be great if you could look at this - then it would be more obvious what is needed
for other archs to support nobootmem.

> 
> replacing bootmem with memblock in arch code should be simple.

This is also my impression after looking at it.

As for sparc32 I will give it a try - but it will take a while as I need to finish
some other stuff first.

	Sam
