From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 09 May 2006 21:27:22 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060509212721.GB11017@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 07, 2006 at 11:12:46PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Sat, 6 May 2006 10:12:54 +0100
> 
> > I thought you were too busy with Niagara?
> 
> Well... do you see anyone else picking up the ball and even trying to
> work on sparc 32-bit bugs? :-/

Sadly, no. I can try to do some of the easier things, but fixing something like
the esp driver without the esp&dma datasheets is beyond me I'm afraid :).

> > I've put crc32.ko and crc32.o at http://www.mph.eclipse.co.uk/pub/linux/
> 
> Do these actually fail to load?  There are no R_SPARC_PC22 relocations
> in the crc32.ko object.  I also checked crc32.o, same story.  Perhaps
> another object has the problem, please provide it.

Yes, these actually fail to load. Maybe it's a memory corruption in module.c
somehow: if I make too many debugging changes in apply_relocate_add() the
problem disappears.
I'm trying different things now to make it show me the failing section and
symbol when it fails. I'll post again once I have more details.

Thanks for your help.
-- 
Martin
