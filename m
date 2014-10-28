From: Steve Capper <steve.capper@linaro.org>
Date: Tue, 28 Oct 2014 10:49:18 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20141028104917.GC4187@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20141024.133249.71272218161411159.davem@davemloft.net>
 <CA+55aFyqtuh53PmwO65NtM_PrPd51=EMWiv8dU8bNTrXL59=Jg@mail.gmail.com>
 <20141027140938.142f83a4c3bc6512dd73b54c@linux-foundation.org>
 <20141027.184327.1734954193920971940.davem@davemloft.net>
In-Reply-To: <20141027.184327.1734954193920971940.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 27, 2014 at 06:43:27PM -0400, David Miller wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Mon, 27 Oct 2014 14:09:38 -0700
> 
> > Perhaps sparc should be defining CONFIG_HAVE_GENERIC_RCU_GUP.
> > 
> > We really should switch x86 to the generic version - from a quick read
> > it looks like it will work without needing any changes.
> > 
> > Steve, thoughts?
> 
> We need to add the necessary hooks to the generic code so that x86
> doesn't so specualtive gets and instead do direct increments,
> otherwise it's a performance regression, and then sparc can make use
> of that as well.

Agreed, I think x86 may require a helper to read 64-bit ptes (as it
can't do that atomically). Also I think there's some subtlety in the
way access_ok works that should be checked.

The overall structure of the code looks the same to me, and I think it
would be beneficial to extend then use the generic version for x86.

Cheers,
-- 
Steve
