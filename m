From: Elad Lahav <elad_lahav@users.sourceforge.net>
Date: Mon, 09 Mar 2009 16:28:31 +0000
Subject: Signal handler arguments
Message-Id: <49B543AF.4090902@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

According to the man page (which, I believe, conforms to the POSIX standard), 
the third argument in a signal handler should be a pointer to a ucontext 
structure (assuming the SA_SIGINFO flag was passed to sigaction). However, under 
Sparc64, the kernel passes a pointer to a sigcontext structure (see line 472 in 
arch/sparc64/kernel/signal.c). This incompatibility should be either fixed or 
documented.

--Elad
