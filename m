From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Feb 2005 19:57:45 +0000
Subject: Re: Hang in SIOCGIFCONF ioctl handler
Message-Id: <20050207115745.61fe43c1.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502071259370.2050@bobcat>
In-Reply-To: <Pine.LNX.4.61.0502071259370.2050@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 7 Feb 2005 13:21:16 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> On an unrelated note, during my exploration I came across the function 
> copy_in_user_fixup in arch/sparc64/lib/user_fixup.c. In this function (and 
> in other functions in that file) copying is done using a loop like this:
> 
>    while(size--) {
>      ...
>    }
>    return size;
> 
> I am pretty sure that this function is supposed to follow the same error 
> reporting convention as copy_in_user, i.e. return 0 on success, non-zero 
> on error. As they are written now, the loop will stop at size = 0, but it 
> will return -1 due to extra decrement, which is not what one would expect.

Right, it's buggy.  Good spotting.  This should fix it up:

=== arch/sparc64/lib/user_fixup.c 1.1 vs edited ==--- 1.1/arch/sparc64/lib/user_fixup.c	2004-08-23 14:32:55 -07:00
+++ edited/arch/sparc64/lib/user_fixup.c	2005-02-07 11:32:54 -08:00
@@ -20,11 +20,12 @@
 	char *dst = to;
 	const char __user *src = from;
 
-	while (size--) {
+	while (size) {
 		if (__get_user(*dst, src))
 			break;
 		dst++;
 		src++;
+		size--;
 	}
 
 	if (size)
@@ -38,11 +39,12 @@
 	char __user *dst = to;
 	const char *src = from;
 
-	while (size--) {
+	while (size) {
 		if (__put_user(*src, dst))
 			break;
 		dst++;
 		src++;
+		size--;
 	}
 
 	return size;
@@ -53,7 +55,7 @@
 	char __user *dst = to;
 	char __user *src = from;
 
-	while (size--) {
+	while (size) {
 		char tmp;
 
 		if (__get_user(tmp, src))
@@ -62,6 +64,7 @@
 			break;
 		dst++;
 		src++;
+		size--;
 	}
 
 	return size;
