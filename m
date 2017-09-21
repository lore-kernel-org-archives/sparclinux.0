From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 21 Sep 2017 22:18:42 +0000
Subject: [PATCH 0/2] Driver for Oracle Data Analytics Accelerator
Message-Id: <1506032324-14146-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Recent Oracle Sparc processors (M7 and M8) have a coprocessor which
lives on the cpu chip. The coprocessor is called DAX (Data Analytics
Accelerator), and is controlled via sun4v hypercalls. The programmatic
interface to the coprocessor is somewhat unorthodox, and is documented
in detail in an included file. The driver API is described in the
accompanying Documentation file. Also included is an example program
that shows how the raw driver API is used, though it is expected that
general use of the coprocessor will go through the companion userspace
library, which has been published under UPL at:
	  https://oss.oracle.com/git/gitweb.cgi?p=libdax.git
This library is a comprehensive collection of higher level functions
along with tests and documentation. The format of the command control
blocks is described in this library as well. Though the primary
purpose of the coprocessor is to accelerate data analytics operations,
it may be used for any suitable purpose.

The coprocessor may also be used by internal kernel code for any
purpose for which one sees fit. Example code to do this is also
included. Those who wish to use the coprocessor will need to construct
their own command blocks to submit, as no higher level services are
provided. The library contains numerous code examples to assist in
this, and the included Hypervisor API document provides a complete
specification of all the commands and parameters that may be used.

The machine descriptor identifies the device as "dax", and all
internal documentation refers to it as "dax". But since the term "dax"
already has other meanings and uses in Linux, we call this driver
"oradax".

Right now we've got the main driver source file in drivers/sbus/char,
which seems to be where Sparc specific drivers go, but seeing as
"sbus" is a very old Sparc feature and not used anymore, it might
perhaps be better placed elsewhere.

Any and all feedback welcome and appreciated.

Thanks,
Rob Gardner
Sanath Kumar
Jonathan Helman
