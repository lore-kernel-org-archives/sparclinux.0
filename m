From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 08 Feb 2005 16:58:07 +0000
Subject: Re: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <1107881887.3664.73.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1107553760.3951.211.camel@localhost.localdomain>
In-Reply-To: <1107553760.3951.211.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2005-02-08 at 17:42 +0100, Georg Chini wrote:

> maybe this is an error in the driver for TGX. My SS5 has a TCX card and
> I had the same problem (screen blank but no X visible).

I've already got your fix applied, it doesn't look to be related. With a
similar patch, I can make the cg3 output the framebuffer fine, but not
X.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

