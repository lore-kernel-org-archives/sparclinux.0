From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 01 Dec 2008 08:52:13 +0000
Subject: Re: final unification of sparc,sparc64
Message-Id: <20081201085213.GA30798@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081130200745.GA17845@uranus.ravnborg.org>
In-Reply-To: <20081130200745.GA17845@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 01, 2008 at 12:40:01AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 30 Nov 2008 21:07:45 +0100
> 
> > This is the final step in the unification of sparc,sparc64.
> > Final in the sense that arch/sparc64 is no more and
> > I have not planned additional sparc unification activities
> > in this round...
> 
> I really like this work, thanks Sam.
> 
> But I'm going to let this sit in my inbox until the
> sparc32 boot failure is figured out.  Once that is resolved,
> I'll work through these changes and do boot testing on
> sparc64.

Obviously.

Is it acceptable to rebase sparc-next?
The brown paper bug in the top-level Makefile is fatal for any bisect attempts.

	Sam
