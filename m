From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jan 2011 21:28:52 +0000
Subject: [PATCH v2 0/7] sparc64: drop deprecated irq features
Message-Id: <20110122212852.GA31675@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This set of patches update sparc64 so deprecated genirq
features are no longer used.

I did this mainly to understand the genirq stuff better.
Originally I looked into sparc64 code and was confused
because it used deprecated stuff. So the logical step
was to update sparc64 to avoid the deprecated stuff.
I did so and the result follows.

Updates in v2:
- Updated a few changelog entries
- Added two patches to rename virt_irq => irq
  This is subjective - but I like the more consitent naming
  The renaming is in the last two patches that can be ignored
- Boot tested on Niagara-2+ (by David Miller)
- Boot tested on Blade 100 (me)
  I do not have userland working yet - not related to this
- For good measure I also boot tested on my SPARC classic

The patches are based on plain -rc2.
I consider the patches ready to apply to sparc-next.

	Sam
