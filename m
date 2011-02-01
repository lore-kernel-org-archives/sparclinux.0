From: David Miller <davem@davemloft.net>
Date: Tue, 01 Feb 2011 20:37:42 +0000
Subject: Re: [PATCH] sparc32: unaligned memory access (MNA) trap handler bug
Message-Id: <20110201.123742.71116847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 1 Feb 2011 20:59:26 +0100

> On Tue, Feb 01, 2011 at 07:03:43PM +0100, Daniel Hellstrom wrote:
>> Since the merge process of the sparc and sparc64 the sparc32
>> MNA trap handler does not emulate stores to unaligned addresses
>> correctly. MNA operation from both from kernel and user space
>> are affected.
> 
> Well spotted!

Indeed.

> This bug was actually introduced by:
> f0e98c387e61de00646be31fab4c2fa0224e1efb "[SPARC]: Fix link errors with gcc-4.3"

I'll make a note of this in the commit message.

> A better way to do so is to add:
> 
> Cc: <stable@kernel.org>
> 
> Then the stable team(s) will all be notified when this patch is applied
> by Linus to mainline.

I'll take care of the -stable submission.

I wish binutils wouldn't accept %1 as a register, nobody sane uses that
format for register specifications and when it does happen (like here)
it's a typo and a bug.

Thanks guys, I'll apply this and queue it up for -stable!
