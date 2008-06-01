From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 01 Jun 2008 07:20:45 +0000
Subject: [RFC] unify exported sparc header files?
Message-Id: <20080601072044.GA16220@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David et al.

While looking into improving our current
headers_check stuff I noticed that sparc is
the sole user of ALTARCH in include/asm-sparc64/Kbuild
and getting rid of this hack would be really nice.

So I started to look into the two possibilities:

- Unifying all sparc header files
  Assisted by a small script this was a trivial
  excersise but it left me with a lot of
  header files named *_32.h and *_64.h
  This was too messy IMO so I dropped that.

- Unifying only the userspace exported headers
  This turned out to achieveable but before proceeding
  I request a bit feedback.

I started out analysing current situation.
The following is a list of all user exported headers for
sparc and sparc64:

apb.h             sparc64 only
apc.h             sparc32 only
asi.h             non-unified
bbc.h             sparc64 only
bpp.h             unified (master in asm-sparc)
display7seg.h     sparc64 only
envctrl.h         sparc64 only
fbio.h            non-unified
jsflash.h         sparc32 only
openprom.h        non-unified
openpromio.h      equal
perfctr.h         equal
psrcompat.h       sparc64 only
psr.h             sparc64 only
pstate.h          sparc64 only
reg.h             non-unified
traps.h           sparc32 only
uctx.h            sparc64 only
utrap.h           sparc64 only
vfc_ioctls.h      sparc32 only
watchdog.h        sparc64 only

sparc32 only => This header file exist only in asm-sparc32/
sparc64 only => This header file exist only in asm-sparc64/
non-unified  => The 32 and 64 bit variant differs
unified      => A straight include of asm-sparc/file.h form asm-sparc64
equal        => The files are identical for 32 and 64 bit

To sum up:
  4 files are sparc32 specific
  10 files are sparc64 specific
  4 files differ between 32 and 64 bit
  2 files should be unified (will send a patch)

What I suggest to do:
For all sparc32 specific files:
 - nothing

For all the sparc64 specific files:
 - copy file to asm-sparc
 - wrap the copied file in
   #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
      ... file content ...
   #endif
 - straight include from asm-sparc64 of the asm-sparc file
- Or I could just drop the wrapping?

For the non-unified files:
- Add content to asm-sparc file and wrap it into:
   #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
	... sparc64 file content
   #else
	... sparc32 file content
   #endif


Comments?

	Sam
