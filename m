From: Kai-Min Sung <k@kaisung.com>
Date: Sat, 17 Jan 2004 01:33:01 +0000
Subject: SP_TRAP_LINUX
Message-Id: <Pine.LNX.4.44.0401161725530.20441-100000@eq4.oversee.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I was looking at the file include/asm-sparc/traps.h and the following 
sequence caught my eye:

#define SP_TRAP_SOLARIS 0x88 /* Solaris System Call */ 
#define SP_TRAP_NETBSD 0x89 /* NetBSD System Call */
#define SP_TRAP_LINUX   0x90         /* Linux System Call */

Shouldn't SP_TRAP_LINUX be defined as 0x8a? 

Also, where's the corresponding traps.h file for asm-sparc64?

Thanks,
-Kai

