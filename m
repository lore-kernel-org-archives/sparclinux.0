From: "David S. Miller" <davem@redhat.com>
Date: Fri, 27 Aug 2004 01:06:28 +0000
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040826180628.1fd4e09f.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040818235528.GA8070@triplehelix.org>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 26 Aug 2004 17:57:27 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> syslog(0x2, 0xefffed20, 0x1000
> 
> At this point everything hangs. I'm not sure if there's another four
> digits after the 0x1000.
> 
> Ideas?

This should fix it.

=== arch/sparc64/kernel/sys32.S 1.9 vs edited ==--- 1.9/arch/sparc64/kernel/sys32.S	2004-06-03 14:51:21 -07:00
+++ edited/arch/sparc64/kernel/sys32.S	2004-08-26 17:49:39 -07:00
@@ -120,7 +120,7 @@
 SIGN2(sys32_setpgid, sys_setpgid, %o0, %o1)
 SIGN3(sys32_setpriority, sys_setpriority, %o0, %o1, %o2)
 SIGN1(sys32_ssetmask, sys_ssetmask, %o0)
-SIGN2(sys32_syslog, sys_syslog, %o0, %o1)
+SIGN2(sys32_syslog, sys_syslog, %o0, %o2)
 SIGN1(sys32_umask, sys_umask, %o0)
 SIGN3(sys32_tgkill, sys_tgkill, %o0, %o1, %o2)
 SIGN1(sys32_sendto, sys_sendto, %o0)
