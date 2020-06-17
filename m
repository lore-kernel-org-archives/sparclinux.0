From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 17 Jun 2020 12:14:06 +0000
Subject: [PATCH] selftests: kvm: don't try to build kvm tests on sparc64 architecture
Message-Id: <20200617121406.GA29692@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kselftest@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>, sparclinux@vger.kernel.org

There's no support for KVM on sparc64, so don't try to build kvm tests.

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99
-fno-stack-protector -fno-PIE -I../../../../tools/include
-I../../../../tools/arch/sparc64/include -I../../../../usr/include/
-Iinclude -Ilib -Iinclude/sparc64 -I..   -c lib/elf.c -o
/1/mator/linux-2.6/tools/testing/selftests/kvm/lib/elf.o
In file included from lib/elf.c:13:
include/kvm_util.h:12:10: fatal error: asm/kvm.h: No such file or
directory
   12 | #include "asm/kvm.h"
      |          ^~~~~~~~~~~
compilation terminated.

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
CC: Jiri Kosina <trivial@kernel.org>
CC: sparclinux@vger.kernel.org
---
 tools/testing/selftests/kvm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4a166588d99f..00be52199cb9 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,6 +32,9 @@ endif
 ifeq ($(ARCH),s390)
 	UNAME_M := s390x
 endif
+ifeq ($(UNAME_M),sparc64)
+$(error kvm selftests is not supported on sparc64)
+endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c
-- 
2.27.0
