From: "J.J.Green" <j.j.green@sheffield.ac.uk>
Date: Sun, 25 Feb 2007 23:58:48 +0000
Subject: Re: sparc64 / bbc_i2c.c
Message-Id: <Pine.LNX.4.64.0702252352310.32309@parallax.ddns.shef.ac.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1171978032.18442.11.camel@lax.shef.ac.uk>
 <20070225044754.1d849a8d.akpm@linux-foundation.org>
In-Reply-To: <20070225044754.1d849a8d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Andrew

> The code around there looks relatively unbuggy to me.  Removing that
> remove_wait_queue() would be very bad - it would cause later stack
> corruption.
>
> msleep_interruptible() certainly shouldn't consume CPU like that.  Do we
> know where the CPU time is being spent?  The output of:
>
> readprofile -r
> sleep 10
> readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40
>
> would tell us.

As was mentioned in another reply, this message by
Joerg Friedrich

   http://lists.debian.org/debian-sparc/2007/02/msg00045.html

gives a possible explanantion of where the time is going.
I applied the patch to the debian kernel sources for 2.6.18,
it applied cleanly and fixed the problem.

I have the upatched kernel in /boot so I can run the tests
you mentioned fairly easily -- please let me know if you'd
still like me to do that.

Jim
-- 
J.J. Green, Dept. Applied Mathematics, Hicks Bld.,
University of Sheffield, UK.   +44 (0114) 222 3742
http://pdfb.wiredworkplace.net/pub/jjg


