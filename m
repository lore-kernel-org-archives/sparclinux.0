From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 02 Jun 2007 23:00:50 +0000
Subject: Re: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070602230050.GA14606@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070602203206.GA13700@uranus.ravnborg.org>
In-Reply-To: <20070602203206.GA13700@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jun 02, 2007 at 02:02:20PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 2 Jun 2007 22:32:06 +0200
> 
> > The good news is that there is a nice pattern here. All sections that
> > have the references end in _patch.
> > So a simple solution is to teach modpost to not warn about references
> > from a section named *_patch to .init.text
> > 
> > I have such a change queued to modpost but would like to know if
> > you have any better ideas before pushing the change.
> 
> I think it would be great if we adopted a consistent naming
> convention for these things across as many platforms as possible.
> 
> So if it makes things easier, I can change the naming pattern
> I use on sparc64 for the patch sections to match what other
> platforms do.
> 
> IA64 uses .data.patch.* for example.

I would like a common namespace too.
To me .data.* gives association of storage for variables of
some kind which was why I did not suggest that sparc64 adapted
ia64 namescheme.

I thought of .fixup.patch.* but I did not manage to fully understand
how .fixup sections are used.
So a common naming scheme are welcome under the condition
that we find a good name.
If this requires update of both ia64 and sparc64 does not matter.

Btw I cannot see why ia64 does not give warnings with their use
of .data.patch.*. It could be a modpost bug...

	Sam

