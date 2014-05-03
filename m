From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 17:21:08 +0000
Subject: Re: [PATCH 0/12] sparc: diverse cleanup patches
Message-Id: <20140503172108.GA30367@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140502145859.GA5042@ravnborg.org>
In-Reply-To: <20140502145859.GA5042@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 02, 2014 at 05:09:52PM +0200, Sam Ravnborg wrote:
> On Fri, May 02, 2014 at 04:59:00PM +0200, Sam Ravnborg wrote:
> > After the introduction of the generic io.h for sparc32 there was
> > some cleanup left to do to trim io_32.h further.
> > sparc64 cannot use the generic version because there are
> > so many dedicated functions for little/big endian.
> > 
> > The quest to get rid of sparse warnings for sparc32 continues,
> > and what is left is a bunch of "shift too big" in the
> > soft floating point code that I do not plan to address.
> > With sparc32 mostly clean start to fix the sparc64 sparse warnings.
> > 
> > Two patches touches the inline asm statements. They need extra review
> > as I do not know what I am doing here..
> > 
> > tadpole.c got dropped - the code in this file had not been in use for
> > more than 5 years.
> > 
> > The biggest change in terms of lines changed are the patches that drops
> > the use of extern for prototypes in all the sparc specific header files.
> 
> Hi David.
> 
> I only now realized that the first patch was included in the previous
> set - so please ignore the patch [01/12] which do a cleanup of io_32.h.
> Sorry for this confusion.
> 
> If I get inspired next step is to try to get sparc64 down to same low
> level of sparse warnings as we now have for sparc32.
> As you already did a lot of work this looks quite do-able.

Please disegard the whole serie. At least one changelog is in a dire need
for a rewrite so I will combine this with the next batch of sparse warning
cleanup patches.

	Sam
