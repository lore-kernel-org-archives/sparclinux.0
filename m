From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 10 Dec 2008 07:41:42 +0000
Subject: Re: [PATCH 0/4]: Assembler unification...
Message-Id: <20081210074142.GA11011@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081209.153543.106486270.davem@davemloft.net>
In-Reply-To: <20081209.153543.106486270.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 09, 2008 at 03:35:43PM -0800, David Miller wrote:
> 
> This is just an FYI patch posting, I won't push this out to the
> sparc-next-2.6 GIT tree until I go over it some more and do some
> testing.
> 
> This series starts unifying assembler code that is essentially the
> same on 32-bit and 64-bit.
> 
> The differences are mostly in the branch instructions, since sparc
> 64-bit has prediction, and branch-on-register instructions.
> 
> We fabricate this using some helper macros in a new asm/asm.h header
> file.  We'll add new stuff there, as needed.
> 
> I also took the opportunity to get these files using the proper
> linux/linkage.h macros to define function boundaries.

Browsed the patches and unification looks good.
As I do not speak sparc assembler I did not look
at the unified code.

	Sam
