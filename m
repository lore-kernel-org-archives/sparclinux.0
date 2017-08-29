From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 29 Aug 2017 23:36:01 +0000
Subject: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Recent Oracle Sparc processors (M7 and M8) have a coprocessor which
lives on the cpu chip. The coprocessor is called DAX, and is
controlled via sun4v hypercalls. The programmatic interface to the
coprocessor is somewhat unorthodox, and is described in detail in the
documentation file. The machine descriptor identifies the device as
"dax", and all internal documentation refers to it as "dax". But since
the term "dax" already has other meanings and uses, we propose to call
this driver "oradax"; other suggestions are welcome.

To answer the most obvious question "who will use this?", there is a
companion userspace library which will be published under UPL
shortly. This is a comprehensive collection of higher level functions
along with tests and documentation. We'll include a link to this before
the code is submitted as a patch.

Apart from general comments about the code, style, formatting, logic,
etc., we seek suggestions about where the source files ought to
live. Right now we've got the main driver source file in
drivers/sbus/char, but seeing as "sbus" is a very old Sparc feature
and not used anymore, this doesn't seem to be a great place for it.

Any and all feedback welcome and appreciated.

Thanks,
Rob Gardner
Sanath Kumar
Jonathan Helman

