From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 19 May 2004 00:04:25 +0000
Subject: Re: [PATCH] Sparc doesn't build without input support / can't turn off VTs
Message-Id: <20040519000425.GA7865@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040518232720.GO5289@earth.li>
In-Reply-To: <20040518232720.GO5289@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan McDowell <noodles@earth.li>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:27:20AM +0100, Jonathan McDowell wrote:

> Tried to build 2.6.6 for my Sparc LX today, which runs headless. Turned
> off all the input support and it failed to build - VT support couldn't
> be disabled and this needs input support it seems.

Correct.  Your patch is probably ok, but it doesn't solve the problem
the right way.  We really need to source the generic configuration
files, which would give us CONFIG_EMBEDDED, which in turn would allow
disabling VT (and INPUT).

I have patches that do virtually all of this for sparc and sparc64;
however, there is a great deal of work needed to include all the
driver configs before that part can go in.  Specifically, every driver
needs to have reasonable dependencies, which requires working with the
maintainers to verify that the deps I have are right.  If you'd like
to pick this up and get it done, please reply to me privately and I'll
give you what you need.

-- 
Keith M Wesolowski
