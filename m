From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 12 Mar 2015 18:54:54 +0000
Subject: Re: [PATCH 12/22] sparc: %pF is only for function pointers
Message-Id: <20150312185454.GA22576@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
 <1426130037-17956-12-git-send-email-scottwood@freescale.com>
 <20150312184757.GA22552@ravnborg.org>
 <1426186182.30327.127.camel@freescale.com>
In-Reply-To: <1426186182.30327.127.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Mar 12, 2015 at 01:49:42PM -0500, Scott Wood wrote:
> On Thu, 2015-03-12 at 19:47 +0100, Sam Ravnborg wrote:
> > On Wed, Mar 11, 2015 at 10:13:47PM -0500, Scott Wood wrote:
> > > Use %pS for actual addresses, otherwise you'll get bad output
> > > on arches like ppc64 where %pF expects a function descriptor.  Even on
> > > other architectures, refrain from setting a bad example that people
> > > copy.
> > 
> > The commit message used uppercase 'S' and 'F'.
> > But the patch uses lowercase variants.
> > 
> > Is this to highlight the letter in the commit message or some unwanted inconsistency?
> 
> It was copy and paste from others in the series that did involve the
> capital version.  I can send a v2 with an updated commit message.
As it confused me someone else migth (maybe the chances are small but anyway) be confused too.
So please send a new version.

	Sam
