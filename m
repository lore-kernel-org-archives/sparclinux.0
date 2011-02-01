From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 01 Feb 2011 19:59:26 +0000
Subject: Re: [PATCH] sparc32: unaligned memory access (MNA) trap handler bug
Message-Id: <20110201195926.GA11487@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 01, 2011 at 07:03:43PM +0100, Daniel Hellstrom wrote:
> Since the merge process of the sparc and sparc64 the sparc32
> MNA trap handler does not emulate stores to unaligned addresses
> correctly. MNA operation from both from kernel and user space
> are affected.

Well spotted!

This bug was actually introduced by:
f0e98c387e61de00646be31fab4c2fa0224e1efb "[SPARC]: Fix link errors with gcc-4.3"

I wanted to check if there were similar bugs introduced, but
this looks like a solo incident.

I grepped for "%1" in the other *.S files, no hits.
[Likewise for "%2", "%3", "%4"]

Patch looks good to me.
Reluctant with an "Acked-by" only because I do not feel confident
with the code in question. The change looks obviously correct.

I noticed you copied Greg on this. I guess you did so because you
consider this -stable material.

A better way to do so is to add:

Cc: <stable@kernel.org>

Then the stable team(s) will all be notified when this patch is applied
by Linus to mainline.

This is also a strong hint for David to apply this to sparc-2.6.git and not
sparc-next-2.6.git
But being explicit is always preferred.

	Sam
