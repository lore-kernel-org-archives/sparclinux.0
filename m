From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 08 Dec 2004 00:54:11 +0000
Subject: Re: mmap breakage
Message-Id: <1102467250.3704.37.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-12-07 at 06:00, Jurij Smakov wrote:
> On the sparclinux@vger list we have been recently discussing an issue of 
> ld-linux.so.2 failing with SIGILL when executed directly with the 
> executable name as an argument [0]. This problem was traced to the mmap 
> call overwriting portions of ld-linux.so.2 itself.
...
> 
> > We could put ld-linux.so.2 somewhere else, that's not too hard.  I
> > would suggest putting it at that 0xfffff80000000000 address I quoted
> > above since that is where the rest of the shared objects are going
> > to end up anyways.

Just thinking about the nasty way that this fails (ld-linux.so.2
overwrites itself presumably causing seemingly random failures depending
on what it overwrites with). How about adding a check prior to mapping
to detect when the situation arises and then fail gracefully.

It would probably require adding a few symbols at the start and end of
each executable section (text, data, bss). Then rounding them to page
aligned values and just checking that you aren't overwriting them. Then
again I don't know the code so it might not turn out to be quite that
easy.

Richard

-- 
richm@oldelvet.org.uk

