From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 12 Feb 2005 13:49:12 +0000
Subject: Re: Xorg doesn't work on the cg3
Message-Id: <1108216153.31423.17.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1108062924.3919.22.camel@localhost.localdomain>
In-Reply-To: <1108062924.3919.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2005-02-11 at 23:44 -0800, David S. Miller wrote:

>I'm applying this obvious cg3 fix.  There is a bunch of other
>patches that are necessary to get X fully working on both cg14
>and cg3 aren't there?  At a minimum there's that BUG() removal
>in the srmmu code, right?

Yes. We also need the other cg3 patch to make the framebuffer console
work, and the sbuslib patch to make cg6 work in X. Both of these are in
my previous post on this thread.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

