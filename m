From: "Keith M. Wesolowski" <wesolows@foobazco.org>
Date: Fri, 26 Mar 2004 07:09:20 +0000
Subject: Re: [PATCH] Patch for arch/sparc/math-emu/math.c
Message-Id: <20040326070920.GB28857@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040325170740.GB11895@artsapartment.org>
In-Reply-To: <20040325170740.GB11895@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 25, 2004 at 11:07:40AM -0600, Art Haas wrote:

> Here's a small patch that fixes GCC-3.5 compilation. The compiler
> doesn't like the "label at end of compound statement", so by simply
> adding 'break;' to the "default:" condition the problem is resolved
> if 'DEBUG_MATHEMU' is not defined.

Applied, thanks.

-- 
Keith M Wesolowski
