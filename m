From: Rob Radez <rob@osinvestor.com>
Date: Fri, 30 Apr 2004 15:10:28 +0000
Subject: __builtin_trap() broken?
Message-Id: <20040430151028.GA10534@osinvestor.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Howdy folks,
Trying to compile fs/reiserfs/journal.c in 2.6.6-rc1 (UP, sparc32, gcc
3.3.3) ICE'd with an 'unrecognizable insn'.  It looks like there's a bad
interaction with __builtin_trap() again, for at least gcc 3.3.3 from
debian/testing.  gcc 2.95.4 from debian does not ICE.  I've tried to
pare down the code as much as possible to get a useful test case, and
have attached said test case below.  This is where I go "Oh, crap, gcc"
and run away in horror screaming like a little baby.  As a workaround,
going back to defining bug_trap as __asm__ __volatile__ ("t 0x5\n\t" : :
) appears to work.

The ICE I get with my test program is:
rradez@notporn:~$ gcc -O2  -m32 -c  reiserfs-ice.c
reiserfs-ice.c: In function `write_one_transaction':
reiserfs-ice.c:15: error: unrecognizable insn:
(insn 61 19 62 1 0x501b2080 (set (reg:SI 112)
        (zero_extract:SI (reg:SI 110)
            (const_int 1 [0x1])
            (const_int 31 [0x1f]))) -1 (nil)
    (expr_list:REG_DEAD (reg:SI 110)
        (nil)))
reiserfs-ice.c:15: internal compiler error: in extract_insn, at
recog.c:2175
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.

If I'm being stupid, let me know and I'll try to remedy that.  The code
below while funky was extracted from what appears to actually be going
on.

Regards,
Rob

/* compile gcc -O2 -m32 -c -o reiserfs-ice.o reiserfs-ice.c */
/* Reading specs from /usr/lib/gcc-lib/sparc-linux/3.3.3/specs
 * Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --with-cpu=v7 --enable-objc-gc sparc-linux
 * Thread model: posix
 * gcc version 3.3.3 (Debian 20040401) */

static inline int my_prepared(unsigned long *bh) {
	return bh && (1UL & *bh);
}

void write_one_transaction(unsigned long *bh)
{
    if (my_prepared(bh))
        __builtin_trap();
}
