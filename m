From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Mar 2013 07:48:46 +0000
Subject: Re: [PATCH 4/5] sparc: use asm-generic version of types.h
Message-Id: <20130331074846.GA13732@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Mar 30, 2013 at 07:17:37PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 30 Mar 2013 23:07:33 +0100
> 
> > On Sat, Mar 30, 2013 at 06:02:47PM -0400, David Miller wrote:
> >> From: Sam Ravnborg <sam@ravnborg.org>
> >> Date: Sat, 30 Mar 2013 22:44:25 +0100
> >> 
> >> > We failed to include the header file that define __u16 because __sparc__
> >> > was not defined.
> >> 
> >> Is this another problem with your cross compiler?
> >> 
> >> __sparc__ should always be defined, it's a CPP pre-define.
> > 
> > Maybe..
> > 
> > But Fengguang Wu see the same issue in his 0-day
> > testing.
> > But maybe we have both gcc issues.
> 
> I'm not fundamentally against these changes, if there would be
> a good reason for them.
> 
> But it seems to me that these cross compilers are terminally broken,
> you cannot seriously even expect them to be able to compiler userland
> successfully at all because __linux__ and __sparc__ must be CPP
> predefined for userspace to compiler properly.

I confused myself yesterday concerning this patch/fix...

The build error in samples/hiddraw happens because the said code
is built using the host gcc - and not my cross-compiled gcc.
This is the intention - when readign the Makefile.

So this is not a broken cross gcc.

I think they have mixed it up and what they really wanted was to build
a regular user binary for the selected architecture.
I will followup on this in another thread.


In sparc headers we use the following pattern:

    #if defined(__sparc__) && defined(__arch64__)

    sparc64 specific stuff

    #else

    sparc32 specific stuff

    #endif

In types.h this pattern was not followed and here
we only checked for __sparc__ for no good reason.
It was a left-over from long time ago.

I checked other architectures - and most of them
do not have any such checks. And all the recently
merged versions uses the asm-generic version

So independent on the build error reported by Fengguang Wu
and independent on my broken cross gcc this patch is fine.

	Sam
