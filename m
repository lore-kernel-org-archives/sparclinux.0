From: Admar Schoonen <admar@luon.net>
Date: Sat, 14 Aug 2004 13:41:55 +0000
Subject: Re: 2.6.8-rc4 on sparc64 oopses at boot and no working XFree86
Message-Id: <20040814134154.GL21828@azrael.luon.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(sorry for the cross posting; I had the wrong list first)

On Fri, Aug 13, 2004 at 09:03:09AM -0700, David S. Miller wrote:
> I have no idea wrt. your xfree86 problems.

Well, I guess it's related to the fact that I have 2 Ati mach64
framebuffers (2 x PGX64) in the machine. On that machine XFree86
segfaults with 2.6.8-rc4 segfaults, while it works fine with 2.6.7.

I've just tried 2.6.8-rc4 on an ultra 5 with just 1 Ati mach64
framebuffer (PGX24) and XFree86 works fine there too, so I guess it's
due to the secondary framebuffer.

I'll ask the linux-fbdev guys about this issue.
 
> Why not post this on the correct list, sparclinux@vger.kernel.org,
> btw?

Sorry, I didn't know it existed. I should have looked better of course.

Admar

(Please CC any replies to me, as I'm not subscribed to this list.)
