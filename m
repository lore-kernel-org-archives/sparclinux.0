From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 30 Dec 2004 11:07:07 +0000
Subject: PAGE_SIZE and native vs. emulated 32-bit SPARC ABI
Message-Id: <20041230110707.GC29332@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It seems that most/all 32-bit SPARC programs are written and compiled
for emulated 32-bit on sun4u, which has an 8KB PAGE_SIZE, and returns
8KB for getpagesize(). This is unfortunately causing spectacular
failures on some of my favorite regression tests for memory management,
which are interpreters using memory protection-based garbage collectors.

In particular, with a simple LD_PRELOAD to return a falsified 8KB
PAGE_SIZE, sbcl (a Common Lisp interpreter and compiler) may be made to
run, where it can't without such. The installation procedure runs the
interpreter, which is basically the extent of what I do with the ones
that run themselves during the installation procedure. For others just
starting up the interpreter serves as a simple testcase.

So, the question arises as to what to do about these ABI breakages.
It's unclear that changing the page size to 8192 unconditionally will
work, as there are suspected breakages in the other direction, as
another of those interpreters with protection-based GC that is strongly
suspected of being hardwired to a 4KB PAGE_SIZE.

Any ideas?


-- wli
