From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Sep 2009 21:56:18 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925145618.e40c4857.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Sep 2009 23:50:11 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Sep 25, 2009 at 02:42:14PM -0700, Andrew Morton wrote:
> > On Fri, 25 Sep 2009 14:36:23 -0700
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > akpm:/usr/src/25> setenv ARCH sparc32
> > > akpm:/usr/src/25> make mrproper
> > > Makefile:213: *** ARCH changed from "sparc" to "sparc32". Use "make mrproper" to fix it up.  Stop.
> > 
> > OK, I think this is just breakage in today's linux-next.
> > 
> > After doing an x86_64 build I did:
> > 
> > akpm2:/usr/src/25> setenv ARCH i386
> > akpm2:/usr/src/25> make mrproper
> > Makefile:200: *** CROSS_COMPILE changed from "/opt/crosstool/gcc-4.0.2-glibc-2.3.6/x86_64-unknown-linux-gnu/bin/x86_64-unknown-linux-gnu-" to to "/opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-". Use "make mrproper" to fix it up.  Stop.
> > **FAILED**
> > 
> > Manually removing include/generated/* fixes this up.
> 
> Never used this combination in my testing - but it looks like something
> that many people will hit :-(
> kbuild checks for inconsistent ARCH/CROSS_COMPILE settings
> _before_ we do the mrproper thing.
> 
> I need to look at this a bit to come up with a proper
> solution. 
> 
> Thanks for reporting.
> 

OK, thanks.

Dave, could you please send along the config which broke Christoph's
patch?  It works OK with allnoconfig and defconfig for me.

