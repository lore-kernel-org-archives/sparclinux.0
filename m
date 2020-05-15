From: Nate Karstens <nate.karstens@garmin.com>
Date: Fri, 15 May 2020 15:23:21 +0000
Subject: [PATCH v2 4/4] net: Add SOCK_CLOFORK
Message-Id: <20200515152321.9280-5-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
In-Reply-To: <20200515152321.9280-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>, Nate Karstens <nate.karstens@garmin.com>

Implements a new socket flag that automatically sets the
close-on-fork flag for sockets created using socket(2),
socketpair(2), and accept4(2).

Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
---
 include/linux/net.h |  3 ++-
 net/socket.c        | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 6451425e828f..57663c9dc8c4 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -17,7 +17,7 @@
 #include <linux/stringify.h>
 #include <linux/random.h>
 #include <linux/wait.h>
-#include <linux/fcntl.h>	/* For O_CLOEXEC and O_NONBLOCK */
+#include <linux/fcntl.h>	/* For O_CLOEXEC, O_CLOFORK, and O_NONBLOCK */
 #include <linux/rcupdate.h>
 #include <linux/once.h>
 #include <linux/fs.h>
@@ -73,6 +73,7 @@ enum sock_type {
 
 /* Flags for socket, socketpair, accept4 */
 #define SOCK_CLOEXEC	O_CLOEXEC
+#define SOCK_CLOFORK	O_CLOFORK
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
diff --git a/net/socket.c b/net/socket.c
index 2eecf1517f76..ba6e971c7e78 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1511,12 +1511,14 @@ int __sys_socket(int family, int type, int protocol)
 
 	/* Check the SOCK_* constants for consistency.  */
 	BUILD_BUG_ON(SOCK_CLOEXEC != O_CLOEXEC);
+	BUILD_BUG_ON(SOCK_CLOFORK != O_CLOFORK);
 	BUILD_BUG_ON((SOCK_MAX | SOCK_TYPE_MASK) != SOCK_TYPE_MASK);
 	BUILD_BUG_ON(SOCK_CLOEXEC & SOCK_TYPE_MASK);
+	BUILD_BUG_ON(SOCK_CLOFORK & SOCK_TYPE_MASK);
 	BUILD_BUG_ON(SOCK_NONBLOCK & SOCK_TYPE_MASK);
 
 	flags = type & ~SOCK_TYPE_MASK;
-	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
+	if (flags & ~(SOCK_CLOEXEC | SOCK_CLOFORK | SOCK_NONBLOCK))
 		return -EINVAL;
 	type &= SOCK_TYPE_MASK;
 
@@ -1527,7 +1529,7 @@ int __sys_socket(int family, int type, int protocol)
 	if (retval < 0)
 		return retval;
 
-	return sock_map_fd(sock, flags & (O_CLOEXEC | O_NONBLOCK));
+	return sock_map_fd(sock, flags & (O_CLOEXEC | O_CLOFORK | O_NONBLOCK));
 }
 
 SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
@@ -1547,7 +1549,7 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 	int flags;
 
 	flags = type & ~SOCK_TYPE_MASK;
-	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
+	if (flags & ~(SOCK_CLOEXEC | SOCK_CLOFORK | SOCK_NONBLOCK))
 		return -EINVAL;
 	type &= SOCK_TYPE_MASK;
 
@@ -1715,7 +1717,7 @@ int __sys_accept4_file(struct file *file, unsigned file_flags,
 	int err, len, newfd;
 	struct sockaddr_storage address;
 
-	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
+	if (flags & ~(SOCK_CLOEXEC | SOCK_CLOFORK | SOCK_NONBLOCK))
 		return -EINVAL;
 
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
@@ -3628,8 +3630,8 @@ EXPORT_SYMBOL(kernel_listen);
  *	@newsock: new connected socket
  *	@flags: flags
  *
- *	@flags must be SOCK_CLOEXEC, SOCK_NONBLOCK or 0.
- *	If it fails, @newsock is guaranteed to be %NULL.
+ *	@flags must be SOCK_CLOEXEC, SOCK_CLOFORK, SOCK_NONBLOCK,
+ *	or 0. If it fails, @newsock is guaranteed to be %NULL.
  *	Returns 0 or an error.
  */
 
-- 
2.26.1
