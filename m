From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 24 May 2006 18:00:59 +0000
Subject: sigreturn on sparc64
Message-Id: <e5270r$q83$1@terminus.zytor.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm having an issue with klibc on sparc64 (i.e. a 64-bit userspace
binary), which doesn't appear on sparc32:

If I leave the signal restorer function as NULL, I get a SIGSEGV on
attempting to return from the signal handler.

If I generate a system call stub for rt_sigreturn, and pass that in as
the restorer, then the process will loop forever on signal handler
return.

A lot of architectures have ugly corners in this area (i386, for
example, needs to drop one word from the stack before calling the
sigreturn system call.)  However, I simply don't understand the SPARC
architecture well enough to understand if/what I'm supposed to do
here, or if this is simply a bug.

	-hpa

