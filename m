From: "Keith M. Wesolowski" <wesolows@foobazco.org>
Date: Fri, 26 Mar 2004 07:08:36 +0000
Subject: Re: [PATCH] Patch for arch/sparc/kernel/sys_sunos.c
Message-Id: <20040326070836.GA28857@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040325170312.GA11895@artsapartment.org>
In-Reply-To: <20040325170312.GA11895@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 25, 2004 at 11:03:12AM -0600, Art Haas wrote:

> Here's a small patch that fixes a GCC-3.5 compilation error with the
> file. The new GCC doesn't accept the cast-on-lvalues. A essentially
> identical patch was applied to fs/readdir.c to fix this problem - see
> the 1.22->1.23 changes.

Applied, thanks.

-- 
Keith M Wesolowski
