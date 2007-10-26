From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2007 22:01:24 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071026.150124.239648427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 26 Oct 2007 14:30:21 +0200

> at least it runs with 100% CPU, attaching strace to the pid doesn't give
> any results....
> strace-ing the whole process doesn't result in more useful output, but
> the hanging processes were killable when they were running under strace...

When it runs with 100% CPU that's what makes me suspect it's
spinning in the kernel futex code somewhere or similar.

One thing I notice in the debian bug report is a mention of libnss-db

So I did some testing here and without libnss-db installed, running
dpkg-query does not use futexes at all.

But once I install libnss-db and enable it (by running 'make' under
/var/lib/misc then editing /etc/nsswitch.conf to make 'db' get
searched first) indeed dpkg-query starts using futexes via the
libnss-db library.

Josip, do you guys have libnss-db or similar in use on the buildd
machine?

For those who can reproduce it an have something like libnss-db
enabled, try disabling it.
