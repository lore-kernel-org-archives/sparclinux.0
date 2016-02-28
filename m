From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sun, 28 Feb 2016 17:57:18 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <20160228175718.GO17997@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 28, 2016 at 06:41:37PM +0100, Sam Ravnborg wrote:
> On Sun, Feb 21, 2016 at 09:14:45PM +0100, Sam Ravnborg wrote:
> > Added Al Viro, as author of the commit git bisect pointed out.
> 
> Al, have you by chance looked at this bug report?

Not enough details...

> Alex, did you try to revert just this single patch on mainline
> to verify this _is_ indeed the culprint?

Not a chance - a lot of stuff past it depends on that series.

How does rsync die there?  oops, segfault, something else?  Any way to
reproduce it?
