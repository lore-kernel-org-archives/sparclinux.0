From: Chris Torek <chris.torek@windriver.com>
Date: Tue, 09 Dec 2008 11:46:52 +0000
Subject: random dumb (or maybe not) question about sparc64
Message-Id: <200812091146.mB9Bkqn02109@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's something I think is possibly a bug:

The ptrace code uses flushw_user() to push user windows ... good
enough, except, a bunch of other code then also does
synchronize_user_stack(), but ptrace does not.

So, how does this work if you happen to hit a paged-out page in
ptrace at the perfect inopportune time?

(This depends on whether you are ptrace()ing yourself, of course,
which is an odd thing to do.  But it might also hit if you stop a
process that was pushing its registers to a paged-out page and once
resumed, is going to finish copying spilled windows from the thread
info reg_window[] array.)

There could be something obvious that I am missing, though.

(This came up as an aside while I was fussing with some moderately
ugly stack tracing code, doing user stack traces within the kernel.)

Chris
