From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Sat, 07 May 2016 15:50:32 +0000
Subject: accessing stacked FPU state in 32-bit SIGFPE handler?
Message-Id: <22318.3784.29204.471465@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

What is the approved way of accessing the stacked FPU state from a
SIGFPE handler (sigaction + SA_SIGINFO) in a 32-bit process?  I need
to update parts of that state.

The third parameter to the handler is a sigcontext pointer, but the
struct ends just before the stacked fpu_save pointer.  Also, the type
that fpu_save points to doesn't appear to be defined by glibc's headers.

I could duplicate the kernel's types (32-bit __siginfo_fpu_t and struct
rt_signal_frame), but that feels a bit unsafe unless there's a statement
that they form a de-facto ABI.
