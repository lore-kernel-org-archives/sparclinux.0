From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 22:24:23 +0000
Subject: [PATCH v2 09/16] net/sctp: Use in_compat_syscall for sctp_getsockopt_connectx3
Message-Id: <f2dfab45994770860a85edacf90f254952027861.1453759363.git.luto@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

SCTP unfortunately has a different ABI for SCTP_SOCKOPT_CONNECTX3
for 32-bit and 64-bit callers.  Use in_compat_syscall to correctly
distinguish them on all architectures.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9bb80ec4c08f..20ab6b2bbbb9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1389,7 +1389,7 @@ static int sctp_getsockopt_connectx3(struct sock *sk, int len,
 	int err = 0;
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	if (in_compat_syscall()) {
 		struct compat_sctp_getaddrs_old param32;
 
 		if (len < sizeof(param32))
-- 
2.5.0

