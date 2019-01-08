From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 08 Jan 2019 20:09:36 +0000
Subject: [PATCH] socket: move compat timeout handling into sock.c
Message-Id: <20190108200959.1686520-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
In-Reply-To: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Parisc List <linux-parisc@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Networking <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, cluster-devel@redhat.com, Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>

This is a cleanup to prepare for the addition of 64-bit time_t
in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
unnecessarily complex and error-prone, moving it all into the
main setsockopt()/getsockopt() implementation requires half
as much code and is easier to extend.

32-bit user space can now use old_timeval32 on both 32-bit
and 64-bit machines, while 64-bit code can use
__old_kernel_timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/compat.c    | 66 +------------------------------------------------
 net/core/sock.c | 65 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 87 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 959d1c51826d..ce8f6e8cdcd2 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -348,28 +348,6 @@ static int do_set_attach_filter(struct socket *sock, int level, int optname,
 			      sizeof(struct sock_fprog));
 }
 
-static int do_set_sock_timeout(struct socket *sock, int level,
-		int optname, char __user *optval, unsigned int optlen)
-{
-	struct compat_timeval __user *up = (struct compat_timeval __user *)optval;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int err;
-
-	if (optlen < sizeof(*up))
-		return -EINVAL;
-	if (!access_ok(up, sizeof(*up)) ||
-	    __get_user(ktime.tv_sec, &up->tv_sec) ||
-	    __get_user(ktime.tv_usec, &up->tv_usec))
-		return -EFAULT;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_setsockopt(sock, level, optname, (char *)&ktime, sizeof(ktime));
-	set_fs(old_fs);
-
-	return err;
-}
-
 static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, unsigned int optlen)
 {
@@ -377,10 +355,6 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 	    optname = SO_ATTACH_REUSEPORT_CBPF)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname = SO_RCVTIMEO || optname = SO_SNDTIMEO))
-		return do_set_sock_timeout(sock, level, optname, optval, optlen);
-
 	return sock_setsockopt(sock, level, optname, optval, optlen);
 }
 
@@ -417,44 +391,6 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return __compat_sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-static int do_get_sock_timeout(struct socket *sock, int level, int optname,
-		char __user *optval, int __user *optlen)
-{
-	struct compat_timeval __user *up;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int len, err;
-
-	up = (struct compat_timeval __user *) optval;
-	if (get_user(len, optlen))
-		return -EFAULT;
-	if (len < sizeof(*up))
-		return -EINVAL;
-	len = sizeof(ktime);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_getsockopt(sock, level, optname, (char *) &ktime, &len);
-	set_fs(old_fs);
-
-	if (!err) {
-		if (put_user(sizeof(*up), optlen) ||
-		    !access_ok(up, sizeof(*up)) ||
-		    __put_user(ktime.tv_sec, &up->tv_sec) ||
-		    __put_user(ktime.tv_usec, &up->tv_usec))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, int __user *optlen)
-{
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname = SO_RCVTIMEO || optname = SO_SNDTIMEO))
-		return do_get_sock_timeout(sock, level, optname, optval, optlen);
-	return sock_getsockopt(sock, level, optname, optval, optlen);
-}
-
 int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct compat_timeval __user *ctv;
@@ -527,7 +463,7 @@ static int __compat_sys_getsockopt(int fd, int level, int optname,
 		}
 
 		if (level = SOL_SOCKET)
-			err = compat_sock_getsockopt(sock, level,
+			err = sock_getsockopt(sock, level,
 					optname, optval, optlen);
 		else if (sock->ops->compat_getsockopt)
 			err = sock->ops->compat_getsockopt(sock, level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 6aa2e7e0b4fb..e50b9a2abc92 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,14 +335,48 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
+static int sock_get_timeout(long timeo, void *optval)
+{
+	struct __kernel_old_timeval tv;
+
+	if (timeo = MAX_SCHEDULE_TIMEOUT) {
+		tv.tv_sec = 0;
+		tv.tv_usec = 0;
+	} else {
+		tv.tv_sec = timeo / HZ;
+		tv.tv_usec = ((timeo % HZ) * USEC_PER_SEC) / HZ;
+	}
+
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32 = { tv.tv_sec, tv.tv_usec };
+		*(struct old_timeval32 *)optval = tv32;
+		return sizeof(tv32);
+	}
+
+	*(struct __kernel_old_timeval *)optval = tv;
+	return sizeof(tv);
+}
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 
-	if (optlen < sizeof(tv))
-		return -EINVAL;
-	if (copy_from_user(&tv, optval, sizeof(tv)))
-		return -EFAULT;
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32;
+
+		if (optlen < sizeof(tv32))
+			return -EINVAL;
+
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+		tv.tv_sec = tv32.tv_sec;
+		tv.tv_usec = tv32.tv_usec;
+	} else {
+		if (optlen < sizeof(tv))
+			return -EINVAL;
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+	}
 	if (tv.tv_usec < 0 || tv.tv_usec >= USEC_PER_SEC)
 		return -EDOM;
 
@@ -1099,7 +1133,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		int val;
 		u64 val64;
 		struct linger ling;
-		struct timeval tm;
+		struct old_timeval32 tm32;
+		struct __kernel_old_timeval tm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1200,25 +1235,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_rcvtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_rcvtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_rcvtimeo, optval);
 		break;
 
 	case SO_SNDTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_sndtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_sndtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_sndtimeo, optval);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.20.0
