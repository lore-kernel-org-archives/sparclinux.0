From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 21:14:57 +0000
Subject: Re: [PATCH] fix warnings in psycho_common after ull conversion
Message-Id: <20090108211457.GA9144@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090108192723.GA27674@uranus.ravnborg.org>
In-Reply-To: <20090108192723.GA27674@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 08, 2009 at 01:30:03PM -0700, Chris Torek wrote:
> Just FYI:
> 
> >I tried the alternative solution and made IOMMU_PAGE_SHIFT an ULL
> >but that did not help.
> 
> The type of (X << Y) is independent of the type of Y.  Which means
> that these (unchanged) defines:
> 
> > #define  PSYCHO_IOMMU_TAG_WRITE	 (0x1UL << 21UL)
> > #define  PSYCHO_IOMMU_TAG_STREAM (0x1UL << 20UL)
> > #define  PSYCHO_IOMMU_TAG_SIZE	 (0x1UL << 19UL)
> 
> have extra ULs in them.  (Harmlessly, though.)
> 
> (I think some truly ancient versions of gcc, perhaps 1.x or 2.x,
> accidentally used the type of Y in computing a type for X<<Y, which
> might be where this started.)

What I see with my broken gcc is that the following code snippet:

$ cat ull.c
#include <stdio.h>

#define BAR 0UL
void bar(void)
{
        unsigned long long foo;

        printf("%lld, %ld, %lld", foo, BAR, foo & BAR);
}

Produces the following warning:

$ sparc64-unknown-linux-gnu-gcc -c -Wall ull.c
ull.c: In function `bar':
ull.c:8: warning: long long int format, long unsigned int arg (arg 4)

And davem with his native gcc (on a 64 bit sparc host) does not see it.

For the record my native gcc on my 32 bit host does NOT produce the warning.

The conclusion is simple.

   I should scrap my sparc gcc ASAP.

I will do soonish. Only problem is that I need to bring up a new
box that I do not have at the moment. My current box is running an
ancient fedora and I simply do not dare to touch it until I have
a replacement up and running.

My recently acuired SUN Blade 100 is not an option at the moment :-(

	Sam
