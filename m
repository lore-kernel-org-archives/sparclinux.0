From: Jim Gifford <maillist@jg555.com>
Date: Thu, 12 Jan 2006 19:06:11 +0000
Subject: Build Issue - Sparc64
Message-Id: <43C6A8A3.9090100@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Anyone got any ideas. This is from the 2.6.15 build. We are doing some 
testing building a 64 bit kernel with no 32 bit support  for testing 
purposes and we ran into this error. GCC 4, Binutils 2.16.1, Glibc 2.3.6.

cc1: warnings being treated as errors
arch/sparc64/kernel/process.c: In function 'show_regwindow32':
arch/sparc64/kernel/process.c:174: warning: implicit declaration of 
function 'compat_ptr'
arch/sparc64/kernel/process.c:174: warning: assignment makes pointer 
from integer without a cast
make[1]: *** [arch/sparc64/kernel/process.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

-- 
----
Jim Gifford
maillist@jg555.com

