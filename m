From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Jan 2004 21:26:54 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <1073338013.22653.227.camel@zorak>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For posterity (and googlers), this problem boiled down to be caused by
compiling sparc32 with gcc 3.3 instead of 3.2 (when I built with 3.2,
the oops went away).

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

