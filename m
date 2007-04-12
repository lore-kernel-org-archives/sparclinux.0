From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 20:35:13 +0000
Subject: Re: sunrpc unaligned access
Message-Id: <20070412.133513.23036266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0703131044400.29530@math>
In-Reply-To: <Pine.SOC.4.64.0703131044400.29530@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 13 Mar 2007 10:48:22 +0200 (EET)

> Tried todays git (2.6.21-rc3-g8b9909de) on Ultra 5 and got this during 
> NFS server startup:
> 
> Kernel unaligned access at TPC[100b8b98] svc_udp_recvfrom+0x180/0x420 [sunrpc]
> 
> Other than that it seems to work fine.

Does this patch make the problem go away?  If not, please send
me the new kernel log message and a copy of the
net/sunrpc/svcsock.o object file from the build.

Thanks!

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 593f62f..2772fee 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -452,6 +452,8 @@ union svc_pktinfo_u {
 	struct in_pktinfo pkti;
 	struct in6_pktinfo pkti6;
 };
+#define SVC_PKTINFO_SPACE \
+	CMSG_SPACE(sizeof(union svc_pktinfo_u))
 
 static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
 {
@@ -491,8 +493,11 @@ svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct socket	*sock = svsk->sk_sock;
 	int		slen;
-	char 		buffer[CMSG_SPACE(sizeof(union svc_pktinfo_u))];
-	struct cmsghdr *cmh = (struct cmsghdr *)buffer;
+	union {
+		struct cmsghdr	hdr;
+		long		all[SVC_PKTINFO_SPACE / sizeof(long)];
+	} buffer;
+	struct cmsghdr *cmh = &buffer.hdr;
 	int		len = 0;
 	int		result;
 	int		size;
@@ -745,8 +750,11 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct svc_serv	*serv = svsk->sk_server;
 	struct sk_buff	*skb;
-	char		buffer[CMSG_SPACE(sizeof(union svc_pktinfo_u))];
-	struct cmsghdr *cmh = (struct cmsghdr *)buffer;
+	union {
+		struct cmsghdr	hdr;
+		long		all[SVC_PKTINFO_SPACE / sizeof(long)];
+	} buffer;
+	struct cmsghdr *cmh = &buffer.hdr;
 	int		err, len;
 	struct msghdr msg = {
 		.msg_name = svc_addr(rqstp),
