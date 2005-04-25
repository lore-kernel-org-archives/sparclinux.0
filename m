From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 25 Apr 2005 05:02:50 +0000
Subject: Re: [PATCH 2.6] Silence missing CONFIG_ symbol noise
Message-Id: <20050425050249.GA8127@mars.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1109914288.17038.64.camel@localhost.localdomain>
In-Reply-To: <1109914288.17038.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 24, 2005 at 08:44:35PM -0700, David S. Miller wrote:
> On Fri, 4 Mar 2005 23:16:33 +0100
> Sam Ravnborg <sam@mars.domain.invalid> wrote:
> 
> > On Thu, Mar 03, 2005 at 11:31:27PM -0600, Tom 'spot' Callaway wrote:
> > > 
> > > The end result is that the undefined CONFIG_ symbol errors are not
> > > thrown when the config utilities are run. The errors are not fatal, but
> > > they do cause confusion when users are building kernels for
> > > sparc/sparc64.
> > Another approch would be to just skip the warnings when reading in a
> > defconfig file. I've never seem them really used.
> 
> I don't think I'm going to apply Tom's patch for now.
> 
> This really sounds like the defconfig files need to be regenerated.
> Right?

kconfig throws a warning when it see:
	select I386_FOO

in sparc context, because the config symbol I386_FOO is not defined.
We do not see this with I386, cause people make sure to define all
selected CONFIG symbols. But most other architectures suffer from this.

IIRC Tom's patch just cleaned up select usage or similar and
regenerating defconfig would not help us here.
But the better solution would be to drop the warning from kconfig.
I will do that next time I get around to do some kernel hacking.

	Sam
