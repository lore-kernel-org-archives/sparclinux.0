From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 27 Sep 2004 16:31:08 +0000
Subject: Re: [PATCH 2.6] Fix "cannot allocate memory for cgsix" warning on sparc32
Message-Id: <20040927163108.GA2030@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1095378781.16982.21.camel@localhost.localdomain>
In-Reply-To: <1095378781.16982.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 16, 2004 at 05:12:34PM -0700, William Lee Irwin III wrote:

> On Thu, Sep 16, 2004 at 06:53:01PM -0500, Tom 'spot' Callaway wrote:
> > This patch has been floating around for about 6 or more months, Keith
> > wrote it when he was the sparc32 maintainer... it resolves the
> > framebuffer errors on some older sparc32s (we triggered it on a
> > SparcStation 2). 
> > Please commit, thanks.
> 
> I presume this has been tested and works on newer sparc32 systems also?

It does, but it's pretty hackish.  I gave it to about 3 people who
were specifically experiencing the problem but did not investigate
enough to determine whether it's really the right approach.

-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
