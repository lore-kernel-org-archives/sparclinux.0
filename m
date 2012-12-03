From: David Miller <davem@davemloft.net>
Date: Mon, 03 Dec 2012 19:36:25 +0000
Subject: Re: SPARC kernel build (piggyback) fails with binutils 2.23.1
Message-Id: <20121203.143625.1586841025228957280.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 3 Dec 2012 15:10:23 +0200

> Yes, I tried the hack below, and it produces a bootable TFTP image.
> 
> diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
> index c0a798f..9eb1264 100644
> --- a/arch/sparc/boot/piggyback.c
> +++ b/arch/sparc/boot/piggyback.c
> @@ -90,9 +90,9 @@ static int start_line(const char *line)
>  
>  static int end_line(const char *line)
>  {
> -	if (strcmp(line + 8, " A _end\n") = 0)
> +	if (strcmp(line + 10, " _end\n") = 0)
>  		return 1;
> -	else if (strcmp (line + 16, " A _end\n") = 0)
> +	else if (strcmp (line + 18, " _end\n") = 0)
>  		return 1;
>  	return 0;
>  }

Thanks for the report and the testing.

In order to future proof both _start and _end, I've committed the
fix as follows:

--------------------
[PATCH] sparc: Fix piggyback with newer binutils.

Newer versions of binutils mark '_end' as 'B' instead of 'A' for
whatever reason.

To be honest, the piggyback code doesn't actually care what kind
of symbol _start and _end are, it just wants to find them and
record the address.

So remove the type from the match strings.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/boot/piggyback.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index c0a798f..bb7c951 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -81,18 +81,18 @@ static void usage(void)
 
 static int start_line(const char *line)
 {
-	if (strcmp(line + 8, " T _start\n") = 0)
+	if (strcmp(line + 10, " _start\n") = 0)
 		return 1;
-	else if (strcmp(line + 16, " T _start\n") = 0)
+	else if (strcmp(line + 18, " _start\n") = 0)
 		return 1;
 	return 0;
 }
 
 static int end_line(const char *line)
 {
-	if (strcmp(line + 8, " A _end\n") = 0)
+	if (strcmp(line + 10, " _end\n") = 0)
 		return 1;
-	else if (strcmp (line + 16, " A _end\n") = 0)
+	else if (strcmp (line + 18, " _end\n") = 0)
 		return 1;
 	return 0;
 }
@@ -100,8 +100,8 @@ static int end_line(const char *line)
 /*
  * Find address for start and end in System.map.
  * The file looks like this:
- * f0004000 T _start
- * f0379f79 A _end
+ * f0004000 ... _start
+ * f0379f79 ... _end
  * 1234567890123456
  * ^coloumn 1
  * There is support for 64 bit addresses too.
-- 
1.7.12.2.dirty

