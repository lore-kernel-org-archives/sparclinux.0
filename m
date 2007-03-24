From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 24 Mar 2007 16:34:32 +0000
Subject: Re: sparc32 SMP debugging advice needed
Message-Id: <1174754072.3277.11.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <460449B6.7010308@earthlink.net>
In-Reply-To: <460449B6.7010308@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2007-03-23 at 17:42 -0400, Robert Reif wrote:
> Any advice on how to approach fixing these issues?  I can test
> patches.

Sadly, it seems that in the case of sparc32, no one who is willing is
able, and no one who is able is willing.

There is no maintainer, Dave Miller isn't willing to take it on (not
that I blame him), and much of the hardware is starting to fail, making
debugging that much more fun.

Given that UP has so many issues, I don't even fathom how SMP is going
to work right anytime soon.

I'd be happy to be proven wrong here, but the likelyhood of a stable
sparc32 kernel is very very low.

~spot

