From: David Miller <davem@davemloft.net>
Date: Wed, 14 Mar 2012 04:46:09 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120313.214609.1139946570476396180.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
	<20120313.173741.18086192847996966.davem@davemloft.net>
	<20120314040102.GA26084@thor.bakeyournoodle.com>
In-Reply-To: <20120314040102.GA26084@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tony@bakeyournoodle.com
Cc: sfr@canb.auug.org.au, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org

From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 14 Mar 2012 15:01:02 +1100

> On Tue, Mar 13, 2012 at 05:37:41PM -0700, David Miller wrote:
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Wed, 14 Mar 2012 10:28:30 +1100
>> 
>> > Yeah, we updated our sparc64 toolchain yesterday ... Tony says he
>> > will try applying the patch(es) from the bugzilla.
>> 
>> Meanwhile I'll add a workaround to the sparc makefiles, and
>> push that to Linus.  This way it will work no matter what
>> combination of tools someone has.
> 
> Thanks Dave, we may be hitting a related but different issue as gcc
> 4.6.3 seems to have that patch already.

See the patch I sent to Linus which landed in his tree an hour or so
ago:

--------------------
[PATCH] sparc32: Add -Av8 to assembler command line.

Newer version of binutils are more strict about specifying the
correct options to enable certain classes of instructions.

The sparc32 build is done for v7 in order to support sun4c systems
which lack hardware integer multiply and divide instructions.

So we have to pass -Av8 when building the assembler routines that
use these instructions and get patched into the kernel when we find
out that we have a v8 capable cpu.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index ad1fb5d..eddcfb3 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -31,7 +31,7 @@ UTS_MACHINE    := sparc
 
 #KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
 KBUILD_CFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-KBUILD_AFLAGS += -m32
+KBUILD_AFLAGS += -m32 -Wa,-Av8
 
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
 #  Since 2.5.40, the first stage is left not btfix-ed.
-- 
1.7.6.5

