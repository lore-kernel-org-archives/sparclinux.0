From: Christoph Hellwig <hch@lst.de>
Date: Mon, 15 Jun 2020 13:00:26 +0000
Subject: properly support exec and wait with kernel pointers
Message-Id: <20200615130032.931285-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

this series first cleans up the exec code and then adds proper
kernel_execveat and kernel_wait callers instead of relying on the fact
that the early init code and kernel threads implicitly run with
the address limit set to KERNEL_DS.

Note that the cleanup removes the compat execve(at) handlers (almost)
entirely, as we can handle the compat difference very nicely in a
unified codebase.  The only exception is x86 where this would list the
handlers twice in the same syscall table due to the messed up x32
design.  I had to add an extra compat handler just for that case, but
maybe someone has a better idea.
