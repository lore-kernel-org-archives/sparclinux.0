From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 Jan 2009 12:26:46 +0000
Subject: Can we rely solely on __arch64__
Message-Id: <20090103122645.GA18259@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David et al.

So far we have in the .h files used:

#if defined(__sparc__) && defined(__arch64__)

But I just tried with the two sparc gcc's I have here.
Both (as expected) define __sparc__ and only the sparc64 version
define the __arch64__ symbol.

So how about simplifying the checks to read:

#ifdef __arch64__

It is much more strightforward to read.
Testing on __sparc__ in the sparc specific header files
is a noop. And if the header files are anyway used
then the user has much bigger problems than the
32 / 64 bit differences.

I have in the fixed unified ipcbuf.h patch used the
simpler format so please do not apply it if you do not agree.

I started to look into this as it did not feel good to
use something like this:

#if !(defined(__sparc__) && defined(__arch64__))
sparc specific stuff
#endif

I also tried the alternative:
#if defined(__sparc__) && defined(__arch64__)
#else
sparc specific stuff
#endif

Neither looked 'nice'.

I ended up with:
#ifndef __arch64__
sparc specific stuff
#endif

Which was acceptable.

	Sam 
