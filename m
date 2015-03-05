From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 05 Mar 2015 06:31:43 +0000
Subject: Re: [PATCH v3 8/8] x86: switch to using asm-generic for seccomp.h
Message-Id: <20150305063143.GA23023@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
 <1425518828-16017-9-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-9-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.orglin


* Kees Cook <keescook@chromium.org> wrote:

> Switch to using the newly created asm-generic/seccomp.h for the 
> seccomp strict mode syscall definitions. The obsolete sigreturn 
> syscall override is retained in 32-bit mode, and the ia32 syscall 
> overrides are used in the compat case. Remaining definitions were 
> identical.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
