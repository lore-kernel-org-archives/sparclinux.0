From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Oct 2012 21:49:15 +0000
Subject: Re: [PATCH] sparc64: Improvde documentation and readability of atomic backoff code.
Message-Id: <20121028214915.GA4038@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20121028.161719.169284944959004709.davem@davemloft.net>
In-Reply-To: <20121028.161719.169284944959004709.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Oct 28, 2012 at 04:17:19PM -0400, David Miller wrote:
> 
> Document what's going on in asm/backoff.h with a large and descriptive
> comment.  Refer to it above the cpu_relax() definition in
> asm/processor_64.h
> 
> Rename the pause patching section to have "3insn" in it's name like
> the other patching sections do.
> 
> Based upon feedback from Sam Ravnborg.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org

Thanks - looks much better now!

If you have not yet pushed it out you may consider
fixing the spelling error in the first line of the changelog.

	Sam
