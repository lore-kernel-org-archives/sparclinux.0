From: Meelis Roos <mroos@math.ut.ee>
Date: Thu, 01 Apr 2004 19:34:43 +0000
Subject: Re: ioctl32 translations for clock
Message-Id: <Pine.GSO.4.44.0404012234080.27689-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> It's always going to spit these out, this is hwclock trying to figure out
> the access method and one thing it tries are the old M68K platform specific
> ioctls which the translation layer doesn't handle of course.

Yep, sounds familiar.

> > Cannot access the Hardware Clock via any known method.
>
> I've seen this too, and upgrading to current debian fixed all of that.

This is a current debian. Will investigate tomorrow.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

