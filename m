From: Lorenz Bauer <lmb@cloudflare.com>
Date: Wed, 10 Feb 2021 12:04:22 +0000
Subject: [PATCH bpf 1/4] net: add SO_NETNS_COOKIE socket option
Message-Id: <20210210120425.53438-2-lmb@cloudflare.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210210120425.53438-1-lmb@cloudflare.com>
In-Reply-To: <20210210120425.53438-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>, linux-api@vger.kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

We need to distinguish which network namespace a socket belongs to.
BPF has the useful bpf_get_netns_cookie helper for this, but accessing
it from user space isn't possible. Add a read-only socket option that
returns the netns cookie, similar to SO_COOKIE. If network namespaces
are disabled, SO_NETNS_COOKIE returns the cookie of init_net.

The BPF helpers change slightly: instead of returning 0 when network
namespaces are disabled we return the init_net cookie as for the
socket option.

Cc: linux-api@vger.kernel.org
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/linux/sock_diag.h             | 20 ++++++++++++++++++++
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/filter.c                     |  9 ++++-----
 net/core/sock.c                       |  7 +++++++
 8 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 57420356ce4c..6b3daba60987 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -127,6 +127,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 2d949969313b..cdf404a831b2 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -138,6 +138,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f60904329bbc..5b5351cdcb33 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -119,6 +119,8 @@
 #define SO_PREFER_BUSY_POLL	0x4043
 #define SO_BUSY_POLL_BUDGET	0x4044
 
+#define SO_NETNS_COOKIE		0x4045
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 848a22fbac20..ff79db753dce 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -120,6 +120,8 @@
 #define SO_PREFER_BUSY_POLL	 0x0048
 #define SO_BUSY_POLL_BUDGET	 0x0049
 
+#define SO_NETNS_COOKIE		 0x004a
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/sock_diag.h b/include/linux/sock_diag.h
index 0b9ecd8cf979..6e88436097b1 100644
--- a/include/linux/sock_diag.h
+++ b/include/linux/sock_diag.h
@@ -38,6 +38,26 @@ static inline u64 sock_gen_cookie(struct sock *sk)
 	return cookie;
 }
 
+static inline u64 __sock_gen_netns_cookie(struct sock *sk)
+{
+#ifdef CONFIG_NET_NS
+	return __net_gen_cookie(sk->sk_net.net);
+#else
+	return __net_gen_cookie(&init_net);
+#endif
+}
+
+static inline u64 sock_gen_netns_cookie(struct sock *sk)
+{
+	u64 cookie;
+
+	preempt_disable();
+	cookie = __sock_gen_netns_cookie(sk);
+	preempt_enable();
+
+	return cookie;
+}
+
 int sock_diag_check_cookie(struct sock *sk, const __u32 *cookie);
 void sock_diag_save_cookie(struct sock *sk, __u32 *cookie);
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 4dcd13d097a9..d588c244ec2f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -122,6 +122,8 @@
 #define SO_PREFER_BUSY_POLL	69
 #define SO_BUSY_POLL_BUDGET	70
 
+#define SO_NETNS_COOKIE		71
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG = 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/filter.c b/net/core/filter.c
index e15d4741719a..51f47b6913f1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4645,11 +4645,10 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_ops_proto = {
 
 static u64 __bpf_get_netns_cookie(struct sock *sk)
 {
-#ifdef CONFIG_NET_NS
-	return __net_gen_cookie(sk ? sk->sk_net.net : &init_net);
-#else
-	return 0;
-#endif
+	if (sk)
+		return __sock_gen_netns_cookie(sk);
+
+	return __net_gen_cookie(&init_net);
 }
 
 BPF_CALL_1(bpf_get_netns_cookie_sock, struct sock *, ctx)
diff --git a/net/core/sock.c b/net/core/sock.c
index bbcd4b97eddd..2db201c210ca 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1606,6 +1606,13 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sk->sk_bound_dev_if;
 		break;
 
+	case SO_NETNS_COOKIE:
+		lv = sizeof(u64);
+		if (len < lv)
+			return -EINVAL;
+		v.val64 = sock_gen_netns_cookie(sk);
+		break;
+
 	default:
 		/* We implement the SO_SNDLOWAT etc to not be settable
 		 * (1003.1g 7).
-- 
2.27.0
