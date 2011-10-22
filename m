From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 22 Oct 2011 09:43:39 +0000
Subject: Re: longjmp question
Message-Id: <20111022094339.GA8547@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 22, 2011 at 05:05:05AM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 22 Oct 2011 10:00:24 +0100
> 
> > Is something conceptually wrong with just doing this:
> > 
> > asm volatile ("save; flush; restore");
> > 
> > It fixes the problem for freebsd (will test on linux later today), and 
> > does not rely on compiler doing (or not doing) the "right" 
> > optimization.
> 
> I would not do a "naked" save here, please just use the construct
> I showed you with the %o7 register clobber.

Yes, I missed that save is not allocating any memory, which is 
wrong. What I actually had in mind was this:

asm volatile ("save %sp, -96, %sp; flushw; restore");

My concern with the approach you are proposing is that compiler 
may (in the future, perhaps) just optimize out the helper function, 
making arrangements to save %o7 in one of the unused registers, thus 
removing allocation of another register window and breaking it again.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
