From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 18 Dec 2007 12:06:55 +0000
Subject: sparc64 with 32-bit user-space context switching question
Message-Id: <18279.47071.463773.734087@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'd like to use the BR (branch on integer register)
instruction in 32-bit user-space code on sparc64.
The problem is that BR interprets the entire 64-bit
contents of the register, which depending on how
the value was produced may or may not do the right
thing in 32-bit code.

My main question is: what does the kernel do to the
high 32 bits of the 64-bit integer registers during
context switches? Does it
a) preserve all 64 bits,
b) clear the high halves (truncate to 32 bits), or
c) insert unpredictable junk?

I can handle a) and b), but c) means that I cannot
ever safely use BR in 32-bit userspace.

Also, does anyone know what Solaris does to the
high 32 bits during context switches?

/Mikael
