From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 16 Jul 2009 20:16:01 +0000
Subject: Re: [PATCH,resend] sparc64: build compressed image (zImage) by
Message-Id: <20090716201601.GA6038@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200907162041.53181.elendil@planet.nl>
In-Reply-To: <200907162041.53181.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <elendil@planet.nl>
Cc: sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org, Jurij Smakov <jurij@wooyd.org>, David Miller <davem@davemloft.net>

On Thu, Jul 16, 2009 at 08:41:52PM +0200, Frans Pop wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Subject: sparc64: build compressed image (zImage) by default
> 
> Besides creating the uncompressed vmlinux image for sparc64, also
> create a compressed zImage. This is more consistent with other
> architectures and required to make the 'deb-pkg' target work.
> 
> Signed-off-by: Jurij Smakov <jurij@wooyd.org>
> Signed-off-by: Frans Pop <elendil@planet.nl>
> 
> ---
> The patch was taken from the Debian kernel package. It was written by
> Jurij. I added his Signed-off-by with his permission.
> 
> The patch was tested to work during my recent tests for the cmd64x issue.

Hmmm..
This path does the following:
1) zImage becomes default for sparc and sparc64
2) fixes zImage on sparc64 (it dod not work before)
3) On sparc zImage is a stripped version of vmlinux, on sparc64 it is a gzipped not-stripped
   version of vmlinux - so it introduces a significantly different zImage.

Could we agree on the _same_ format for zImage on sparc and sparc64 and then apply that patch?

I know Julian is working on unifying piggyback_{32,64}.c so maybe that is
covered by his work?

If we fix it so zImage is the same thing on sparc and sparc64 this could go in before
we see the unification of piggyback.
For deb-pkg to work we could just let the sparc64 version be a stripped version - no?
Then you would have covered my main complaint about this patch.

	Sam
