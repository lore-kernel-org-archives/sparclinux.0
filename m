From: Ed L Cashin <ecashin@uga.edu>
Date: Tue, 16 Mar 2004 20:51:47 +0000
Subject: REAL_PTRS_PER_PMD and TIF_32BIT
Message-Id: <87llm08qho.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  As  far as I can tell,  PTRS_PER_PMD will evaluate to  512 when a
32-bit binary in userland makes a system call or has a page fault,
since TIF_32BIT will be set in the thread flags.

I suppose that means that for every second-level page table associated
with a 32-bit binary's process, there are (2048 - 512) unused
pmd entries.  Is that correct?

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

