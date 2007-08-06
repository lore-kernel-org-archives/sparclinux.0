From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Mon, 06 Aug 2007 22:41:18 +0000
Subject: SIGSEGV information on SPARC64
Message-Id: <a8e8903d0708061541r2b6f2dcxa1a2f143db3a026b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello everyone,

I'm working on a project that needs to deal with SIGSEGV on SPARC64.
While I could find the faultive address in siginfo_t, it seems there
is no way to find the access type(read or write) in it. I tracked the
kernel source and found that ther kernel retrieves this information
(fault_code) from "flags" field of thread_info, which is stored in
register g6. However, I'm not sure if this information has been copied
to user space, or sigcontext? I couldn't find any clue when tracking
the delivery of signal and the setup of frames. If it is copied, how
can I find it so I can use it in my signal handler?

I'm new  to Linux kernel on SPARC and have spent a lot of time on this
problem. I hope someone could help me here.

Thanks a lot!

Jiaqi
