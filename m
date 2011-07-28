From: Ghitulete Razvan <razvan.ghitulete@gmail.com>
Date: Thu, 28 Jul 2011 08:12:06 +0000
Subject: Silo Bootloader
Message-Id: <CAMHygW+HcnXzvsxsC6M_9COsOWOdn490OtbBobdrWAGTb3JNrQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,
         I am working on a Sparc port of the minix kernel, and I
thought it would be easier for starters to use SILO as a bootloader.
But I'm having some trouble as I can't figure out how to link the
kernel "draft" so that I can load it from SILO, as i keep getting Fast
Data Access MMU Miss. So my question is, does anyone know whether I
have to manually relocate the assembly code to a certain physical
address, ar any tips whatsoever on how to link/compile the assembly
files so that SILO won't load them in an unmapped memory zone anymore

-- 
Razvan Ghitulete
Universitatea Politehnica Bucuresti
