From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 08 Jan 2019 05:22:55 +0000
Subject: [PATCH 3/3] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Message-Id: <20190108052255.10699-4-deepa.kernel@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
In-Reply-To: <20190108052255.10699-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

Add new socket timeout options that are y2038 safe.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
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
 arch/alpha/include/uapi/asm/socket.h  | 12 +++--
 arch/mips/include/uapi/asm/socket.h   | 11 ++++-
 arch/parisc/include/uapi/asm/socket.h | 11 ++++-
 arch/sparc/include/uapi/asm/socket.h  | 11 ++++-
 include/net/sock.h                    |  4 +-
 include/uapi/asm-generic/socket.h     | 11 ++++-
 net/core/sock.c                       | 64 +++++++++++++++++++++------
 7 files changed, 98 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index ea3ba981d8a0..3d800d5d3d5d 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -118,19 +118,25 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
-#if !defined(__KERNEL__)
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+#if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 4dde20d64690..5a7f9010c090 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -128,18 +128,25 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define        SO_RCVTIMEO             SO_RCVTIMEO_OLD
+#define        SO_SNDTIMEO             SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 546937fa0d8b..bd35de5b4666 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -109,18 +109,25 @@
 #define SO_TIMESTAMPNS_NEW       0x4038
 #define SO_TIMESTAMPING_NEW      0x4039
 
+#define SO_RCVTIMEO_NEW          0x4040
+#define SO_SNDTIMEO_NEW          0x4041
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index bdc396211627..5a5b073c3299 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -110,18 +110,25 @@
 #define SO_TIMESTAMPNS_NEW       0x0042
 #define SO_TIMESTAMPING_NEW      0x0043
 
+#define SO_RCVTIMEO_NEW          0x0044
+#define SO_SNDTIMEO_NEW          0x0045
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO	SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO	SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 98965a9a2bf4..6679f3c120b0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -292,8 +292,8 @@ struct sock_common {
   *	@sk_peer_pid: &struct pid for this socket's peer
   *	@sk_peer_cred: %SO_PEERCRED setting
   *	@sk_rcvlowat: %SO_RCVLOWAT setting
-  *	@sk_rcvtimeo: %SO_RCVTIMEO_OLD setting
-  *	@sk_sndtimeo: %SO_SNDTIMEO_OLD setting
+  *	@sk_rcvtimeo: %SO_RCVTIMEO setting
+  *	@sk_sndtimeo: %SO_SNDTIMEO setting
   *	@sk_txhash: computed flow hash for use on transmit
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 9e370586fb19..5b4da6eacc9f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -112,19 +112,26 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG = 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index 42914ca3186c..5e1c6dafee65 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,18 +335,31 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
-static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
+static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
 
-	if (optlen < sizeof(tv))
-		return -EINVAL;
-	if (copy_from_user(&tv, optval, sizeof(tv)))
-		return -EFAULT;
-	if (tv.tv_usec < 0 || tv.tv_usec >= USEC_PER_SEC)
+	struct __kernel_sock_timeval stv;
+
+	if (old_timeval) {
+		struct __kernel_old_timeval tv;
+
+		if (optlen < sizeof(tv))
+			return -EINVAL;
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+		stv.tv_sec = tv.tv_sec;
+		stv.tv_usec = tv.tv_usec;
+	} else {
+		if (optlen < sizeof(stv))
+			return -EINVAL;
+		if (copy_from_user(&stv, optval, sizeof(stv)))
+			return -EFAULT;
+	}
+
+	if (stv.tv_usec < 0 || stv.tv_usec >= USEC_PER_SEC)
 		return -EDOM;
 
-	if (tv.tv_sec < 0) {
+	if (stv.tv_sec < 0) {
 		static int warned __read_mostly;
 
 		*timeo_p = 0;
@@ -358,10 +371,10 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 		return 0;
 	}
 	*timeo_p = MAX_SCHEDULE_TIMEOUT;
-	if (tv.tv_sec = 0 && tv.tv_usec = 0)
+	if (stv.tv_sec = 0 && stv.tv_usec = 0)
 		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT/HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP(tv.tv_usec, USEC_PER_SEC / HZ);
+	if (stv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
+		*timeo_p = stv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)stv.tv_usec, USEC_PER_SEC / HZ);
 	return 0;
 }
 
@@ -890,11 +903,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
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
@@ -1114,6 +1129,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		u64 val64;
 		struct linger ling;
 		struct __kernel_old_timeval tm;
+		struct  __kernel_sock_timeval stm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1233,6 +1249,17 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case SO_RCVTIMEO_NEW:
+		lv = sizeof(struct __kernel_sock_timeval);
+		if (sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT) {
+			v.stm.tv_sec = 0;
+			v.stm.tv_usec = 0;
+		} else {
+			v.stm.tv_sec = sk->sk_rcvtimeo / HZ;
+			v.stm.tv_usec = ((sk->sk_rcvtimeo % HZ) * USEC_PER_SEC) / HZ;
+		}
+		break;
+
 	case SO_SNDTIMEO_OLD:
 		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT) {
@@ -1244,6 +1271,17 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case SO_SNDTIMEO_NEW:
+		lv = sizeof(struct __kernel_sock_timeval);
+		if (sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT) {
+			v.stm.tv_sec = 0;
+			v.stm.tv_usec = 0;
+		} else {
+			v.stm.tv_sec = sk->sk_sndtimeo / HZ;
+			v.stm.tv_usec = ((sk->sk_sndtimeo % HZ) * USEC_PER_SEC) / HZ;
+		}
+		break;
+
 	case SO_RCVLOWAT:
 		v.val = sk->sk_rcvlowat;
 		break;
-- 
2.17.1
