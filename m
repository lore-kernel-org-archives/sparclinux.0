From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 11 Oct 2006 21:02:29 +0000
Subject: Re: [PATCH 1/4] fix sparc32 modpost warnings
Message-Id: <20061011210228.GA17527@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154416.GB30909@palantir8>
In-Reply-To: <20061010154416.GB30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 11, 2006 at 05:10:45PM +0100, Martin Habets wrote:
> On Tue, Oct 10, 2006 at 02:21:21PM -0700, David Miller wrote:
> > From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> > Date: Tue, 10 Oct 2006 16:44:16 +0100
> > 
> > > Subject: [PATCH 1/4] fix sparc32 modpost warnings
> > > 
> > > Fix these 2.6.19-rc1 build warnings from modpost:
> > > 
> > > WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3e060) and '__kernel_text_address'
> >  ...
> > > @@ -36,11 +36,11 @@
> > >  
> > >    . = ALIGN(4096);
> > >    __init_begin = .;
> > > +  _sinittext = .;
> > >    .init.text : { 
> > > -	_sinittext = .;
> > >  	*(.init.text)
> > > -	_einittext = .;
> > >    }
> > > +  _einittext = .;
> > >    __init_text_end = .;
> > >    .init.data : { *(.init.data) }
> > >    . = ALIGN(16);
> > 
> > This doesn't make any sense.  No other architecture specifies
> > the init sections in this way in their vmlinux.lds.S file.
> 
> The frv is the only architecture that has it this way.
> I just build 2.6.19-rc1 for i386, expecting to see the same build warning.
> It did not appear, which puzzles me at the moment. Do you get this
> warning for sparc64?

OK, I am less confused now: the crux of the matter is that modpost only
checks the relocatable sections. i386 vmlinux has none, so modpost does
no checking on it (it does on the modules).
However, sparc vmlinux has plenty of relocatable sections because it is
being built with 'ld -r' (to allow for btfixup processing).
So for sparc, modpost does do a lot of checking. Sure enough, running
modpost on arch/sparc/boot/image yields no output (i.e. all is well).

modpost.c check_sec_ref() has:
                /* We want to process only relocation sections and not .init */
                if (sechdrs[i].sh_type = SHT_RELA) {
			// check here
                } else if (sechdrs[i].sh_type = SHT_REL) {
			// check here
		}

> > Why is this change correct?
> 
> The symbols are used from functions that realy should be .text (like
> core_kernel_text() in kernel/extable.c). They are not referenced from
> anything in an .init.text sections. So moving them seemed like the right
> solution.

In essence this issue exists for most architectures. They just don't know
it yet. I do not know if modpost will be enhanced/fixed to check all code
sections, but that would seem necessary to find all potential problem
cases.

Given the current build process for sparc32, my patch is the right one
to fix the warning messages. The only other option I can see is to
reorder the build process so that vmlinux is once again the end-product and
no longer an intermediate relocatable. That would be a better yet much
more complicated patch.

I have attached relevant objdump output from sparc32 and i386.

-- 
Martin
