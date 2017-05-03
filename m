From: David Miller <davem@davemloft.net>
Date: Wed, 03 May 2017 15:29:46 +0000
Subject: Re: linux-4.11-rc6/arch/sparc/kernel/setup_32.c:151]: (style) Redundant condition
Message-Id: <20170503.112946.1803743581979942128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Binderman <dcb314@hotmail.com>
Date: Mon, 10 Apr 2017 08:20:09 +0000

> Hello there,
> 
> 
> linux-4.11-rc6/arch/sparc/kernel/setup_32.c:151]: (style) Redundant condition: If 'EXPR = ' '', the comparison 'EXPR' is always true.
> 
> 
> Source code is
> 
> 
>         while (*commands && *commands = ' ')
> 
> 
> Suggest new code
> 
> 
>         while (*commands = ' ')
> 
> Also, there seems to be a duplicate in a similar file:
> 
> linux-4.11-rc6/arch/sparc/kernel/setup_64.c:136]: (style) Redundant condition: If 'EXPR = ' '', the comparison 'EXPR' is always true.

Yep, both are correct transformations, thanks.

==========
sparc: Remove redundant tests in boot_flags_init().

The test:

	*commands && *commands = ' '

is equivalent to:

	*commands = ' '

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/setup_32.c | 2 +-
 arch/sparc/kernel/setup_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 6f06058..6722308 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -148,7 +148,7 @@ static void __init boot_flags_init(char *commands)
 {
 	while (*commands) {
 		/* Move to the start of the next "argument". */
-		while (*commands && *commands = ' ')
+		while (*commands = ' ')
 			commands++;
 
 		/* Process any command switches, otherwise skip it. */
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6b7331d..422b178 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -133,7 +133,7 @@ static void __init boot_flags_init(char *commands)
 {
 	while (*commands) {
 		/* Move to the start of the next "argument". */
-		while (*commands && *commands = ' ')
+		while (*commands = ' ')
 			commands++;
 
 		/* Process any command switches, otherwise skip it. */
-- 
2.1.2.532.g19b5d50

