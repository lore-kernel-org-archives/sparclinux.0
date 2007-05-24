From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 21:15:11 +0000
Subject: Re: Linker script cleanup / consolidation
Message-Id: <20070524211511.GD1372@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200934.GB1109@uranus.ravnborg.org>
In-Reply-To: <20070524200934.GB1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 24, 2007 at 01:45:12PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 24 May 2007 22:09:34 +0200
> 
> > The other archs shall have a similar clean-up over time.
> > sparc64 was just a good place to start because David had
> > expressed that he liked the consolidation.
> 
> This looks great.  In fact I'd be happy with you pushing this
> now for 2.6.22 in order to fix that RODATA() section alignment
> bug.
I did not write so I realize but since this targets sparc64 I
expected you to apply this to your sparc-2.6.git tree.
But I can push too - just confirm what you expect.

> On a related topic, I've been wondering how to make instruction
Need sleep before composing an answer - bed-time here.

	Sam
