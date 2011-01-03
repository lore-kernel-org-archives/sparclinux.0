From: Frans van Berckel <fberckel@xs4all.nl>
Date: Mon, 03 Jan 2011 09:15:45 +0000
Subject: Re: [PATCH v2 0/9] sparc: unify sparc/boot/piggyback
Message-Id: <1294046145.1549.36.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <20110101205701.GA4544@merkur.ravnborg.org>
In-Reply-To: <20110101205701.GA4544@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-01-03 at 09:52 +0100, Frans van Berckel wrote:
> Have seen this happening on different sparc boxes, several times.
> 
> Boot the install cd, now in rescue mode. Chrooting the installed
> partition and run # silo -u -f again. Next reboot the Ultra.

You can find more about it ... http://tinyurl.com/382l2sf

"The Debian bug was caused by kernel 2.6.30 incorrectly reporting the
machine type via uname, so SILO was installing the 32-bit second stage
boot loader instead of 64-bit one, which leads to a failure like that"

Thanks,

Frans van Berckel

