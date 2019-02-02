From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sat, 02 Feb 2019 15:34:54 +0000
Subject: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Message-Id: <20190202153454.7121-13-deepa.kernel@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

Add new socket timeout options that are y2038 safe.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Cc: ccaulfie@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: cluster-devel@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  | 12 ++++--
 arch/mips/include/uapi/asm/socket.h   | 11 +++++-
 arch/parisc/include/uapi/asm/socket.h | 10 ++++-
 arch/sparc/include/uapi/asm/socket.h  | 11 +++++-
 include/uapi/asm-generic/socket.h     | 11 +++++-
 net/core/sock.c                       | 53 ++++++++++++++++++++-------
 6 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 9826d1db71d0..0d0fddb7e738 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -119,19 +119,25 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
-#if !defined(__KERNEL__)
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+#if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 96cc0e907f12..eb9f33f8a8b3 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -130,18 +130,25 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO             SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO             SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 046f0cd9cce4..16e428f03526 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -111,18 +111,24 @@
 #define SO_TIMESTAMPNS_NEW      0x4039
 #define SO_TIMESTAMPING_NEW     0x403A
 
+#define SO_RCVTIMEO_NEW         0x4040
+#define SO_SNDTIMEO_NEW         0x4041
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 342ffdc3b424..8c9f74a66b55 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -112,19 +112,26 @@
 #define SO_TIMESTAMPNS_NEW       0x0042
 #define SO_TIMESTAMPING_NEW      0x0043
 
+#define SO_RCVTIMEO_NEW          0x0044
+#define SO_SNDTIMEO_NEW          0x0045
+
 #if !defined(__KERNEL__)
 
-#define SO_RCVTIMEO              SO_RCVTIMEO_OLD
-#define SO_SNDTIMEO              SO_SNDTIMEO_OLD
 
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index c56b8b487c12..c8b430cb6dc4 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -114,19 +114,26 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index 27b40002b780..a8904ae40713 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,9 +335,10 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
-static int sock_get_timeout(long timeo, void *optval)
+static int sock_get_timeout(long timeo, void *optval, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval tv;
+	int size;
 
 	if (timeo = MAX_SCHEDULE_TIMEOUT) {
 		tv.tv_sec = 0;
@@ -353,13 +354,23 @@ static int sock_get_timeout(long timeo, void *optval)
 		return sizeof(tv32);
 	}
 
-	*(struct __kernel_old_timeval *)optval = tv;
-	return sizeof(tv);
+	if (old_timeval) {
+		struct __kernel_old_timeval old_tv;
+		old_tv.tv_sec = tv.tv_sec;
+		old_tv.tv_usec = tv.tv_usec;
+		*(struct __kernel_old_timeval *)optval = old_tv;
+		size = sizeof(old_tv);
+	} else {
+		*(struct __kernel_sock_timeval *)optval = tv;
+		size = sizeof(tv);
+	}
+
+	return size;
 }
 
-static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
+static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval tv;
 
 	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
 		struct old_timeval32 tv32;
@@ -371,6 +382,15 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 			return -EFAULT;
 		tv.tv_sec = tv32.tv_sec;
 		tv.tv_usec = tv32.tv_usec;
+	} else if (old_timeval) {
+		struct __kernel_old_timeval old_tv;
+
+		if (optlen < sizeof(old_tv))
+			return -EINVAL;
+		if (copy_from_user(&old_tv, optval, sizeof(old_tv)))
+			return -EFAULT;
+		tv.tv_sec = old_tv.tv_sec;
+		tv.tv_usec = old_tv.tv_usec;
 	} else {
 		if (optlen < sizeof(tv))
 			return -EINVAL;
@@ -394,8 +414,8 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 	*timeo_p = MAX_SCHEDULE_TIMEOUT;
 	if (tv.tv_sec = 0 && tv.tv_usec = 0)
 		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT/HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP(tv.tv_usec, USEC_PER_SEC / HZ);
+	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
+		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec, USEC_PER_SEC / HZ);
 	return 0;
 }
 
@@ -942,11 +962,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen);
+	case SO_RCVTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen, optname = SO_RCVTIMEO_OLD);
 		break;
 
 	case SO_SNDTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen);
+	case SO_SNDTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen, optname = SO_SNDTIMEO_OLD);
 		break;
 
 	case SO_ATTACH_FILTER:
@@ -1171,6 +1193,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		struct linger ling;
 		struct old_timeval32 tm32;
 		struct __kernel_old_timeval tm;
+		struct  __kernel_sock_timeval stm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1279,12 +1302,14 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sk->sk_tsflags;
 		break;
 
-	case SO_RCVTIMEO:
-		lv = sock_get_timeout(sk->sk_rcvtimeo, &v);
+	case SO_RCVTIMEO_OLD:
+	case SO_RCVTIMEO_NEW:
+		lv = sock_get_timeout(sk->sk_rcvtimeo, &v, SO_RCVTIMEO_OLD = optname);
 		break;
 
-	case SO_SNDTIMEO:
-		lv = sock_get_timeout(sk->sk_sndtimeo, &v);
+	case SO_SNDTIMEO_OLD:
+	case SO_SNDTIMEO_NEW:
+		lv = sock_get_timeout(sk->sk_sndtimeo, &v, SO_SNDTIMEO_OLD = optname);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.17.1
