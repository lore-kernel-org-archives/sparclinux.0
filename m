From: David Miller <davem@davemloft.net>
Date: Fri, 21 Nov 2014 19:51:44 +0000
Subject: Re: [PATCH] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <20141121.145144.1895483751841544664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <546D2D42.2070202@oracle.com>
In-Reply-To: <546D2D42.2070202@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 19 Nov 2014 18:52:34 -0500

> In vdc_end_one() of sunvdc.c a non-zero status indicates an error from
> Solaris
> vds. In the case of an actual disk as the vds backend, the error comes
> from the

In plain text, this looks terrible.

Please properly format your commit message body to ~80 columns, but
don't do it in a way where you get a full line of text, then a line
with a few words, then another full line of text.

Look at the plain ascii representation of the result and think about
what that will look like to other people trying to read it.  Don't
assume some GUI will magically fix the formatting for you.
