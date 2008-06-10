From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 21:26:35 +0000
Subject: Re: [PATCH 01/21] sparc: copy exported sparc64 specific header
Message-Id: <20080610.142635.254806386.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 10 Jun 2008 23:00:03 +0200

> On Tue, Jun 10, 2008 at 01:48:39PM -0700, David Miller wrote:
> > Is there any way to avoid this so that the tree is bisectable
> > during your changes?
> Yes - I will then have to add all the moved headers to
> include/asm-sparc/Kbuild.
> 
> I will do so and post an updated patch serie.

Thanks a lot Sam.

Meanwhile, I'll push to sparc-next-2.6 just my changeset to eliminate
apb.h and bbc.h from include/asm-sparc64/Kbuild
