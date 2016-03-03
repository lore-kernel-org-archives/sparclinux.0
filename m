From: Alex McWhirter <alexmcwhirter@triadic.us>
Date: Thu, 03 Mar 2016 06:31:53 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <56D7DA59.1050201@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 02/28/2016 12:57 PM, Al Viro wrote:
> On Sun, Feb 28, 2016 at 06:41:37PM +0100, Sam Ravnborg wrote:
>> On Sun, Feb 21, 2016 at 09:14:45PM +0100, Sam Ravnborg wrote:
>>> Added Al Viro, as author of the commit git bisect pointed out.
>> Al, have you by chance looked at this bug report?
> Not enough details...
>
>> Alex, did you try to revert just this single patch on mainline
>> to verify this _is_ indeed the culprint?
> Not a chance - a lot of stuff past it depends on that series.
>
> How does rsync die there?  oops, segfault, something else?  Any way to
> reproduce it?

Also you should be able to reproduce it on any sun4u hardware, as it
occurs on all of my boxes. Sun4v may paint a different picture.
