From: Nate Karstens <nate.karstens@garmin.com>
Date: Mon, 20 Apr 2020 07:15:47 +0000
Subject: [PATCH 3/4] fs: Add F_DUPFD_CLOFORK to fcntl(2)
Message-Id: <20200420071548.62112-4-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
In-Reply-To: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>, Nate Karstens <nate.karstens@garmin.com>

Implement functionality for duplicating a file descriptor
and having the close-on-fork flag automatically set in the
new file descriptor.

Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
---
 fs/fcntl.c                       | 4 ++++
 include/uapi/linux/fcntl.h       | 3 +++
 tools/include/uapi/linux/fcntl.h | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index b59b27c3a338..43ca3e3dacc5 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -333,6 +333,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_DUPFD_CLOEXEC:
 		err = f_dupfd(arg, filp, O_CLOEXEC);
 		break;
+	case F_DUPFD_CLOFORK:
+		err = f_dupfd(arg, filp, O_CLOFORK);
+		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
 		err |= get_close_on_fork(fd) ? FD_CLOFORK : 0;
@@ -439,6 +442,7 @@ static int check_fcntl_cmd(unsigned cmd)
 	switch (cmd) {
 	case F_DUPFD:
 	case F_DUPFD_CLOEXEC:
+	case F_DUPFD_CLOFORK:
 	case F_GETFD:
 	case F_SETFD:
 	case F_GETFL:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ca88b7bce553..9e1069ff3a22 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -55,6 +55,9 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/* Create a file descriptor with FD_CLOFORK set. */
+#define F_DUPFD_CLOFORK	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index ca88b7bce553..9e1069ff3a22 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -55,6 +55,9 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/* Create a file descriptor with FD_CLOFORK set. */
+#define F_DUPFD_CLOFORK	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.26.1
