From: Kaj-Michael Lang <milang@tal.org>
Date: Fri, 09 Sep 2005 23:37:37 +0000
Subject: sparc32 kernel compilation problem with latest binutils
Message-Id: <Pine.LNX.4.61.0509100228130.10415@tori.tal.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm trying to compile 2.6.13, but it fails with:

   CC      arch/sparc/kernel/sparc_ksyms.o
{standard input}: Assembler messages:
{standard input}:1737: Error: Local symbol `udiv' can't be equated to undefined symbol `.udiv'
{standard input}:1737: Error: Local symbol `div' can't be equated to undefined symbol `.div'
{standard input}:1737: Error: Local symbol `umul' can't be equated to undefined symbol `.umul'
{standard input}:1737: Error: Local symbol `mul' can't be equated to undefined symbol `.mul'
{standard input}:1737: Error: Local symbol `urem' can't be equated to undefined symbol `.urem'
{standard input}:1737: Error: Local symbol `rem' can't be equated to undefined symbol `.rem'

Problem seems to be the symbol aliasing
in arch/sparc/kernel/sparc_ksyms.c around lines 100-110

I've tried some simple things to fix it, but it's just
too much magic for me.

binutils is version 2.16.91.0.3, most likely the problem.

Any ideas on a fix other than using older binutils ?

-- 
Kaj-Michael Lang
